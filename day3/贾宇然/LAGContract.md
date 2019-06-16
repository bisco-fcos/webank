# LAGCredit合约阅读分析

## 代码分析
1. 数据、事件定义
```
string name = "LAGC";//默认积分名称
string symbol = "LAG";//默认积分代号
uint256 totalSupply;//积分总量
mapping (address => uint256) private balances;//记录账号持有积分数目的结构体 key为address，value为uint256
event transferEvent(address from, address to,uint256 value);//定义了一个名为transferEvent的事件，该事件会被Web3.js监听并作出响应

```

2. 构造函数
```
constructor (uint256 initialSupply, string creditName,string creditSymbol) public{
        totalSupply =initialSupply;//初始化积分总量
        balances[msg.sender]=totalSupply;//初始化合约持有者的积分数
        name=creditName;//初始化积分名称
        symbol=creditSymbol;//初始化积分代号        
    }
```

3. getTotalSupply
```
function getTotalSupply() view public returns (uint256){
        return totalSupply;//用于查看当前积分总量的函数
    }
```

4. getTotalSupply
```
function _transfer(address _from,address _to,uint _value) internal{
        
        require(!(_to == 0x0));
        require(balances[_from]>=_value);
        require(balances[_to]+_value > balances[_to]);
        
        uint previousBalances = balances[_from]+ balances[_to];
        
        balances[_from] -= _value;
        balances[_to] += _value;
        
        emit transferEvent(_from,_to,_value);
        assert(balances[_from]+balances[_to] == previousBalances);
        
    }
```