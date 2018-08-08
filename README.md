# FCN
free connect your private network from anywhere

# 1. FCN简介

FCN[`free connect`]是一款傻瓜式的一键接入私有网络的工具, fcn利用公共服务器以及数据加密技术实现：

在免公网IP环境下，在任意联网机器上**透明接入服务端所在局域网网段**

FCN = `用户服务端` <--- `FCN公共服务器` --- > `用户客户端` 

* FCN使用交流QQ群: `592512533`

* 申请付费帐户 https://github.com/boywhp/fcn/tree/master/vip

* download FCN V3.5 FULL 百度网盘 https://pan.baidu.com/s/1Mkg3iwxCf0N_ke9GrSahdA

* download FCN V3.5 binary https://github.com/boywhp/fcn/releases/download/V3.5/FCN_V3.5.zip

* download FCN V3.5 嵌入式版本  https://github.com/boywhp/fcn/releases/download/V3.5/embedded-linux.zip

* FCN支持操作系统平台

|操作系统|文件名
|-------|---
| Windows操作系统 | windows/fcn_win.exe
| Linux操作系统 | linux/fcn_x64/x86
| Linux 路由器 | linux-embedded/lede或openwrt/fcn_`mips/mipsel/arm/armhf`
| Linux arm | linux-embedded/`fcn-arm/armbian`
| Android | Fcn.apk

Linux openwrt/lede WR703N、华硕N14U、斐讯K2/K2P Openwrt/Padavan实测通过，openwrt/lede需自行安装`libopenssl`包

Linux arm/armbian 树莓派3、Orange Pi实测通过

