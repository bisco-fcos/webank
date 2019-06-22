### LAGCredit合约阅读分析与功能添加

#### 代码阅读

##### 定义数据和事件

```
    string name = "LAGC";
    string symbol = "LAG";
    // 积分总额
    uint256 totalSupply;
    // 地址到积分的映射
    mapping (address => uint256) private balances;
    // 交易事件，通知web3.js
    event transferEvent(address from, address to, uint256 value);
    
```

##### 定义函数

```
	// 获取总积分，只读函数，不消耗gas
    function getTotalSupply() view public returns (uint256){
        return totalSupply;
    }
    
    // 内部的交易执行函数
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
    
    // 提供给外部的交易接口
    function transfer(address _to, uint256 _value) public {
        _transfer(msg.sender, _to, _value);
    }
    
    // 提供给外部的查询接口，查询积分余额
    function balanceOf(address _owner) view public returns(uint256){
        return balances[_owner];
    }
```

#### 增加功能

1. 增加条件函数，样例为单次交易限额上限为1000

2. 增加销户函数，用户可以消去自己账号内的所有积分。

##### 新增数据：

```
	// 单次交易限额
    uint limit = 1000;
    // 删除事件，通知web3.js
    event removeEvent(address from);
```

##### 新增函数:

```
    // 交易条件，满足了条件才会执行交易
    function _condition(address _from, address _to, uint _value) returns (bool) internal{
        if(_value > limit)
            return false;
        return true;
    }

    // 销户函数
    function remove() public {
        totalSupply -= balances[msg.sender];
        balances[msg.sender] = 0;
        emit removeEvent(msg.sender);
    }

    // 修改后的构造函数，增加设定owner
    constructor (uint256 initialSupply, string creditName, string creditSymbol) public{
        totalSupply = initialSupply;
        balances[msg.sender]=totalSupply;
        name=creditName;
        symbol=creditSymbol;
    }
    
    // 内部的交易执行函数
    function _transfer(address _from, address _to, uint _value) internal{
        require(!(_to == 0x0),"The address should be the burning address!");
        require(balances[_from]>=_value,"No enough supply.");
        require(balances[_to]+_value > balances[_to],"Expected a positive value of supply.");
        
        // 新增，要求满足条件才执行
        require(_condition(_from, _to, _value)==true);

        uint previousBalances = balances[_from]+ balances[_to];

        balances[_from] -= _value;
        balances[_to] += _value;
        
        emit transferEvent(_from,_to,_value);
        assert(balances[_from]+balances[_to] == previousBalances);
    }
```