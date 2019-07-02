pragma solidity >=0.4.22 <0.6.0;

import "./VehicleQuery.sol";

contract VehicleOwnership is VehicleQuery {
    
       mapping (uint => address) carApprovals;
    
    function balanceOf(address _owner) public view returns (uint256 _balance) {
        return ownerCarCount[_owner];
    }
    
    function ownerOf(string memory VIN) public view returns (address _owner) {
        uint _tokenId = VINtoVehicle[VIN]; 
        require( _tokenId < carCount ,"This tokenID is currently invalid,please check the number carefully");
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
        require( _tokenId < carCount ,"This tokenID is currently invalid,please check the number carefully");
        _transfer(msg.sender, _to, _tokenId);
    }
    
    function approve(address _to, string memory VIN) public onlyOwnerOfCar(VIN) {
        uint _tokenId = VINtoVehicle[VIN]; 
        require( _tokenId < carCount,"This tokenID is currently invalid,please check the number carefully");
        carApprovals[_tokenId] = _to;
        emit Approval(msg.sender, _to, _tokenId);
    }
    
    function takeOwnership(string memory VIN) public {
        uint _tokenId = VINtoVehicle[VIN]; 
        require( _tokenId < carCount ,"This tokenID is currently invalid,please check the number carefully");
        require(carApprovals[_tokenId] == msg.sender);
        address owner = ownerOf(VIN);
        _transfer(owner, msg.sender, _tokenId);
    }
}
