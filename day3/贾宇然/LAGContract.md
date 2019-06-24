# LAGCredit合约阅读分析与功能添加

## 代码分析
1. 数据、事件定义
```solidity
string name = "LAGC";//默认积分名称
string symbol = "LAG";//默认积分代号
uint256 totalSupply;//积分总量
mapping (address => uint256) private balances;//记录账号持有积分数目的结构体(key为address，value为uint256)
event transferEvent(address from, address to,uint256 value);//定义了一个名为transferEvent的事件，该事件会被Web3.js监听并作出响应
```

2. 构造函数
```solidity
constructor (uint256 initialSupply, string creditName,string creditSymbol) public{
        totalSupply =initialSupply;//初始化积分总量
        balances[msg.sender]=totalSupply;//初始化合约持有者的积分数
        name=creditName;//初始化积分名称
        symbol=creditSymbol;//初始化积分代号        
    }
```

3. getTotalSupply
```solidity
function getTotalSupply() view public returns (uint256){
        return totalSupply;//用于查看当前积分总量的函数
    }
```

4. _transfer(internal的传递执行体)
```solidity
function _transfer(address _from,address _to,uint _value) internal{        
        require(!(_to == 0x0));//防止积分被送进焚烧地址
        require(balances[_from]>=_value);//确保执行者拥有的积分大于传递的积分数值
        require(balances[_to]+_value > balances[_to]);//确保传递的积分数值大于0
        
        uint previousBalances = balances[_from]+ balances[_to];//记录传递执行前两个账户的积分总额
        
        balances[_from] -= _value;//积分送出者积分减少
        balances[_to] += _value;//积分获得者积分增加
        
        emit transferEvent(_from,_to,_value);//激活积分传递事件
        assert(balances[_from]+balances[_to] == previousBalances);//假如传递执行后两个帐户的积分总额与此前不一则出现重大错误，回滚        
    }
```

5. transfer(封装了内部执行的积分传递函数)
```solidity
function transfer(address _to, uint256 _value) public {
        _transfer(msg.sender,_to,_value);//将调用者的地址并与其余两个参数传给实际执行体
    }
```

6. balanceOf
```solidity
 function balanceOf(address _owner) view public returns(uint256){
        return balances[_owner];//查看传入地址所拥有的积分数
    }
```

## 功能添加
1. 积分总量增加</br>
**构思：积分总量的添加只能由合约持有者进行操作，因此考虑增加修饰函数和一个储存合约持有者地址的数据，在执行添加操作前判断是否为合约持有者**</br>
**具体实现：**</br>

以下是新增加的代码
```solidity
address contract_holder;//储存合约持有者的地址

modifier onlyOwner(address){
        require(msg.sender==contract_holder);//只能合约持有者进行操作的修饰函数
        _;
    }

function addSupply(uint256 amountofSupply) public onlyOwner(msg.sender) {
        totalSupply= amountofSupply+totalSupply;//修改积分发放总量
        balances[msg.sender] += amountofSupply;//增加合约持有者的积分
    }

 function getContractOwner() view public returns(address){
        return contract_holder;//增加一个查看合约持有者地址的函数
    }
```
以下是对构造函数的修改
```solidity
constructor (uint256 initialSupply, string creditName,string creditSymbol) public{
        totalSupply =initialSupply;
        balances[msg.sender]=totalSupply;
        name=creditName;
        symbol=creditSymbol;
        contract_holder=msg.sender;//构造函数中添加合约持有者地址的初始化
    }
```

2. 允许商家进行积分发放活动</br>
**构思：积分优惠活动指的是商家可以在活动期间为前来消费的消费者发送更多的积分，优惠的设置只能被合约持有者操控**</br>
**具体实现：**</br>
以下是新增加的代码
```solidity
uint256 sale = 1;//储存优惠倍数，默认为1

function setSale(uint256 new_sale) public onlyOwner(msg.sender){
        sale=new_sale;//设置新的优惠倍数，只能由合约持有者操控
    }
    
    function getSale() view public returns(uint256) {
        return sale;//允许任何人查看当前优惠
    }
```
以下是对_transfer函数的修改
```solidity
function _transfer(address _from,address _to,uint _value) internal{
        
        require(!(_to == 0x0),"The address shouldn't be the burning address!");
        require(balances[_from]>=_value,"No enough supply.");
        require(balances[_to]+_value > balances[_to],"Expected a positive value of supply.");
        
        uint previousBalances = balances[_from]+ balances[_to];
        if(msg.sender==contract_holder)//增加判断
        _value=_value*sale;//当传出积分者为合约持有者的时候应用优惠政策
        
        balances[_from] -= _value;
        balances[_to] += _value;
        
        emit transferEvent(_from,_to,_value);
        assert(balances[_from]+balances[_to] == previousBalances);
        
    }
```
