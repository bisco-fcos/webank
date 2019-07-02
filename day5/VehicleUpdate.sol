pragma solidity >=0.4.22 <0.6.0;



contract VehicleUpdate {
    
    address[]  internal ApprovedMaintenanceShop = new address[](0);//授权维修点地址集合
    address internal Administrator;//合约部署者，管理员
    
    uint internal carCount = 0;
    mapping (uint => Vehicle) internal  cars;
    //以车架号对应车辆索引
    mapping (string => uint) internal  VINtoVehicle;
    // 车辆索引对应主人地址
    mapping (uint => address) internal carToOwner;
    // 车主拥有车辆计数
    mapping (address => uint) ownerCarCount;
    mapping (string => bool) public VINExist;
    
    constructor () public{
        ApprovedMaintenanceShop.push(msg.sender);
        Administrator = msg.sender;
    }
    
    // 保养记录类
    struct MaintenanceRecord {
        string _remarks;//备注
        string _info;//维修保养的具体信息
        address _MaintenanceShop;//记录维修地点
        uint _time;
    }
    
    
    // 车辆类
    struct  Vehicle {
        // 车架号
        string VIN;
        string ManufacturingInfo;//汽车出厂信息
        MaintenanceRecord[] records;//车辆所拥有的维修保养信息
    }
    
    
    //只有允许的维修点才能执行的修饰函数
    modifier onlyMaintenanceShop(address){
        bool label=false;
        for(uint cnt;cnt<ApprovedMaintenanceShop.length;cnt++)
        {
            if(msg.sender == ApprovedMaintenanceShop[cnt])
                label = true;
        }
        require(label == true,"This function can only be exerted by the MaintenanceShop");
        _;
    }
    
    // 只有车主才有车的交易权
    modifier onlyOwnerOfCar(string memory VIN) {
        uint carID = VINtoVehicle[VIN];
        require(msg.sender == carToOwner[carID],"This function can only be operated by the Car-Holder.");
        _;
    }

    //只有管理员才能执行的修饰函数
     modifier onlyAdministrator(address){
         require(msg.sender == Administrator,"This function can only be exerted by the Administrator");
        _;
    }
    
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
        
        //目前先将出厂信息调用者设为车主
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
}
