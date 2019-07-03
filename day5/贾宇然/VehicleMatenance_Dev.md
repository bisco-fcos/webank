# 汽车维修保养记录智能合约开发记录

## 目标：开发汽车维修保养记录的智能合约

## 开发思路
当前车维修保养记录智能合约的基础功能大致可以分为数据更新和数据搜索两类，因此我选择将数据更新函数放在VehicleUpdate中，VehicleQuery继承VehicleUpdate并且拥有我们所需的查询函数。随后添加的汽车所有权相关的

## 1. VehicleUpdate合约结构
### 数据
```solidity
    address[]  internal ApprovedMaintenanceShop = new address[](0);//授权维修点地址集合
    address internal Administrator;//合约部署者，管理员
    
    //记录当前合约所拥有的汽车数目
    uint internal carCount = 0;
    //以uint索引对应Vehivle结构体
    mapping (uint => Vehicle) internal  cars;
    //以车架号对应车辆索引
    mapping (string => uint) internal  VINtoVehicle;
    // 车辆索引对应主人地址的
    mapping (uint => address) internal carToOwner;
    // 车主拥有车辆计数
    mapping (address => uint) ownerCarCount;
    mapping (string => bool) public VINExist;
```

### 自定义结构体
```solidity
    // 保养记录类
    struct MaintenanceRecord {
        string _remarks;//备注
        string _info;//维修保养的具体信息
        address _MaintenanceShop;//记录维修地点
        uint _time;//记录维修的时间戳
    }
    // 车辆类
    struct  Vehicle {       
        string VIN; // 车架号
        string ManufacturingInfo;//汽车出厂信息
        MaintenanceRecord[] records;//车辆所拥有的维修保养信息
    }
```

### 修饰函数（提供权限限制）
```solidity
    //修饰函数，用于修饰只有允许的维修点才能执行的函数，即维修点级权限
    modifier onlyMaintenanceShop(address){
        uint label=0;
        for(uint cnt;cnt<ApprovedMaintenanceShop.length;cnt++)
        {
            if(msg.sender == ApprovedMaintenanceShop[cnt])
            label++;
        }
         require(label == 1,"This function can only be exerted by the MaintenanceShop");
        _;
    }
    
     //修饰函数，用于修饰只有管理员才能执行的函数，即管理员级权限
     modifier onlyAdministrator(address){
         require(msg.sender == Administrator,"This function can only be exerted by the Administrator");
        _;
    }

    // 只有车主才有车的交易权限
    modifier onlyOwnerOfCar(string memory VIN) {
        uint carID = VINtoVehicle[VIN];
        require(msg.sender == carToOwner[carID],"This function can only be operated by the Car-Holder.");
        _;
    }
```

### 信息更新函数
```solidity
    //增加授权的维修点
    function addApprovedMaintenanceShop(address approvedAddress) public onlyAdministrator(msg.sender){
        ApprovedMaintenanceShop.push(approvedAddress);
    }   

     //出厂信息设置
     function ManufactureInit(string memory VIN, string memory originInfo) public onlyMaintenanceShop(msg.sender) returns(bool) {
        bool exist = VINExist[VIN];
        require( exist == false,"The ManufacturingInfo is already initialized");
        
        uint index = carCount;
        carCount += 1;
        VINtoVehicle[VIN] = index;
        
        Vehicle storage car = cars[index];
        VINExist[VIN] = true;
        
        car.ManufacturingInfo =originInfo;
        ownerCarCount[msg.sender] += 1;
        
        //汽车出厂初始化信息时，汽车拥有者为4S店，售出时进行所有权转让
        carToOwner[index] = msg.sender;        
        return true;
    }
    
    //更新汽车维护信息
    function updateVehicleMaintenance (string memory VIN,string memory remarks,string memory info) public onlyMaintenanceShop(msg.sender) returns (bool){
         bool exist = VINExist[VIN];
         require( exist == true,"This VIN is currently invalid,please check the number carefully");
         uint index = VINtoVehicle[VIN];
         Vehicle storage targetcar = cars[index];
         MaintenanceRecord memory newRecord;
         newRecord._remarks=remarks;
         newRecord._info=info;
         newRecord._MaintenanceShop = msg.sender;
         newRecord._time =now; 
         targetcar.records.push(newRecord);
         
         return true;
    }
```
## 2. VehicleQuery合约结构

