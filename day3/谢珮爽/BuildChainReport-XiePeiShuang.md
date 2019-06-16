```#!/bin/bash```   
`#!` 是一个约定的标记，它告诉系统这个脚本需要什么解释器来执行，即使用哪一种 Shell。   
```set -e```   
你写的每个脚本都应该在文件开头加上set -e,这句语句告诉bash如果任何语句的执行结果不是true则应该退出。   

代码的5-36定义了**buid_chain.sh**文件的全局变量
`port_start=(30300 20200 8545)`定义了起始端口为30300,20200,8545
#### help()  
```echo $1```命令用于向窗口**buid_chain.sh**文件的第一个参数。  
```
cat << EOF
EOF  
```   
cat命令是linux下的一个文本输出命令，通常是用于观看某个文件的内容的；EOF是“end of file”，表示文本结束符。结合这两个标识，即可避免使用多行echo命令的方式，并实现多行输出的结果。    
help()中定义了关于help 的各种命令，后面定义了命令的执行过程及向窗口输出的内容。     
`exit 0`为正常运行程序并退出。
#### LOG_WARN()和LOG_INFO()
`local`定义了函数的局部变量
`echo -e "\033[31m[WARN] ${content}\033[0m"`   
格式: echo -e "\033[字背景颜色;字体颜色m字符串\033[0m"   
31m：字体颜色为红色，将content的颜色设为红色 。
输出警告信息。
#### parse_params()
`getopts "f:l:o:p:e:t:v:icszhgTFdC:S" option`   
getopts可以获取用户在命令下的参数，然后根据参数进行不同的提示或者不同的执行。    
：表示选项后面必须带有参数，如果没有可以不加实际值进行传递
```
case
esac
```   
语句表明了当option为不同的取值时的不同执行。
#### print_result（）
输出执行结果
#### fail_message()
当执行错误时，输出第一个参数并结束运行。   
#### check_env()
检查环境，如果openssl version能匹配到1.0.2,1.1，reSSL中的一个则执行下面的语句，否则，输出重新初始化option以及检查版本，结束shell脚本。  
export变量输出。如果openssl version能匹配到reSSL，定义路径并输出。反之，判断uname 并确定对应的OS是Mac还是Linux。  
#### check\_and\_install_tassl()
检查根目录Home下是否存在常规文件tassl，若不存在，从特定网站下载压缩包并解压。值授予这个文件的所有者执行权限。并将tassl移至Home目录下。   
#### getname()
定义局部变量name，若为空，结束函数并返回0；否则，   
%/*删掉最后一个  /  及其右边的字符串  
\#\#\*/删除左边的/及字符串，只留下文件名
#### check\_name()
检查文件值，其中的字符是否在1-9，a-z，A-Z以及$，否则输出该文件未被初始化，退出shell脚本。
#### file\_must\_exists()
如果"$1"的常规文件不存在，输出文件不存在并退出shell脚本。
#### dir\_must\_exists()
如果"$1"的目录不存在，输出DIR不存在并退出shell脚本。
#### dir\_must\_not\_exists()
如果"$1"的文件存在，输出请清空目录并退出shell脚本。
#### gen\_chain\_cert()
检查要创建的目录是否存在，不存在则创建该目录。检查文件是否存在，在目录下生成2048位的CA私钥
生成CA证书请求（.csr）并自签名得到根证书（.crt）   
将cert.cnf文件转移到chaindir目录下。
#### gen\_agency\_cert()
判断链是否存在，链的CA秘钥是否已经生成，检查代理名和代理地址，然后根据代理地址创建目录。在该目录下创建2048位的agency私钥，生成证书请求并自签名得到根证书。
```cp $chain/ca.crt $chain/cert.cnf $agencydir/```将两个文件转移到agencydir目录下。
```cp $chain/ca.crt $agencydir/ca-agency.crt```将chain/ca.crt文件复制到$agencydir/ca-agency.crt   
以more的形式显示证书，删除 agencydir/agency.csr文件。输出代理证书创建成功。
#### gen\_node\_cert()
判断系统是否支持secp256k1，否则，要求更新openssl。
如果支持，判断代理名，代理路径，节点名，节点路径是否存在；然后根据节点路径创建目录，
使用gen\_cert\_secp256k1加密，生成节点加密证书，返回到节点目录。
#### generate\_gmsm2\_param()
将
```-----BEGIN EC PARAMETERS-----
BggqgRzPVQGCLQ==
-----END EC PARAMETERS-----
```
输出到参数1的文件中。
#### gen\_chain\_cert\_gm()
检查参数2的作为路径，检查是否存在并创建目录。
产生私钥到chaindir/gmca.key中，生成证书请求（.csr）并自签名得到根证书（.crt）   
输出$chaindir目录下的文件，将gmcert.cnf和gmsm2.param文件，复制到目录chaindir下。如果复制成功，则build chain 的CA证书创建成功。
#### gen\_agency\_cert\_gm()
跟前面的证书创建过程类似，创建了一个新的代理证书。
#### gen\_node_cert\_with\_extensions\_gm()
```$TASSL_CMD genpkey -paramfile $capath/gmsm2.param -out $certpath/gm${type}.key```根据参数产生私钥，生成证书请求，生成自签名证书。
rm -f 命令删除一个目录中的一个或者多个文件或者目录，其中的，f参数 （f --force ） 忽略不存在的文件，不显示任何信息不会提示确认信息。  
删除文件certpath/gm${type}.csr，若文件不存在，则忽略。
#### gen\_node\_cert\_gm()
用于创建node证书。判断系统是否支持secp256k1，不支持则退出程序。对代理地址，代理名，节点名，节点地址的存在性进行判断，然后用已有的参数初始化gen\_node_cert\_with\_extensions\_gm()对节点创建CA证书。  
查看$TASSL\_CMD version中是否含义1.0.2，执行相关语句。然后将两个文件agpath/gmca.crt和 agpath/gmagency.crt防盗节点目录下，并返回目录。  
#### generate\_config\_ini()  
编写人rpc,p2p,certificate_blacklist,group,network_security,storage_security,chain,compatibility,log的地址的执行过程。
#### generate\_group\_genesis()
定义了consensus，storage，state，tx，group的相关执行语句。
#### function generate\_group\_ini()
对组区块链进行初始化，包括块的大小，限制，以及并行性进行相关的定义。
#### generate\_cert\_conf()
生成证书认证文件
#### generate\_script\_template()
生成script模板。向filepath文件输出  
```
    #!/bin/bash 
    SHELL_FOLDER=\$(cd \$(dirname \$0);pwd)
```
赋予文件执行权限。
#### generate\_cert\_conf\_gm()
生成认证配置文件。
生成认证的默认值及设定配置，生成配置文件。
#### generate\_node\_scripts()
生成节点脚本。配置与节点运行和结束相关的shell文件。
#### genTransTest()
生成train测试。编写train测试的shell文档，定义它的四个关键函数。
#### generate\_server\_scripts()
生成服务器脚本。
#### parse\_ip\_config()
读取config文件的每一行，初始化数组 ip_array，agency_array，group_array，判断每一次构造时，是否有值为空，若有，则构造失败（红字输出）。若无，则继续初始化数组，知道文件结束。

