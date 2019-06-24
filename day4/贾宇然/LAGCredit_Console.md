# LAGCredit合约功能验证

### 前置：合约的编写和初步功能验证已经在remix在线编译器上完成

### 目标：使用FISCO BCOS提供的的console来部署LAGCredit合约并检查其功能的正确性

### 虚拟用户
为了测试功能，我们首先需要运行get_account.sh脚本来获得虚拟用户的信息，包括账户地址、账户私钥文件pem和hex类型的私钥
```
[INFO] Account Address   : 0x13c0f151d04a510155e178f0a5059ac6bdbce571
[INFO] Private Key (pem) : accounts/0x13c0f151d04a510155e178f0a5059ac6bdbce571.pem
[INFO] Private Key: 0x9545b46d55631c075d4eaf1e6bbc29ee995cd16e2e5783943876e033e9ebc4ea
```
### 控制台的使用（指定用户）
查看官方文档

>#### 启动控制台：
>```bash
>$ ./start.sh [groupId] [privateKey]   
>```
>启动命令可以指定两个可选参数：           
>- `groupId`: 群组ID, 不指定则默认为`applicationContext.xml`文件中`channelService`配置的groupId。           
>- `privateKey`: 交易发送者外部账号的私钥，不指定则默认从`conf`目录下的privateKey.properties中读取私钥，如果该文件内容被清空，则随机生成外部账号私钥并将生产的私钥保持在该私钥配置文件中。 <br />
>示例
>```bash
># 以群组2，私钥账号地址为3bed914595c159cbce70ec5fb6aff3d6797e0c5ee5a7a9224a21cae8932d84a4登录控制台
>$ ./start.sh 2 3bed914595c159cbce70ec5fb6aff3d6797e0c5ee5a7a9224a21cae8932d84a4  
>```
### 功能验证
```
商家地址：0x4f42a3c513a9411954c193a50b1c4ab5393cb20b<br />
商家私钥(hex)：0x9099ffe712c486fd0f255844de197b8c763f38ca542ba3038974dc04b3ae48ec<br /><br />

顾客1地址：0x9c97ba257d5188c78adf6c5e1deab3a33da140ad<br />
顾客1私钥(hex)：0x1f8878ee6cbfe6fed572994cba03e1bf64c927efd92053df228c71389aadc562
```

1. 分别用两者的私钥启动控制台<br />
![](https://github.com/marknash666/FiscoBcos-Exercises/blob/master/images/image-for-console/console_1.png)
2. 采用CNS的方式部署合约，初始积分发放总量设为10000<br />
![](https://github.com/marknash666/FiscoBcos-Exercises/blob/master/images/image-for-console/deploy.png)
DeployByCNS的合約部署格式为：DeployByCNS + 合约名 +合约版本 + 构造函数参数

3. 测试合约的基础功能
![](https://github.com/marknash666/FiscoBcos-Exercises/blob/master/images/image-for-console/function_1.png)
调用addSupply增加250个积分，结果正确

3. 测试sale为默认值时的商店积分赠送情况
![](https://github.com/marknash666/FiscoBcos-Exercises/blob/master/images/image-for-console/function_2.png)
向顾客1传送550个积分，结果正确

3. 设置sale为2并测试此时的商店积分赠送情况
![](https://github.com/marknash666/FiscoBcos-Exercises/blob/master/images/image-for-console/function_3.png)
设置当前商店赠送积分倍数为2，向顾客1传送1000个积分。顾客1实际收到2000个积分，结果正确。
3. 查看用户之间的积分传递情况
![](https://github.com/marknash666/FiscoBcos-Exercises/blob/master/images/image-for-console/function_3.png)
顾客1向一个新顾客发送100积分，新顾客实际收到100个积分，不受sale影响，结果正确



