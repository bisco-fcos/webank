# LAGCredit在SpringBoot环境下的接口开发
### JSON依赖添加
```
compile 'net.sf.json-lib:json-lib:2.4:jdk15'
```
加入依赖后IDEA会自动下载包括FastJSON在内的jar包。在实际使用时，需要注意的是fastjson和net.sf.json的JSONObject的String转换方法有区别（前者为toJSONString,后者则是简单的toString）。

## 接口开发
**以下接口返回的信息只作展示用**
### 合约部署
用户可以通过`/deploy`路径来部署合约，部署成功则会返回合约的地址
![](https://github.com/marknash666/FiscoBcos-Exercises/blob/master/images/image-for-springboot/interface_dev2.png)

### 积分传输
积分的传输需要用户在`/transfer`路径下提供三个参数（对应transfer函数所需的参数），积分传递成功的话则会返回积分送出者和接受者各自的积分信息
![](https://github.com/marknash666/FiscoBcos-Exercises/blob/master/images/image-for-springboot/interface_dev3.png)
`此处应为post，为了易于展示先以GET方式进行数据传递`
### 当前积分查看
通过`/getCurrentSupply`,用户可以获得自己账户下的积分信息
```
合约部署者地址：0x4f42a3c513a9411954c193a50b1c4ab5393cb20b
合约部署者私钥(hex)：0x9099ffe712c486fd0f255844de197b8c763f38ca542ba3038974dc04b3ae48ec

用户地址：0x9c97ba257d5188c78adf6c5e1deab3a33da140ad
用户私钥(hex)：0x1f8878ee6cbfe6fed572994cba03e1bf64c927efd92053df228c71389aadc562
```
1. 这是合约部署者调用的getCurrentSupply
![](https://github.com/marknash666/FiscoBcos-Exercises/blob/master/images/image-for-springboot/interface_dev4.png)

2. 修改SpringBoot的user key为刚才接受积分的用户的私钥并启动，调用本接口则会得到
![](https://github.com/marknash666/FiscoBcos-Exercises/blob/master/images/image-for-springboot/interface_dev5.png)
`本功能的实现需要在合约中添加一个返回当前账号积分总数的函数`
