pragma solidity >=0.4.22 <0.6.0;


contract ERC721 {
    
  event Transfer(address indexed _from, address indexed _to, uint256 _tokenId);
  event Approval(address indexed _owner, address indexed _approved, uint256 _tokenId);

  function balanceOf(address _owner) public view returns (uint256 _balance);
  function ownerOf(string memory VIN) public view returns (address _owner);
  function transfer(address _to, string memory VIN) public;
  function approve(address _to, string memory VIN) public;
  function takeOwnership(string memory VIN) public;
}
