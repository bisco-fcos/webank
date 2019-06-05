### help()
对应命令中的 -help，给用户弹出使用帮助

### LOG_WARN()
输出错误信息

### LOG_INFO()
输出信息 

### parse_params()
解析用户的额外选项配置，如-f, -l等，并进行一定的错误处理，如用户输入的端口数量不为3，端口非正整数等

### print_result()
提示构建完成，打印执行完毕后的结果汇总，包括端口、IP等，

### fail_message()
输出信息并返回错误

### check_env()
检查当前环境，包括openssl是否下载以及版本是否正确，路径是否配置，当前操作系统是什么。

### check_and_install_tassl()
检查tassl是否安装，如果未被安装则从github上拉取安装包并进行安装

### getname()
取 /path1/path2/path3/filename/ 中的filename
通过判断去掉可能的最后一个空 / , 而后截取最后的filename

### check_name()
检测输入的名字是否合法

### file_must_exists()
检测文件是否存在，要求文件存在

### dir_must_exists()
检测目录是否存在，要求目录存在

### dir_must_not_exists()
检测目录是否存在，要求目录不存在

### gen_chain_cert()
首先通过调用子函数检测输入是否合法，而后通过openssl生成链的私钥和公钥

### gen_agency_cert()
首先通过调用子函数检测输入是否合法，
通过openssl生成agency的私钥，以chain作为CA来签署agency的私钥并生成agency的公钥

### gen_cert_secp256k1()
以secp256k1椭圆曲线秘钥生成公私钥，并以代理的agency作为CA签署数字证书。

### gen_node_cert()
首先检测openssl的版本是否足够使用secp256k1，不够则提示升级。
而后利用gen_cert_secp256k1生成节点的公私钥。

### generate_gmsm2_param()
将固定的国密EC参数写入输入的文件名中

### gen_chain_cert_gm()
使用generate_gmsm2_param写入的固定的EC参数，用国密生成chain的公私钥，以chain自签发构建ca

### gen_agency_cert_gm()
使用和chain相同的EC参数，国密版本的签发agency证书，生成agency的公私钥

### gen_node_cert_with_extensions_gm()
使用和chain相同的EC参数，国密版本的签发node的证书，生成node的公私钥

### gen_node_cert_gm()
使用gen_node_cert_with_extensions_gm为node生成公私钥并进行数字证书签发

### generate_config_ini()
将信息写入配置文件，包括监听端口、是否使用国密、IP、公钥地址等

### generate_group_genesis()
生成组共识文件，如最大交易数目、最大gas等

### generate_group_ini()
生成组信息传输的配置文件，如是否使用动态最大block size，是否支持并行等

### generate_cert_conf()
生成数字证书配置文件，如组织名、默认有效时长等等

### generate_script_template()
生成shell脚本模板，赋予执行权限

### generate_cert_conf_gm()
国密版本的证书配置文件

### generate_node_scripts()
生成节点开始运行和停止运行的shell脚本，其中考虑了在docker模式下的使用。

### genTransTest()
生成交易测试的shell脚本，包括发送单条transaction和多条transactions。

### generate_server_scripts()
生成启动所有节点的脚本start_all.sh，挨个访问节点并运行它们各自的start脚本。
生成停止所有节点的脚本stop_all.sh，挨个访问节点并运行它们各自的stop脚本

### parse_ip_config()
读取并处理用户输入的ip地址

### main()
首先检查是否有设置ip，有则通过parse_ip_config解析
对docker模式则下载fisco-bcos包并进行安装配置
而后利用generate_cert_conf生成或从已有地方复制配置文件
利用gen_chain_cert生成chain的公私钥，而后生成agency的公私钥（以前面生成的chain为ca进行签发）
如果设定为国密模式，则额外进行国密的配置、公私钥生成
而后对于每个ip数组中的元素：
	取出ip地址和每个ip地址包含的节点数目，经过地址检查之后使用gen_node_cert对每个ip下的每个节点生成公私钥并以agency作为ca进行数字签名认证，若是国密模式则额外进行国密版本的公私钥生成与认证。
最后生成配置文件，挨个对每个节点生成节点配置文件、节点通信配置文件、组共识文件、组配置文件，并生成节点的开始和停止脚本，最后在agency处使用generate_server_scripts生成统一管理所有节点的脚本，
