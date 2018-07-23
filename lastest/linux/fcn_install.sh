#!/bin/bash

#**********FCN INSTALL SCRIPT**********
#***Thanks to dingyi(4690595@qq.com)***
#**************************************

Fcn=$(pwd)/fcn
Fcn_bin=$Fcn/fcn_$(uname -m)
Log_dir=$Fcn/fcn_inslll.log
Fcn_url=https://github.com/boywhp/fcn/raw/master/lastest/linux/fcn_$(uname -m)
Fcn_conf=https://github.com/boywhp/fcn/raw/master/lastest/linux/fcn.conf

if [ ! -d $Fcn ] ; then
	mkdir -p $Fcn
fi

function menu () {
cat << EOF  
`echo -e "1)Linux centos/ubuntu x86/x64"`
`echo -e "2)Othes"`
EOF
read -p "Input Your OS:" num1
case $num1 in
	1)
		echo "Linux centos/ubuntu x86/x64 install..."
		linux_menu
		;;
	2)
		echo "Not supported :-("
		;;
esac
}

function linux_menu () {

cd $Fcn
wget --no-check-certificate $Fcn_url &>/dev/null
if [ $? -eq 0 ]; then
	echo "Fcn binary download success"
else
	echo "Fcn binary download error!!!"
	exit
fi
wget --no-check-certificate $Fcn_conf &>/dev/null  
if [ $? -eq 0 ]; then
	echo "Fcn conf download success"
else
	echo "Fcn conf download error!!!"
	exit
fi

chmod +x  $Fcn_bin
read -p "Input your fcn ID(0000-9999):" fcn_id
sed -i "s/0001/$fcn_id/g" $Fcn/fcn.conf
read -p "Input your fcn PSK:" fcn_psk
sed -i "s/ab7d5ac276eafbce6e1e8a5d092c4b79efc250b28997a1eb5182fd39b36edb74/$fcn_psk/g" $Fcn/fcn.conf
read -p "Input your fcn Name:" fcn_name
sed -i "s/SERVER01/$fcn_name/g" $Fcn/fcn.conf

$Fcn_bin
if [ $? -eq 0 ] ; then
	echo "Fcn service start success"
else
	echo "Fcn service start error"
	exit
fi
echo -e "$Fcn_bin" >> /etc/rc.local
}
menu

