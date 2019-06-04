

### 1. 查看区块数目

![](https://github.com/zedom1/FISCO-BCOS/blob/master/Exercise/1/Pictures/1.PNG?raw=true)

通过 getBlockNumber获取区块总数

### 2. 查看区块数据

![](https://github.com/zedom1/FISCO-BCOS/blob/master/Exercise/1/Pictures/2.PNG?raw=true)

使用getBlockByNumber + id 获取特定索引块的数据

### 3. 部署智能合约

![](https://github.com/zedom1/FISCO-BCOS/blob/master/Exercise/1/Pictures/3.PNG?raw=true)

使用deploy命令部署sol格式的智能合约，这里使用了HelloWorld的样例合约

### 4. 查看部署日志

![](https://github.com/zedom1/FISCO-BCOS/blob/master/Exercise/1/Pictures/4.PNG?raw=true)

使用getDeployLog命令查看历史部署日志

### 5. 查看部署后的块数

![](https://github.com/zedom1/FISCO-BCOS/blob/master/Exercise/1/Pictures/5.PNG?raw=true)

部署后总的块数加1

### 6. 查看最近部署的块数据

![](https://github.com/zedom1/FISCO-BCOS/blob/master/Exercise/1/Pictures/6.PNG?raw=true)

### 7. 调用智能合约 - get

![](https://github.com/zedom1/FISCO-BCOS/blob/master/Exercise/1/Pictures/7.PNG?raw=true)

使用call + 合约名 + 合约hash + 具体命令 来调用智能合约，这里查看合约的内容，使用get命令

### 8. 调用智能合约 - set

![](https://github.com/zedom1/FISCO-BCOS/blob/master/Exercise/1/Pictures/8.PNG?raw=true)

使用set命令新建一个块

### 9. 查看 set后的块数目

![](https://github.com/zedom1/FISCO-BCOS/blob/master/Exercise/1/Pictures/9.PNG?raw=true)

set后总的块数+1

### 10. 查看最新块的数据

![](https://github.com/zedom1/FISCO-BCOS/blob/master/Exercise/1/Pictures/10.PNG?raw=true)

### 11. 使用CNS部署新版本的智能合约

![](https://github.com/zedom1/FISCO-BCOS/blob/master/Exercise/1/Pictures/11.PNG?raw=true)

使用deployByCNS + 合约名 + 版本号 部署新版本的合约

### 12. 获取部署后块的数目

![](https://github.com/zedom1/FISCO-BCOS/blob/master/Exercise/1/Pictures/12.PNG?raw=true)

### 13. 查看最新块的数据

![](https://github.com/zedom1/FISCO-BCOS/blob/master/Exercise/1/Pictures/13.PNG?raw=true)

### 14. 使用queryCNS查看通过CNS部署的历史版本

![](https://github.com/zedom1/FISCO-BCOS/blob/master/Exercise/1/Pictures/14.PNG?raw=true)

使用queryCNS + 合约名 查看该合约历史通过CNS部署的版本和地址

### 15. 使用CNS调用智能合约

![](https://github.com/zedom1/FISCO-BCOS/blob/master/Exercise/1/Pictures/15.PNG?raw=true)

使用callByCNS + 合约名：版本号 + 具体命令来调用合约