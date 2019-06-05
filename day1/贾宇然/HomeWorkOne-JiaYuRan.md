
## 1. 查看区块高度
![](https://github.com/marknash666/FiscoBcos-ExerciseOne/blob/master/image-ExerciseOne/1.png?raw=true)
通过getBlockNumber得到区块的高度

## 2. 查看区块高度
![](https://github.com/marknash666/FiscoBcos-ExerciseOne/blob/master/image-ExerciseOne/block0.png?raw=true)
通过getBlockByNumber + block_num 得到区块的数据

## 3. 部署HelloWorld智能合约
![](https://github.com/marknash666/FiscoBcos-ExerciseOne/blob/master/image-ExerciseOne/2.png?raw=true)
通过deploy指令部署并获取合约地址

## 4. 使用查看getDeployLog
![](https://github.com/marknash666/FiscoBcos-ExerciseOne/blob/master/image-ExerciseOne/3.png?raw=true)
部署信息可以通过getDeployLog获取

## 5. 查看区块高度
![](https://github.com/marknash666/FiscoBcos-ExerciseOne/blob/master/image-ExerciseOne/4.png?raw=true)
再次通过getBlockNumber获取区块高度，发现部署之后区块高度增加了1

## 6. 获取区块数据
![](https://github.com/marknash666/FiscoBcos-ExerciseOne/blob/master/image-ExerciseOne/block1.png?raw=true)

## 7. 调用智能合约
### 7.1 调用智能合约
![](https://github.com/marknash666/FiscoBcos-ExerciseOne/blob/master/image-ExerciseOne/5.png?raw=true)
调用get接口获取name变量 此处的合约地址是deploy指令返回的地址
### 7.2 调用智能合约
![](https://github.com/marknash666/FiscoBcos-ExerciseOne/blob/master/image-ExerciseOne/6.png?raw=true)
调用set设置name变量 此处的合约地址是deploy指令返回的地址

## 8. 再次查看区块高度
![](https://github.com/marknash666/FiscoBcos-ExerciseOne/blob/master/image-ExerciseOne/7.png?raw=true)
再次通过getBlockNumber获取区块高度，发现部署之后区块高度增加了1

## 9. 获取区块数据
![](https://github.com/marknash666/FiscoBcos-ExerciseOne/blob/master/image-ExerciseOne/block2.png?raw=true)

## 10. 按照CNS方式部署HelloWorld智能合约
![](https://github.com/marknash666/FiscoBcos-ExerciseOne/blob/master/image-ExerciseOne/9.png?raw=true)
通过deployByCNS + contract_name + version 即可以CNS方式部署合约

## 11. 再次查看区块高度
![](https://github.com/marknash666/FiscoBcos-ExerciseOne/blob/master/image-ExerciseOne/10.png?raw=true)
再次通过getBlockNumber获取区块高度，可以发现进行CNS部署之后区块高度增加了2

## 12. 获取区块数据
![](https://github.com/marknash666/FiscoBcos-ExerciseOne/blob/master/image-ExerciseOne/block3.png?raw=true)
![](https://github.com/marknash666/FiscoBcos-ExerciseOne/blob/master/image-ExerciseOne/block4.png?raw=true)



