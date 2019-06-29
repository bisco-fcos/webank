# 微众银行区块链实训仓库
![](https://travis-ci.com/marknash666/springboot.svg?branch=master)
[![CodeFactor](https://www.codefactor.io/repository/github/marknash666/springboot/badge)](https://www.codefactor.io/repository/github/marknash666/springboot)
[![CircleCI](https://circleci.com/gh/marknash666/springboot.svg?style=svg)](https://circleci.com/gh/marknash666/springboot)
![codecov](https://codecov.io/gh/marknash666/springboot/branch/master/graph/badge.svg)](https://codecov.io/gh/marknash666/springboot)

## _SpringBoot 后端链接：https://github.com/marknash666/springboot_
## 小组成员
组长：贾宇然

组员：冯韵、谢珮爽、吴潘安、王松盛
## 本次作业
1. 搭建区块链第层节点，需要包括多机构角色和多群组，具体搭建过程参考[多群组搭建官方文档][1] 
1. 编写智能合约代码
2. 编写应用业务层代码，即SpringBoot后端代码
3. 通过Vue.js编写前端与后端进行交互
4. 部署[Circle Ci][3]、[Travis Ci][4]、[Code Factor][5]以进行监控、单元测试、自动化测试和代码检测
5. 设计应用场景，编写项目详细文档
6. 参加FinTechathon区块链赛道


控制台与Remix编译器使用PS:<br/>
`用控制台加载getaccount的脚本生成的私钥时，需将私钥前面的0x去掉`

`remix编译的时右上角选择版本为0.4.26`

[solidity官方文档](https://solidity.readthedocs.io/en/latest/)

[Solidity语言0.4到0.5版本新特性的中文翻译](https://zhuanlan.zhihu.com/p/54169418)



[1]: https://fisco-bcos-documentation.readthedocs.io/zh_CN/latest/docs/tutorial/enterprise_quick_start.html "jiangshi"
[2]: https://github.com/FISCO-BCOS/spring-boot-starter/blob/master/doc/README_CN.md "Spring Boot"
[3]: https://circleci.com/gh/marknash666/ "circle"
[4]: https://travis-ci.com/marknash666/springboot "travis"
[5]: https://www.codefactor.io/ "codefactor"

## 第一周 控制台的基本使用
- [第一周周报](https://github.com/bisco-fcos/webank/blob/master/%E5%91%A8%E6%8A%A5/week_1.md)
- [第一周作业仓库day1](https://github.com/bisco-fcos/webank/tree/master/day1)
## 第二周 build_chain.sh
- [第二周周报](https://github.com/bisco-fcos/webank/blob/master/%E5%91%A8%E6%8A%A5/week_2.md)
- [第二周作业仓库day2](https://github.com/bisco-fcos/webank/tree/master/day2)
## 第三周 LAGCredit.sol & SpringBoot
- [第三周周报](https://github.com/bisco-fcos/webank/blob/master/%E5%91%A8%E6%8A%A5/week_3.md)
- [第三周作业仓库day3](https://github.com/bisco-fcos/webank/tree/master/day3)
## 第四周 LAGCredit.sol & SpringBoot
- [第四周周报](https://github.com/bisco-fcos/webank/blob/master/%E5%91%A8%E6%8A%A5/week_4.md)
- [第四周作业仓库day4](https://github.com/bisco-fcos/webank/tree/master/day4)


### 项目结构
```
├─day1
│  │  Readme.md
│  │  
│  ├─冯韵
│  │      Day1.md
│  │      ExerciseOne-FengYun.md
│  │      
│  ├─吴潘安
│  │      Day1.md
│  │      ExerciseOne-WuPanAn.md
│  │      
│  ├─王松盛
│  │      day1.md
│  │      
│  ├─谢珮爽
│  │      day1.md
│  │      
│  └─贾宇然
│          HomeWorkOne-JiaYuRan.md
│          README.md
│          
├─day2
│  │  build_chainv4.1.pptx
│  │  
│  ├─冯韵
│  │      BuildChainReport-FengYun.md
│  │      
│  ├─吴潘安
│  │      BuildChainReport-WuPanAn.md
│  │      
│  ├─王松盛
│  │      BuildChainReport-WangSongSheng.md
│  │      
│  ├─谢珮爽
│  │      BuildChainReport-XiePeiShuang.md
│  │      
│  └─贾宇然
│          Build_ChainReport-JiaYuRan.md
│          Console_Report.md
│          
├─day3
│  │  readme.md
│  │  
│  ├─冯韵
│  ├─吴潘安
│  ├─谢珮爽
│  │      CryptoZombies-learning.md
│  │      
│  └─贾宇然
│          CryptoZombies-learning.md
│          LAGContract.md
│          LAGCredit.sol
│          
├─day4
│  │  readme.md
│  │  week4.pptx
│  │  
│  ├─冯韵
│  ├─吴潘安
│  │      LAGContract.md
│  │      LAGContract.sol
│  │      
│  ├─谢珮爽
│  └─贾宇然
│          Crypto-Hands-on-Learning.md
│          InterfaceDevelop.md
│          LAGCredit_Console.md
│          LAGCredit_SpringBoot.md
│          
└─周报
        week_1.md
        week_2.md
        week_3.md
        week_4.md       
```

