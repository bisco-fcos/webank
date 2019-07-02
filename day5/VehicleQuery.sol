pragma solidity >=0.4.22 <0.6.0;

import "./VehicleUpdate.sol";
import "./ERC721.sol";

contract VehicleQuery is VehicleUpdate , ERC721 {
    
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
    
    
  
}
