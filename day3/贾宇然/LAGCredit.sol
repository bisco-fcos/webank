pragma solidity >=0.4.22 <0.6.0;

contract LAGCredit {
    string name = "LAGC";
    string symbol = "LAG";
    uint256 totalSupply;
    uint256 sale = 1;
    address contract_holder;
    mapping (address => uint256) private balances;
    
    modifier onlyOwner(address){
        require(msg.sender==contract_holder);
        _;
    }
    
    event transferEvent(address from, address to,uint256 value);
    
    constructor (uint256 initialSupply, string creditName,string creditSymbol) public{
        totalSupply =initialSupply;
        balances[msg.sender]=totalSupply;
        name=creditName;
        symbol=creditSymbol;
        contract_holder=msg.sender;
    }
    
    function getTotalSupply() view public returns (uint256){
        return totalSupply;
    }
    
    function addSupply(uint256 amountofSupply) public onlyOwner(msg.sender) {
        totalSupply= amountofSupply+totalSupply;
        balances[msg.sender] += amountofSupply;
    }
    
    function _transfer(address _from,address _to,uint _value) internal{
        
        require(!(_to == 0x0),"The address should be the burning address!");
        require(balances[_from]>=_value,"No enough supply.");
        require(balances[_to]+_value > balances[_to],"Expected a positive value of supply.");
        
        uint previousBalances = balances[_from]+ balances[_to];
        if(msg.sender==contract_holder)
        _value=_value*sale;
        
        balances[_from] -= _value;
        balances[_to] += _value;
        
        emit transferEvent(_from,_to,_value);
        assert(balances[_from]+balances[_to] == previousBalances);
        
    }
    
    function transfer(address _to, uint256 _value) public {
        _transfer(msg.sender,_to,_value);
    }
    
    function balanceOf(address _owner) view public returns(uint256){
        return balances[_owner];
    }
    
    function getContractOwner() view public returns(address){
        return contract_holder;
    }
    
    function setSale(uint256 new_sale) public onlyOwner(msg.sender){
        sale=new_sale;
    }
    
    function getSale() view public returns(uint256) {
        return sale;
    }
}