## FCN(Windows版)一键接入局域网操作视频
* 首先创建FCN服务端 
![image](https://github.com/boywhp/fcn/blob/master/doc/fcn3.3_win7_s.gif)
* 运行客户端从互联网连接到FCN服务端局域网
![image](https://github.com/boywhp/fcn/blob/master/doc/fcn3.3_win7_c.gif)

* FCN接入原理示意图

![image](https://github.com/boywhp/fcn/raw/master/doc/FCN%E7%BD%91%E7%BB%9C%E7%A4%BA%E6%84%8F%E5%9B%BE.png)

# 2. FCN实际案例

使用FCN跨互联网组网

https://github.com/boywhp/fcn/blob/master/doc/FCN%E5%AE%9E%E9%99%85%E6%A1%88%E4%BE%8B1.ppt

使用FCN远程唤醒PC，并远程管理

https://github.com/boywhp/fcn/blob/master/doc/FCN%20%E6%A1%88%E4%BE%8B2.ppt

# 3. FCN使用

## 3.1 运行客户服务端

FCN默认加载当前目录下的fcn.conf配置文件,用户也可以手工指定, 注意目前测试帐户 `FCN_0000-FCN_9999`, **每个帐户限速100KB/s，日流量配额150M**[点对点通信成功后无限制]，请用户随机挑选测试帐户，并且设置自己的唯一服务器名，以防止帐户冲突

|配置键值|描述
|-------|---
| [uid] | 你的付费帐户名或者FCN_[0001-9999] 8字符FCN ID
| [uic] | 你的付费帐户8位识别码
| [name] | 服务器名，建议填写一个有意义的名称
| [psk] | 管理员账号密码hash或者明文密码，建议使用hash
| [cipher] | 指定加密算法【aes-256-cfb/aes-128-cfb/chacha20】，默认aes-256-cfb
| [authfile] | 用户列表文件名，用户列表文件使用fcn_win.exe获取
| [log] | 指定服务端日志输出文件, 默认不输出日志
| [compress] | 指定是否开启数据包压缩，默认1开启
| [udp] | 0/1, 设置数据包通信类型  0:TCP 1:UDP，建议不填使用UDP
| [nat_nic] | 虚拟接入后连接的服务器网卡名, 建议不填
| [dhcp_ip/dhcp_mask/dhcp_dns] |  虚拟接入后DHCP网段, DHCP DNS服务器地址, 建议不填
| [uport] | 自定义udp通信端口, 默认5000，自定义[1000-2000], 建议不填
| [tport] | 自定义tcp通信端口, 默认8000，自定义[1000-2000], 建议不填
| [pport] | 自定义p2p通信端口, 除非服务端可做端口映射，否则不要填
| [host] | 设置公网FCN服务器地址,默认s1.xfconnect.com, 建议不填
| [notun] | 0/1, 0:自动 1:强制应用层NAT，建议不填
| [portmap] | 0/1, 是否开启服务端端口转发, 视情填写
| [route] | 设置路由网段推送列表, 视情填写

tun驱动模式NAT,需要ROOT权限运行；应用层NAT模式，非ROOT权限无法收发ping包
```shell
./fcn_x64         # 应用层NAT模式
sudo ./fcn_x64    # tun驱动NAT模式
```
注:FCN服务端一个配置只能运行一个实体, 更改配置后, 需要kill掉旧的进程, 否则会提示错误

## 3.2 开机自启动-嵌入式Linux

### 3.2.1 树莓派3[Thanks to 榭寄生], debian linux环境
* 建立启动脚本 fcn.sh, 内容如下:

```bash
#!/bin/sh
/home/pi/fcn-arm
```

* 添加执行权限 chmod +x fcn.sh

* 创建软链接 ln -s /home/pi/your_fcn_dir/fcn.sh /etc/init.d/fcn

* 添加自启动 update-rc.d fcn defaults 99

### 3.2.2 斐讯K2路由器-Padavan

* ssh 登陆上路由器创建fcn目录 mkdir /etc/storage/fcn

* 编辑fcn.conf配置文件模板如下:
```bash
[uid]=FCN_1234
[psk]=YOUR_PASSWORD
[name]=PSG_K2
[nat_nic]=br0
[notun]=1
```
* 使用winscp或者xshell上传fcn_mipsel以及fcn.conf到/etc/storage/fcn/目录
* 加执行权限 chmod +x /etc/storage/fcn
* 登陆路由器Web界面 高级设置->自定义->脚本->WAN 上行/下行 事件后运行, 添加如下代码
```bash
if [ $1 = "up" ] ; then
    /etc/storage/fcn/fcn_mipsel
fi
```
* 重启路由器

## 3.3 运行windows客户端

主界面添加服务器, 填写对应的连接参数, 连接, 成功后, windows客户端即接入了服务器对应局域网, 客户端/服务端参数对应如下

![image](https://github.com/boywhp/fcn/blob/master/doc/FCN%E7%BD%91%E7%BB%9C%E5%8F%82%E6%95%B0.png)

注:第一次连接时会自动安装虚拟网卡驱动,需用户确认同意

## 3.4 运行Linux客户端

Linux客户端/服务端功能已整合在同一个可执行文件中，客户端最常见参数如下：
```bash
sudo ./fcn --uid FCN_0001 --name SVR0001 --psk 'PASSWORD'
sudo ./fcn --cfg client.conf
```
Linux客户端配置文件参数如下：

|参数名|描述
|-------|---
| [uid] | 对应服务端用户ID参数
| [psk] | 对应服务端用户连接密码参数, 必须是明文
| [name] | 对应服务端服务器名
| [usr] | 对应服务端用户名
| [host] | FCN公共服务器地址，默认s1.xfconnect.com，建议直接填写对应的ip地址
| [tun] | 指定客户端虚拟网卡的名称，默认tun_fcn，建议多个FCN客户端时填写
| [tunip] | 手工指定客户端虚拟网卡IP地址
| [udp] | 设置数据包通信类型，0:TCP/1:UDP，默认1 UDP，建议默认
| [vpn] | 是否开启全局路由，默认接入服务端网卡网段，建议按需填写
| [fwd] | 开启服务端局域网数据自动转发到虚拟网卡，建议按需开启
| [log] | 指定服务端日志输出文件, 默认不输出日志
| [client] | 1/0，指示客户端模式运行，必须填1
| [compress] | 指定是否开启数据包压缩，默认1开启

# 4. FCN安全吗？

FCN使用了数字证书、tls以及数据加密技术，点对点通信技术, 用户网络数据全程加密，30分钟左右自动更新会话密钥，确保用户数据不会被截获解密或者中间人欺骗。

FCN公网服务器不会收集用户的任何网络数据，同时支持用户网络数据强制点对点通信。后期考虑开放用户加密接口，以便用户实现自定义的端到端私有加密。

## 4.1 FCN安全机制

* FCN公网服务器和fcn客户端之间通过TLS证书双向验证确保信道安全
* FCN用户服务端每30分钟向fcn公网服务器请求随机数
* FCN公网服务器使用真随机数发生器产生随机数, 并通过TLS连接安全传递给用户
* FCN客户端/服务端通过 随机码 + UID + PSK 计算出一个会话key
* FCN客户端/服务端使用会话key对通信数据包全程aes256加密

# 5. 免责声明

请您仔细阅读以下声明，您在使用FCN工具软件以及使用FCN企业订制服务，表明您对以下内容的接受：

* 严禁破解，逆向本系统程序及相关组件，违者不但将不再享受官方提供的任何服务，也将承担法律责任，并赔偿相应损失;
* 严禁使用本软件从事计算机黑客行为以及其他任何危害计算机信息网络安全的;
* 本软件属于正规网络接入软件，请合理，合法的使用本软件产品；切勿用于违反法律，道德及影响他人利益的活动；如果因用于非法用途，由此造成的不良后果，由用户自行负责，本软件开发者不承担任何责任及损失。