## main()
在当前目录后加上原有的输出目录作为新的输出目录。  
```[ -z $use_ip_param ] && help 'ERROR: Please set -l or -f option.'```   
判断use\_ip\_parm是否为空值,并执行help语句。use\_ip\_param为true，则ip\_array获取ip\_param的值；为false则，如果```parse_ip_config $ip_file```执行成功，则继续，否则结束运行。  
判断output\_dir是否存在并创建目录。检查fisco\_version是否为空，为空则下载版本并赋值。  
**下载fisco-bcos并检查它**  
检查docker\_mode是否为空，若为空：检查bin\_path和OS的值，都为空则为他们重新设定，并下载fisco-bcos并赋予output\_dir\bcos\_bin\_name目录下的所有者，所属组，和其他人访问权限。
若OS不为空，输出错误信息并结束运行。其他情况下，对fisco-bcos进行二分查找，输出错误信息并结束运行。  
检查文件CertConfig名是否为空，是否存在，若不存在，生成CA认证到文件cert.cnf中。  
use\_ip\_param的值为true，只要ip_array有值，就初始化
```
agency_array[i]="agency"
group_array[i]=1
```   
**准备CA证书**   
判断几个文件的存在性，然后生成对应的链CA认证和代理证书，若都存在，记录证书地址。  
**生成秘钥**  
处理成国密secp256k1模式  
**生成配置**  
生成组配置文件以及初始化组。