#!/bin/bash
install_DockerCompose () {
command docker-compose &>/dev/null

if [ $? -ne 0 ];then
    cp docker-compose /usr/bin/
    cp docker-compose /usr/sbin/
    chmod +x /usr/bin/docker-compose
    chmod +x /usr/sbin/docker-compose
fi

command -v docker-compose &>/dev/null
result=$?

docker_composeV=`docker-compose --version | awk '{print $3}' | sed 's/,//g'`

if [ $result -eq 0 ];then
    echo -e "\e[1;32mdocker-compose 安装成功，版本号为 $docker_composeV,\e[1;35m docker-compose.yml version: \e[5;32m ---> [2] <--- \e[0m"

else

    echo -e "\e[1;31mdocker-compose 安装失败，即将github安装\e[0m"

        curl -L https://github.com/docker/compose/releases/download/1.16.1/docker-compose-`uname -s`-`uname -m` -o /usr/bin/docker-compose

        result1=$?

        if [ -e /usr/bin/docker-compose ];then

            chmod +x /usr/bin/docker-compose
            docker_composeVV=`docker-compose --version | awk '{print $3}' | sed 's/,//g'`
            echo -e "\e[1;32mdocker-compose 安装成功，版本号为 $docker_composeVV,\e[1;35m docker-compose.yml version: \e[5;32m ---> [2] <--- \e[0m"
        else
            echo -e "\e[1;31mdocker-compose 安装失败，即将尝试yum安装\e[0m"
            yum -y install docker-compose &>/dev/null
            result2=$?
            command -v docker-compose &>/dev/null
            if [ $result2 -eq 0 -a $? -eq 0 ];then
                echo -e "\e[1;32mdocker-compose 安装成功，版本号为 $docker_composeVV,\e[1;35m docker-compose.yml version: \e[5;32m ---> [3] <--- \e[0m"
                docker_composeVVV=`docker-compose --version | awk '{rint $3}' | sed 's/,//g'`
            else
                echo -e "\e[1;31mdocker-compose 安装失败，即将退出，请检查网络\e[0m"
                exit 4
        fi
    fi
fi

}
install_DockerCompose
