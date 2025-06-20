#!/bin/bash

echo "開始安裝 Server 所需環境..."

# 1. 更新系統 & 安裝工具
echo "更新系統與安裝解壓縮工具與 wget..."
sudo apt update
sudo apt upgrade -y
sudo apt install -y tar unzip wget zip dos2unix screen python3-venv

# 2. 安裝 Java 8
echo "安裝 Java 8...若非rlcarft請自行額外下載符合版本之java"
wget https://github.com/adoptium/temurin8-binaries/releases/download/jdk8u412-b08/OpenJDK8U-jdk_x64_linux_hotspot_8u412b08.tar.gz
sudo mkdir -p /opt/java
sudo tar -xvzf OpenJDK8U-jdk_x64_linux_hotspot_8u412b08.tar.gz -C /opt/java

# 設定環境變數
echo "設定 JAVA_HOME..."
echo "export JAVA_HOME=/opt/java/jdk8u412-b08" >> ~/.bashrc
echo "export PATH=\$JAVA_HOME/bin:\$PATH" >> ~/.bashrc
source ~/.bashrc

# 顯示 Java 版本
java -version

# 3. 建立虛擬環境安裝 gdown（Google 雲端下載工具）
echo "建立 Python 虛擬環境以方便pip安裝 gdown..."
python3 -m venv myenv
source myenv/bin/activate
pip install gdown

# 下載並解壓 RLCraft server（你需要改這行 id）
gdown --id 1vigq2nuHHJeqjwUl2W1km_QKBL5MasAL
unzip server.zip
deactivate


# 4. 修正與啟用腳本
cd server
echo "修正啟動腳本格式與給予權限..."
dos2unix serverfgcp.sh
chmod +x serverfgcp.sh

source ~/.bashrc
java -version

# 結束提示
echo "安裝完成！請檢查上述java版本是否正確，你可以用以下方式啟動伺服器："
echo "screen -S Minecraft"
echo "./serverfgcp.sh"
echo ""
echo "請記得在 GCP 開放 TCP 25565 連接埠（防火牆 Ingress 規則）"