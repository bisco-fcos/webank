# 控制台使用报告
以下是FISCO BCOS官方文档对控制台的介绍

>## 控制台
>
>[控制台](https://github.com/FISCO-BCOS/console)是FISCO BCOS 2.0重要的交互式客户端工具，它通过[Web3SDK](../sdk/sdk.md)与区块链节点建立连接，实现对区块链节点数据的读写访问请求。控制台拥有丰富的命令，包括查询区块链状态、管理区块链节点、部署并调用合约等。此外，控制台提供一个合约编译工具，用户可以方便快捷的将Solidity合约文件编译为Java合约文件。
>
>### 控制台命令
>控制台命令由两部分组成，即指令和指令相关的参数：   
>- **指令**: 指令是执行的操作命令，包括查询区块链相关信息，部署合约和调用合约的指令等，其中部分指令调用JSON-RPC接口，因此与JSON-RPC接口同名。 **使用提示： 指令可以使用tab键补全，并且支持按上下键显示历史输入指令。**
>  
>- **指令相关的参数**: 指令调用接口需要的参数，指令与参数以及参数与参数之间均用空格分隔，与JSON-RPC接口同名命令的输入参数和获取信息字段的详细解释参考[JSON-RPC API](../api.md)。
>
>常用命令链接：
>- 查看区块高度：[getBlockNumber](./console.html#getblocknumber)
>- 查看共识节点列表：[getSealerList](./console.html#getsealerlist)
>- 部署合约: [deploy](./console.html#deploy)
>- 调用合约: [call](./console.html#call)
>- 切换群组: [switch](./console.html#switch)

此前我已经使用过getBlockNumber，deploy和call，因此现在我们首先来使用getSealerList和switch

### switch
>运行switch或者s，切换到指定群组。群组号显示在命令提示符前面

我们采用 **-l** 来建立节点的时候，所有节点属于同一个机构和群组
![](https://github.com/marknash666/FiscoBcos-Exercises/blob/master/images/image-for-console/2_kindsofnode.png?raw=true)

因此要建立多个群组的话需要使用 **-f** 根据配置文件生成节点
![](https://github.com/marknash666/FiscoBcos-Exercises/blob/master/images/image-for-console/groups.png?raw=true)

**ipconf**配置文件内容如下
```
127.0.0.1:2 agencyA 1,2,3
127.0.0.1:2 agencyB 1
127.0.0.1:2 agencyC 2
127.0.0.1:2 agencyD 3
```

127.0.0.1:2 agencyA 1,2,3 表示ip为127.0.0.1的机器上有两个节点，这两个节点属于机构agencyA，属于group1,group2和group3

为了与多群组架构相匹配，我们还需要修改applicationContext.xml配置文件，否则与多群组相关的操作将会报错。具体设置参考[多群组架构文档](https://fisco-bcos-documentation.readthedocs.io/zh_CN/latest/docs/tutorial/group_use_cases.html)

![](https://github.com/marknash666/FiscoBcos-Exercises/blob/master/images/image-for-console/switch.png?raw=true)
调用**getGroupList**可以看到当前有三个群组，通过switch可以切换到其他组


### getSealerList
用于查看共识节点列表
![](https://github.com/marknash666/FiscoBcos-Exercises/blob/master/images/image-for-console/getsealerlist.png?raw=true)

### getNodeVersion
用于查看节点版本
![](https://github.com/marknash666/FiscoBcos-Exercises/blob/master/images/image-for-console/getnodeversion.png?raw=true)

## 总结
#### 这一次的控制台使用实验让我了解如何使用build_chain.sh创建多群组的区块联盟链，如何在控制台内切换群组和查看公式节点列表与节点版本的方法。
