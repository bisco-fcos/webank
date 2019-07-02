pragma solidity >=0.4.22 <0.6.0;

import "./VehicleUpdate.sol";
import "./erc721.sol";

contract VehicleQuery is VehicleUpdate , ERC721 {
    
     //获取汽车维护信息
    function getVehicleManufacturingInfo(string memory VIN) public view returns (string memory) {
        bool exist = VINExist[VIN];
         require( exist == true,"This VIN is currently invalid,please check the number carefully");
         uint carindex = VINtoVehicle[VIN];
        Vehicle memory targetcar = cars[carindex];
        return targetcar.ManufacturingInfo;
    }
   
    //index为维修记录的下标,获取维修保养注信息
    function getInfo(string memory VIN, uint index) public view returns (string memory) {
        bool exist = VINExist[VIN];
         require( exist == true,"This VIN is currently invalid,please check the number carefully");
         uint carindex = VINtoVehicle[VIN];
        Vehicle memory targetcar = cars[carindex];
        require(index< targetcar.records.length, "record index out of limit!");
        return targetcar.records[index]._info;
    }
     
     //index为维修记录的下标,获取维修点信息
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
    
    function getTotalInfo(string memory VIN, uint index) public view returns (string memory,string memory,address,uint) {
        bool exist = VINExist[VIN];
         require( exist == true,"This VIN is currently invalid,please check the number carefully");
         uint carindex = VINtoVehicle[VIN];
        Vehicle memory targetcar = cars[carindex];
        require(index< targetcar.records.length, "record index out of limit!");
        return (targetcar.records[index]._info,targetcar.records[index]._remarks,targetcar.records[index]._MaintenanceShop,targetcar.records[index]._time);
    }
    
    
    mapping (uint => address) carApprovals;
    
    function balanceOf(address _owner) public view returns (uint256 _balance) {
        return ownerCarCount[_owner];
    }
    
    function ownerOf(uint256 _tokenId) public view returns (address _owner) {
        require( _tokenId < carCount ,"This tokenID is currently invalid,please check the number carefully");
        return carToOwner[_tokenId];
    }
    
    function _transfer(address _from, address _to, uint256 _tokenId) private {
        require( _tokenId < carCount ,"This tokenID is currently invalid,please check the number carefully");
        ownerCarCount[_to]++;
        ownerCarCount[_from]--;
        carToOwner[_tokenId] = _to;
        emit Transfer(_from, _to, _tokenId);
    }
    
    function transfer(address _to, uint256 _tokenId) public onlyOwnerOfCar(_tokenId) {
        require( _tokenId < carCount ,"This tokenID is currently invalid,please check the number carefully");
        _transfer(msg.sender, _to, _tokenId);
    }
    
    function approve(address _to, uint256 _tokenId) public onlyOwnerOfCar(_tokenId) {
        require( _tokenId < carCount,"This tokenID is currently invalid,please check the number carefully");
        carApprovals[_tokenId] = _to;
        emit Approval(msg.sender, _to, _tokenId);
    }
    
    function takeOwnership(uint256 _tokenId) public {
        require( _tokenId < carCount ,"This tokenID is currently invalid,please check the number carefully");
        require(carApprovals[_tokenId] == msg.sender);
        address owner = ownerOf(_tokenId);
        _transfer(owner, msg.sender, _tokenId);
    }
}

