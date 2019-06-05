# #20190604

Help()方法显示帮助信息

主体程序中：

先运行check_env检查环境，然后用parse_params获取参数，之后执行main，最后print_result打印结果。

Check_env()函数中，先检查openssl，版本不合适或者没有安装就弹出信息要求客户安装openssl。再检查系统是macos还是Linux。

parse_params是读取控制台输入的参数。

main()

先处理了一些ip设置的的异常，通过parse_ip_config().

再通过dir_must_not_exists确认输出路径没有文件存在。

之后确定fisco的版本

再之后下载fisco-bcos，检查二进制文件。

运行generate_cert_conf生成证书配置文件，指定时间地点等等。在此过程中，先确认/chain目录不存在，之后用openssl生成ca.key证书(get_chain_cert),之后使用openssl生成ca_agency.crt (gen_agency_cert)。如果使用国密体系，则安装tassl(check_and_install_tassl)。并且生成国密的CA key(gen_agency_cert_gm)。

生成密钥

生成密钥的过程，先检查IP地址，之后使用gen_node_cert() gen_cert_secp256k1()使用secp256k1方法生成每个节点的key，如果是国密模式则用gen_node_cert_gm生成国密模式的key，将原本的配置文件放在国密配置文件路径下，删除原来的密钥文件。

生成设置文件

生成设置文件(generate_config_ini)，设置监听的IP，ID等信息。之后设置共识设定，(generate_group_genesis)，设定共识算法类别，存储类型，gas limit信息。之后生成群组设置(generate_group_ini())，设置ttl，最小块生成时间，pool limit。之后生成节点的脚本(generate_node_scripts())。

Print_result()直接打印安装结果，其中包括端口，服务器IP，状态类型，输出目录，CA KEY路径等等。