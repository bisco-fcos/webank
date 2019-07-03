# 项目持续化部署

### 目标：对项目进行监控、单元测试、自动化测试和代码检测


## 持续集成
>持续集成指的是，频繁地（一天多次）将代码集成到主干.
>它的好处主要有两:
>
>    （1）快速发现错误。每完成一点更新，就集成到主干，可以快速发现错误，定位错误也比较容易。<br/>
>    （2）防止分支大幅偏离主干。如果不是经常集成，主干又在不断更新，会导致以后集成的难度变大，甚至难以集成。
>
>持续集成的目的，就是让产品可以快速迭代，同时还能保持高质量。它的核心措施是，代码集成到主干之前，必须通过自动化测试。只要有一个测试用例失败，就不能集成。
>与持续集成相关的，还有两个概念，分别是持续交付和持续部署:<br/>
>持续交付（Continuous delivery）指的是，频繁地将软件的新版本，交付给质量团队或者用户，以供评审。如果评审通过，代码就进入生产阶段<br/>
>持续部署（continuous deployment）是持续交付的下一步，指的是代码通过评审以后，自动部署到生产环境

实际上，Continuous Integration服务就是为我们提供了一个独立的运行环境，这个环境可以根据配置文件按照规范化的流程运行指令。这些指令在虚拟机中的运行情况会通过文本的形式反馈给我们，无论是失败或成功。一般来说，这些服务会在项目发生更改（如push|merge）时自动对项目进行构建，运行测试，反馈运行结果。<br/>最直观的反馈形式便是一个Badge，如右图所示![](https://www.travis-ci.com/marknash666/springboot.svg?branch=master)这是我们后端的Travis CI徽章

## Travis CI

**官方文档**

>作为一个持续集成平台，Travis CI通过自动构建和测试代码更改来支持您的开发过程，并提供有关变更成功的即时反馈。 Travis CI还可以通过管理部署和通知来自动化开发过程的其他部分。
以下是本次项目SpringBootStarter的.travis.yml配置文件
```php
language: java
jdk:
  - openjdk8

before_cache:
  - rm -f  $HOME/.gradle/caches/modules-2/modules-2.lock
  - rm -fr $HOME/.gradle/caches/*/plugin-resolution/
  
cache:
  directories:
    - $HOME/.gradle/caches/
    - $HOME/.gradle/wrapper/
   
script: |
  curl -LO https://raw.githubusercontent.com/FISCO-BCOS/FISCO-BCOS/master/tools/build_chain.sh && chmod u+x build_chain.sh
  bash <(curl -s https://raw.githubusercontent.com/FISCO-BCOS/FISCO-BCOS/master/tools/ci/download_bin.sh) -b master
  echo "127.0.0.1:4 agency1 1,2,3" > ipconf
  ./build_chain.sh -e bin/fisco-bcos -f ipconf -p 30300,20200,8545
  ./nodes/127.0.0.1/start_all.sh
  cp nodes/127.0.0.1/sdk/* src/main/resources/
  ./gradlew verGJF
  ./gradlew build
  
after_sucess:
- npm run coveralls
```
### 配置情况简述
1. 声明项目词采用的语言java
```php
language: java
jdk:
  - openjdk8
```
2. Travis提供了这些语句来设置Gradle项目构建所采用的缓存，Gradle依赖性缓存的特性需要避免在每次构建之后上载缓存
```php
before_cache:
  - rm -f  $HOME/.gradle/caches/modules-2/modules-2.lock
  - rm -fr $HOME/.gradle/caches/*/plugin-resolution/
  
cache:
  directories:
    - $HOME/.gradle/caches/
    - $HOME/.gradle/wrapper/
```
3. 具体的配置脚本：后端的一些测试需要联盟链节点的运行，因此需要在项目构建之前通过**build_chain**脚本搭建一条联盟链并将节点sdk拷贝至项目资源目录下供其使用。而最后的两个gradlew操作分别是**verifying Google Java Format**和最终的gradle项目构建操作。前者负责验证文件是否符合谷歌的Java代码风格要求（非常严格）而后者则会执行一系列的Task，其中就括执行所有测试类（这里就是自动化测试的具体执行位置）
```
script: |
  curl -LO https://raw.githubusercontent.com/FISCO-BCOS/FISCO-BCOS/master/tools/build_chain.sh && chmod u+x build_chain.sh
  bash <(curl -s https://raw.githubusercontent.com/FISCO-BCOS/FISCO-BCOS/master/tools/ci/download_bin.sh) -b master
  echo "127.0.0.1:4 agency1 1,2,3" > ipconf
  ./build_chain.sh -e bin/fisco-bcos -f ipconf -p 30300,20200,8545
  ./nodes/127.0.0.1/start_all.sh
  cp nodes/127.0.0.1/sdk/* src/main/resources/
  ./gradlew verGJF
  ./gradlew build
```
![](https://github.com/marknash666/FiscoBcos-Exercises/blob/master/images/image-for-vehicle/vehicle_travis1.png)

## Circle CI

**介绍**

Ciicle CI的项目自动部署速度貌似更快（因为不用排队），不过其支持的语言和功能（如矩阵部署，即在多种环境下对项目进行部署测试，某个版本出现的build failed也不会视为整体部署失败）相对来说会少一些<br/>
以下是本次项目SpringBootStarter的.circle/config.yml配置文件
```php
version: 2
jobs:
  build:
    docker:
      # specify the version you desire here
      - image: circleci/openjdk:8-jdk

      # Specify service dependencies here if necessary
      # CircleCI maintains a library of pre-built images
      # documented at https://circleci.com/docs/2.0/circleci-images/
      # - image: circleci/postgres:9.4

    working_directory: ~/repo

    environment:
      # Customize the JVM maximum heap limit
      JVM_OPTS: -Xmx3200m
      TERM: dumb

    steps:
      - checkout

      # Download and cache dependencies
      - restore_cache:
          keys:
            - v1-dependencies-{{ checksum "build.gradle" }}
            # fallback to using the latest cache if no exact match is found
            - v1-dependencies-

      - run: gradle dependencies

      - save_cache:
          paths:
            - ~/.gradle
          key: v1-dependencies-{{ checksum "build.gradle" }}
          
      - run:     
           command: |
             curl -LO https://raw.githubusercontent.com/FISCO-BCOS/FISCO-BCOS/master/tools/build_chain.sh && chmod u+x build_chain.sh
             bash <(curl -s https://raw.githubusercontent.com/FISCO-BCOS/FISCO-BCOS/master/tools/ci/download_bin.sh) -b master
             echo "127.0.0.1:4 agency1 1,2,3" > ipconf
             ./build_chain.sh -e bin/fisco-bcos -f ipconf -p 30300,20200,8545
             ./nodes/127.0.0.1/start_all.sh
             cp nodes/127.0.0.1/sdk/* src/main/resources/
    
      # run tests!
- run: gradle test
```
### 配置情况简述
整体配置架构基本上采用了Circle CI提供的Java项目的配置框架，核心在于steps中添加了部署我们后端项目运行所需要的联盟链搭建配置。
```php
steps:      
      - run:     
           command: |
             curl -LO https://raw.githubusercontent.com/FISCO-BCOS/FISCO-BCOS/master/tools/build_chain.sh && chmod u+x build_chain.sh
             bash <(curl -s https://raw.githubusercontent.com/FISCO-BCOS/FISCO-BCOS/master/tools/ci/download_bin.sh) -b master
             echo "127.0.0.1:4 agency1 1,2,3" > ipconf
             ./build_chain.sh -e bin/fisco-bcos -f ipconf -p 30300,20200,8545
             ./nodes/127.0.0.1/start_all.sh
             cp nodes/127.0.0.1/sdk/* src/main/resources/
             
      - run: gradle test
```


## Codecov

**介绍**
>Codecov是一个开源的测试结果展示平台，将测试结果可视化。CI负责执行测试，经过配置之后测试结果会上传到Codecov，而Codecov则会分析测试结果并且以表格的形式展示出来。其最简单的用法就是衡量测试代码覆盖度，依赖于travis，Codecov非常简单就能上手。

### 配置情况简述
1. 在项目配置文件中加入jacoco插件和报告生成代码
```gradle
apply plugin: 'jacoco'

jacocoTestReport {
	reports {
		xml.enabled true
		csv.enabled false
		html.enabled false

		xml.destination file("${buildDir}/reports/jacoco/jacocoReport/jacocoXml.xml")
		csv.destination file("${buildDir}/reports/jacoco/jacocoReport/jacocoCsv.csv")
		html.destination file("${buildDir}/reports/jacoco/jacocoReport/jacocoHtml")
	}
}
```
2. 在CircleCI的config.yml中加入生成测试报告和上传报告至Codecov的指令
```php
- run:     
           command: |
             if [ -e ./gradlew ]; then ./gradlew jacocoTestReport;else gradle jacocoTestReport;fi
             bash <(curl -s https://codecov.io/bash)
```

完成后，每一次CI进行自动构建和测试的时候就会更新Codevoc的覆盖率状态

## Codefactor

**介绍**
>了解整个项目的代码质量，最近的提交和最有问题的文件。 
>CodeFactor将尝试首先根据问题代码大小，文件更改频率和文件大小显示最关键的问题，以便您可以开始只修复重要的问题。
>直接从代码文件或项目问题页面创建和跟踪问题或评论。

这个代码检测服务的开启非常简单，只需要在官网登陆Github账号之后将需要进行检测的仓库添加到服务中即可。效果如下：
![](https://github.com/marknash666/FiscoBcos-Exercises/blob/master/images/image-for-vehicle/codefactor.png)
## 参考文档
[TravisCI官方文档](https://docs.travis-ci.com/user/languages/java/)<br/>
[CircleCI官方文档](https://docs.travis-ci.com/user/languages/java/)<br/>
[Codevcov官方文档](https://docs.codecov.io/docs)<br/>
[Codevcov Gradle项目示例](https://github.com/codecov/example-gradle)<br/>
[Codevfactor官方文档](https://www.codefactor.io/features)
