pragma solidity >=0.4.22 <0.6.0;

contract LAGCredit {
    string name = "LAGC";
    string symbol = "LAG";
    uint256 totalSupply;
    uint limit = 1000;

    mapping (address => uint256) private balances;
    event transferEvent(address from, address to, uint256 value);
    event removeEvent(address from);

    function _condition(address _from, address _to, uint _value) returns (bool) internal{
        if(_value > limit)
            return false;
    }

    function remove() public {
        totalSupply -= balances[msg.sender];
        balances[msg.sender] = 0;
        emit removeEvent(msg.sender);
    }

    constructor (uint256 initialSupply, string creditName, string creditSymbol) public{
        totalSupply = initialSupply;
        balances[msg.sender]=totalSupply;
        name=creditName;
        symbol=creditSymbol;
        owner = msg.sender;
    }
    
    function getTotalSupply() view public returns (uint256){
        return totalSupply;
    }
    
    function _transfer(address _from, address _to, uint _value) internal{
        
        require(!(_to == 0x0),"The address should be the burning address!");
        require(balances[_from]>=_value,"No enough supply.");
        require(balances[_to]+_value > balances[_to],"Expected a positive value of supply.");
        
        uint previousBalances = balances[_from]+ balances[_to];

        balances[_from] -= _value;
        balances[_to] += _value;
        
        emit transferEvent(_from,_to,_value);
        assert(balances[_from]+balances[_to] == previousBalances);
        
    }
    
    function transfer(address _to, uint256 _value) public {
        _transfer(msg.sender, _to, _value);
    }
    
    function balanceOf(address _owner) view public returns(uint256){
        return balances[_owner];
    }
    
}