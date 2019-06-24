# 众银行区块链实训-第四周小组周报
## 本次作业
1. 通过[僵尸游戏][1]熟悉solidity规则 
1. 使用[spring-boot-starter][2]部署课上的LAG积分合约

**PS:<br/>1. 用控制台加载getaccount的脚本生成的私钥时，需将私钥前面的0x去掉<br/> 2. remix编译的时右上角选择版本为0.4.26**

[solidity官方文档](https://solidity.readthedocs.io/en/v0.5.9/)

[Solidity语言0.4到0.5版本新特性的中文翻译](https://zhuanlan.zhihu.com/p/54169418)

[1]: https://cryptozombies.io/en/lesson "jiangshi"
[2]: https://github.com/FISCO-BCOS/spring-boot-starter/blob/master/doc/README_CN.md "Spring Boot"

## 成员具体工作
成员|内容
:----:|---
贾宇然|1. 完成了僵尸编程教程的"Hands-on Path: Make and Deploy a Custom Game Mode"进阶系列，对LOOM即将推出的区块链僵尸卡牌游戏和其自定义游戏模式有了更多的了解。阅读心得为Crypto-Hands-on-Learning.md，可见附录。<br /> 2. LAGCredit合约的编写和初步功能体验已经在remix在线编译器上完成，随后利用FISCO BCOS提供的控制台进行进一步的功能验证。控制台部署和使用报告为LAGCredit_Console.md，可见附录<br /> 3. 在FISCO BCOS提供的Spring-Boot-Starter上完成LAGCredit合约的编译、部署和功能验证。工作报告为LAGCredit_SpringBoot.md，见附录。<br /> 4. 在完成基本SDK的基础上开发了一些简单的后端接口供前端调用。文档为InterfaceDevelop.md，见附录<br />
冯韵|
吴潘安|1. 根据僵尸游戏中的新手系列教程熟悉solidity语言<br/>2. 给LAG合约增加新功能<br />3. 尝试部署spring-boot-starter
谢珮爽|1. 完成了僵尸编程教程“Solidity”教程。<br />2.继续尝试用spring-boot-starter部署。                                                       
王松盛|1. 完成了僵尸编程教程“Solidity教程：智能合约基础教程”中所有内容，了解了Solidity语言的基础语法，以及教程中介绍的各种trick，例如onlyowner，gas优化，ERC721标准，natspec标准等内容<br/>2. 初步了解了html，jss以及JavaScript。

## 附录：工作报告与记录
[贾宇然-第四周-僵尸教程进阶之路阅读心得](https://github.com/bisco-fcos/webank/blob/master/day4/%E8%B4%BE%E5%AE%87%E7%84%B6/Crypto-Hands-on-Learning.md)
[贾宇然-第四周-控制台部署合约与功能验证](https://github.com/bisco-fcos/webank/blob/master/day4/%E8%B4%BE%E5%AE%87%E7%84%B6/LAGCredit_Console.md)
[贾宇然-第四周-SpringBoot编译、部署合约与测试](https://github.com/bisco-fcos/webank/blob/master/day4/%E8%B4%BE%E5%AE%87%E7%84%B6/LAGCredit_SpringBoot.md)
[贾宇然-第四周-合约后端接口发开文档](https://github.com/bisco-fcos/webank/blob/master/day4/%E8%B4%BE%E5%AE%87%E7%84%B6/InterfaceDevelop.md)
[吴潘安-第四周-合约阅读与功能添加报告](https://github.com/bisco-fcos/webank/blob/master/day4/%E5%90%B4%E6%BD%98%E5%AE%89/LAGContract.md)







