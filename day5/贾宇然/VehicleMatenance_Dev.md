# 汽车维修保养记录智能合约开发记录

## 目标：开发汽车维修保养记录的智能合约

## 开发思路
当前车维修保养记录智能合约的基础功能大致可以分为数据更新和数据搜索两类，因此我选择将数据更新函数放在VehicleUpdate中，VehicleQuery继承VehicleUpdate并且拥有我们所需的查询函数

## 1. VehicleUpdate合约结构
### 数据
```
   
    address[] internal ApprovedMaintenanceShop = new address[](1);//授权维修点地址集合
    address internal Administrator;//合约部署者，管理员
    mapping (string => Vehicle) internal  VINtoVehicle;//以车架号对应Vehicle结构体的mapping集合
```

### 自定义结构体
```   
    struct MaintenanceRecord {
        string _remarks;//备注
        string _info;//维修保养的具体信息
        address _MaintenanceShop;//记录维修地点
        uint _time;//记录维修的时间戳
    }

    struct  Vehicle {
        string ManufacturingInfo;//汽车出厂信息
        MaintenanceRecord[] records;//车辆所拥有的维修保养信息
        uint8 initialized;
    }
```

### 修饰函数（提供权限限制）
```
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
```

### 信息更新函数
```
    //增加授权的维修点
    function addApprovedMaintenanceShop(address approvedAddress) public onlyAdministrator(msg.sender){
        ApprovedMaintenanceShop.push(approvedAddress);
    }   

     //出厂信息设置
    function ManufactureInit(string memory VIN, string memory originInfo) public onlyMaintenanceShop(msg.sender) {
        require( VINtoVehicle[VIN].initialized == 0,"The ManufacturingInfo is already initialized");
        VINtoVehicle[VIN].ManufacturingInfo =(originInfo);
        VINtoVehicle[VIN].initialized = 1;
    }
    
    //更新汽车维护信息
    function updateVehicleMaintenance (string memory VIN,string memory remarks,string memory info) public onlyMaintenanceShop(msg.sender){
         Vehicle storage targetcar = VINtoVehicle[VIN];
         require( VINtoVehicle[VIN].initialized == 1,"This VIN is currently invalid,please check the number carefully");
         MaintenanceRecord memory newRecord;
         newRecord._remarks=remarks;
         newRecord._info=info;
         newRecord._MaintenanceShop = msg.sender;
         newRecord._time =now; 
         targetcar.records.push(newRecord);
    }
```
## 2. VehicleQuery合约结构

### 信息更新函数
```
     //获取汽车维护信息
    function getVehicleManufacturingInfo(string memory VIN) public view returns (string memory) {
        Vehicle memory targetcar = VINtoVehicle[VIN];
        require( VINtoVehicle[VIN].initialized == 1,"This VIN is currently invalid,please check the number carefully");
        return targetcar.ManufacturingInfo;
    }
    
    //index为维修记录的下标,获取维修保养注信息
    function getInfo(string memory VIN, uint index) public view returns (string memory) {
        Vehicle memory targetcar = VINtoVehicle[VIN];
        require( VINtoVehicle[VIN].initialized == 1,"This VIN is currently invalid,please check the number carefully");
        return targetcar.records[index]._info;
    }

     //index为维修记录的下标,获取维修点信息
    function getAddress(string memory VIN, uint index) public view returns (address) {
        Vehicle memory targetcar = VINtoVehicle[VIN];
        require( VINtoVehicle[VIN].initialized == 1,"This VIN is currently invalid,please check the number carefully");
        return targetcar.records[index]._MaintenanceShop;
    }
    
     //获取汽车维修记录条数
    function getNumsOfRecords(string memory VIN) public view returns (uint) {
        Vehicle memory targetcar = VINtoVehicle[VIN];
        require( VINtoVehicle[VIN].initialized == 1,"This VIN is currently invalid,please check the number carefully");
        return targetcar.records.length;
    }
    
    //index为维修记录的下标,获取维修备注信息
     function getRemark(string memory VIN, uint index) public view returns (string memory) {
        Vehicle memory targetcar = VINtoVehicle[VIN];
        require( VINtoVehicle[VIN].initialized == 1,"This VIN is currently invalid,please check the number carefully");
        return targetcar.records[index]._remarks;
    }
    
    //index为维修记录的下标,获取维修时间戳信息
    function getTimeStamp(string memory VIN, uint index) public view returns (uint) {
        Vehicle memory targetcar = VINtoVehicle[VIN];
        require( VINtoVehicle[VIN].initialized == 1,"This VIN is currently invalid,please check the number carefully");
        return targetcar.records[index]._time;
    }
```