### 遇到的问题
为了返回合约内存储的汽车维修信息，我原本打算通过返回Vehicle结构体的方式来完成数据的获取。Remix编译器,中这种返回形式需要我们声明 **pragma experimental ABIEncoderV2** 才能开启这种特性，果不其然，无论是SpringBootStarter还是FISCO BCOS控制台提供的智能合约编译工具都会对此报错,信息如下：
![](https://github.com/marknash666/FiscoBcos-Exercises/blob/master/images/image-for-vehicle/vehicle_dev1.png)

因此最后选择将维修记录信息通过4元组的形式返回，后端会遍历Vehicle的Records数组，循环获取汽车的所有维修记录

### 信息更新函数
```solidity
     //获取对应VIN号的汽车信息的存在性
    function getExistence(string memory VIN) public view returns (bool) {
        bool exist = VINExist[VIN];
        return exist;
    }

     //获取汽车出厂信息
    function getVehicleManufacturingInfo(string memory VIN) public view returns (string memory) {
        bool exist = VINExist[VIN];
         require( exist == true,"This VIN is currently invalid,please check the number carefully");
         uint carindex = VINtoVehicle[VIN];
        Vehicle memory targetcar = cars[carindex];
        return targetcar.ManufacturingInfo;
    }
   
    //index为维修记录的下标,获取维修保养信息
    function getInfo(string memory VIN, uint index) public view returns (string memory) {
        bool exist = VINExist[VIN];
         require( exist == true,"This VIN is currently invalid,please check the number carefully");
         uint carindex = VINtoVehicle[VIN];
        Vehicle memory targetcar = cars[carindex];
        require(index< targetcar.records.length, "record index out of limit!");
        return targetcar.records[index]._info;
    }
     
     //index为维修记录的下标,获取维修点区块链地址
    function getAddress(string memory VIN, uint index) public view returns (address) {
        bool exist = VINExist[VIN];
         require( exist == true,"This VIN is currently invalid,please check the number carefully");
         uint carindex = VINtoVehicle[VIN];
        Vehicle memory targetcar = cars[carindex];
        require(index< targetcar.records.length, "record index out of limit!");
        return targetcar.records[index]._MaintenanceShop;
    }
    
     //获取汽车维修记录条数
    function getNumsOfRecords(string memory VIN) public view returns (uint) {
        bool exist = VINExist[VIN];
         require( exist == true,"This VIN is currently invalid,please check the number carefully");
         uint carindex = VINtoVehicle[VIN];
        Vehicle memory targetcar = cars[carindex];
        return targetcar.records.length;
    }
    
    //index为维修记录的下标,获取维修备注信息
    function getRemark(string memory VIN, uint index) public view returns (string memory) {
        bool exist = VINExist[VIN];
         require( exist == true,"This VIN is currently invalid,please check the number carefully");
         uint carindex = VINtoVehicle[VIN];
        Vehicle memory targetcar = cars[carindex];
        require(index< targetcar.records.length, "record index out of limit!");
        return targetcar.records[index]._remarks;
    }
    //index为维修记录的下标,获取维修时间戳信息
    function getTimeStamp(string memory VIN, uint index) public view returns (uint) {
        bool exist = VINExist[VIN];
        require( exist == true,"This VIN is currently invalid,please check the number carefully");
        uint carindex = VINtoVehicle[VIN];
        Vehicle memory targetcar = cars[carindex];
        require(index< targetcar.records.length, "record index out of limit!");
        return targetcar.records[index]._time;
    }
    
     //index为维修记录的下标,获取该条维修记录的所有信息
    function getTotalInfo(string memory VIN, uint index) public view returns (string memory,string memory,address,uint) {
        bool exist = VINExist[VIN];
         require( exist == true,"This VIN is currently invalid,please check the number carefully");
         uint carindex = VINtoVehicle[VIN];
        Vehicle memory targetcar = cars[carindex];
        require(index< targetcar.records.length, "record index out of limit!");
        return (targetcar.records[index]._info,targetcar.records[index]._remarks,targetcar.records[index]._MaintenanceShop,targetcar.records[index]._time);
    }
```

## 3. VehicleOwnerShip合约结构

### 遇到的问题


### 权限交易函数
```solidity
    mapping (uint => address) carApprovals;
    
    //
    function balanceOf(address _owner) public view returns (uint256 _balance) {
        return ownerCarCount[_owner];
    }
    
    function ownerOf(string memory VIN) public view returns (address _owner) {
        bool exist = VINExist[VIN];
        uint _tokenId = VINtoVehicle[VIN]; 
        require( exist== true ,"This VIN is currently invalid,please check the number carefully");
        return carToOwner[_tokenId];
    }
    
    function _transfer(address _from, address _to, uint _tokenId) private {
        require( _tokenId < carCount ,"This tokenID is currently invalid,please check the number carefully");
        ownerCarCount[_to]++;
        ownerCarCount[_from]--;
        carToOwner[_tokenId] = _to;
        emit Transfer(_from, _to, _tokenId);
    }
    
    function transfer(address _to,  string memory VIN) public onlyOwnerOfCar(VIN) {
        uint _tokenId = VINtoVehicle[VIN]; 
        bool exist = VINExist[VIN];
        require( exist==true ,"This VIN is currently invalid,please check the number carefully");
        _transfer(msg.sender, _to, _tokenId);
    }
    
    function approve(address _to, string memory VIN) public onlyOwnerOfCar(VIN) {
        uint _tokenId = VINtoVehicle[VIN]; 
        bool exist = VINExist[VIN];
        require( exist==true,"This VIN is currently invalid,please check the number carefully");
        carApprovals[_tokenId] = _to;
        emit Approval(msg.sender, _to, _tokenId);
    }
    
    function takeOwnership(string memory VIN) public {
        uint _tokenId = VINtoVehicle[VIN]; 
        bool exist = VINExist[VIN];
        require( exist==true ,"This VIN is currently invalid,please check the number carefully");
        require(carApprovals[_tokenId] == msg.sender,"Only the aprroved address can take the Ownership");
        address owner = ownerOf(VIN);
        _transfer(owner, msg.sender, _tokenId);
    }
```

