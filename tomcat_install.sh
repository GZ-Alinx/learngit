#!/bin/bash
#
#tomcat install script
#包放到/root目录下,并且修改对应版本号!
read -p "选择你要安装的JDK版本:" jdk
echo "plaese wait..."
cd /root/tomcat
jdkurl=/usr/local/
tomcaturl=/usr/local/   
case "$jdk" in
    1.8)
        cd ~ ;`tar -xf jdk-8u151-linux-x64.tar.gz -C $jdkurl;`
        `tar -xf apache-tomcat-7.0.82.tar.gz -C /usr/local/`
cat << EOF >> /etc/profile
        export JAVA_HOME=/usr/local/jdk1.8.0_151
        export JAVA_BIN=/usr/local/jdk1.8.0_151/bin
        export PATH=${JAVA_HOME}/bin:$PATH
        export CLASSPATH=.:${JAVA_HOME}/lib/dt.jar:${JAVA_HOME}/lib/tools.jar
EOF

        source /etc/profile
        `java -version` 
        if [ $? -eq 0 ];then
                echo "jdk install ACCESS~"
        fi
                cd $tomcaturl
                cd apache-tomcat-7.0.82
                /usr/local/apache-tomcat-7.0.82/bin/startup.sh
        if [ $? -eq 0 ];then
                echo "tomcat install ACCESS~"
        fi
        ;;
    1.7)
        ;;
    *)
        /root/tomcat.sh
        echo "请重新输入你的版本号!"
        ;;
esac
