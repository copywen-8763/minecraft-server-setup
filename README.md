#在GCP中設定防火牆

先回到你開啟ssh的位置，找到建立防火牆規則

名稱：輸入一個容易辨識的名稱，比如 allow-minecraft-25565

網路：通常是 default，除非你有自訂網路

目標：選擇「所有實例」或「指定目標標籤」(若你有標籤的話)

來源範圍 (來源 IP 範圍)：輸入 0.0.0.0/0 （代表允許所有 IP）

允許的協定和埠口：

勾選「指定協定和埠口」

輸入 tcp:25565

(其中勾選ingress以及允許)

#使用screen開啟server.sh(需要掛假人不然關掉ssh連線會自動關閉)
sudo apt install screen -y
screen -S Minecraft
./serverfgcp.sh
Ctrl + A，然後按 D（代表 detach）

當重新登入ssh時使用以下來回到server.sh

screen -r minecraft
screen -x 進入screen(唯一)或列出所有screen attached表連結中 detached表為連結但在運行

強制關閉screen
screen -S 292800.Minecraft -X quit 
(大小寫有差 以screen 292800.Minecraft為例 看screen--help)



#抓出遊玩的world
sudo apt update
sudo apt install zip unzip -y

壓縮world
zip -r world.zip World

建立連線
依然要建立防火牆規則(上傳server時不使用是因為windows 的防火牆比較麻煩)
新增一條 Ingress 規則
名稱：任意
IP 範圍：0.0.0.0/0
允許 TCP：8000
勾選「套用至所有執行個體」

python3 -m http.server 8000
ctrl+c斷開
在windows中打開網頁
http://34.171.194.36:8000/world.zip(以ip 34.171.194.36為例)
就會自動下載


#非rlcraft模組包注意事項

請先至相應版本下載forge server，安裝完畢後開啟forge(版本).jar

將eula內false改為true，再次開啟forge(版本).jar

請先提前更改需要更改的config以及需求的變動，並建立server.sh腳本

其中server.sh內容為
#!/bin/bash
cd ~/server
java -Xms4G -Xmx8G -jar forge-(版本).jar nogui

請將server資料夾刪除
rm -rf server

用 gdown 下載
其中server.zip必須是壓縮的，且檔案狀態必須為公開(任何有連結者都能存取)
利用共用_>分享連結獲得連結，請自行觀察id，以下為範例連結與其指令
https://drive.google.com/file/d/1vigq2nuHHJeqjwUl2W1km_QKBL5MasAL/view?usp=drive_link
gdown --id 1vigq2nuHHJeqjwUl2W1km_QKBL5MasAL

解壓縮
unzip server.zip

注意:server資料夾名稱以及serverfgcp.sh檔案名稱務必與我相同

cd至server
cd server

保證serverfgcp.sh可以執行
sudo apt install dos2unix
dos2unix serverfgcp.sh

給啟動權限
chmod +x serverfgcp.sh

嘗試執行server
./serverfgcp
若成功則設定防火牆

