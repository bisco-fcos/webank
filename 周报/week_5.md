# 众银行区块链实训-第五周小组周报

## 本次作业
1. 编写智能合约代码
2. 编写应用业务层代码，即SpringBoot后端代码
3. 通过Vue.js编写前端，并与后端进行交互
4. 部署[Circle Ci][3]、[Travis Ci][4]、[Code Factor][5]、[CodeCov][6]以进行监控、单元测试、自动化测试和代码检测
5. 编写项目详细设计文档


**PS:<br/>1. 用控制台加载getaccount的脚本生成的私钥时，需将私钥前面的0x去掉<br/> 2. remix编译的时右上角选择版本为0.4.26**

[solidity官方文档](https://solidity.readthedocs.io/en/v0.5.9/)

[Solidity语言0.4到0.5版本新特性的中文翻译](https://zhuanlan.zhihu.com/p/54169418)

[1]: https://fisco-bcos-documentation.readthedocs.io/zh_CN/latest/docs/tutorial/enterprise_quick_start.html "jiangshi"
[2]: https://github.com/FISCO-BCOS/spring-boot-starter/blob/master/doc/README_CN.md "Spring Boot"
[3]: https://circleci.com/gh/marknash666/ "circle"
[4]: https://travis-ci.com/marknash666/springboot "travis"
[5]: https://www.codefactor.io/ "codefactor"
[6]: https://codecov.io/ "codecov"
## 成员具体工作
成员|内容
:----:|---
贾宇然|1. 完成了基于区块链的汽车维修保养记录查询系统的基础合约编写，包括汽车信息更新VehicleUpdate和汽车信息查询VehicleQuery合约<br />2. 与吴潘安同学一起完成二手车交易功能于VehicleOwnership。 合约开发文档见附录<br />3. 完成了汽车维修保养记录合约的SpringBoot后端开发<br /> 4. 开始基于Vue.js的网页前端开发<br /> 5. 部署[Circle Ci][3]、[Travis Ci][4]、[Code Factor][5]、[CodeCov][6]以完成对后端的代码检测、单元测试、自动化测试，监控等测试项的配置，配置文档可见附录
冯韵|1.编写了部分项目设计文档。 <br /> 
吴潘安|1. 编写基于区块链的汽车维修保养记录查询系统的基础合约，在VehicleUpdate和VehicleQuery引入ERC721，加入二手车交易功能，可见VehicleOwnership<br />
谢珮爽|1.用springboot部署了VchicleQuery合约，并编写了相应的单元测试代码。<br />     2.在增加了VehicleOwnership后，进行测试案例的编写以及编码。<br />  3.编写了需求文档的数据字典。<br >                                              
王松盛|完成了1.0版本部分需求文档编写，提出了记录车辆零部件状况和质量问题的新需求，并进行了初步设想

## 附录：工作报告与记录
[贾宇然-第五周-汽车维修保养记录合约开发](https://github.com/bisco-fcos/webank/blob/master/day5/贾宇然/VehicleMatenance_Dev.md)<br />
[贾宇然-第五周-自动化部署、单元测试与代码检测](https://github.com/bisco-fcos/webank/blob/master/day5/贾宇然/Automatic.md)






