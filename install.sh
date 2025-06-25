#!/bin/bash

echo "開始安裝 Server 所需環境"

echo "更新系統與安裝解壓縮工具與 wget"
sudo apt update
sudo apt upgrade -y
sudo apt install -y tar unzip wget zip dos2unix screen python3-venv

cd ~
echo "安裝 Java 8"
wget https://github.com/adoptium/temurin8-binaries/releases/download/jdk8u412-b08/OpenJDK8U-jdk_x64_linux_hotspot_8u412b08.tar.gz
sudo mkdir -p /opt/java
cd ~
sudo tar -xvzf OpenJDK8U-jdk_x64_linux_hotspot_8u412b08.tar.gz -C /opt/java

echo "設定 JAVA_HOME..."
echo "export JAVA_HOME=/opt/java/jdk8u412-b08" >> ~/.bashrc
echo "export PATH=\$JAVA_HOME/bin:\$PATH" >> ~/.bashrc



echo "建立 Python 虛擬環境以方便pip安裝 gdown..."
python3 -m venv myenv
source myenv/bin/activate
pip install gdown


gdown --id 1H0EitvFemdfCcZW9FhjA9hBi0Y3RuErf
unzip server.zip
deactivate


cd server
echo "修正啟動腳本格式與給予權限..."
dos2unix serverfgcp.sh
chmod +x serverfgcp.sh


echo "安裝完成！請檢查上述java版本是否正確，你可以用以下方式啟動伺服器："
echo "screen -S Minecraft"
echo "./serverfgcp.sh"
echo ""
echo "請記得在 GCP 開放 TCP 25565 連接埠（請閱README.md）"
cd ~

