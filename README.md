# GCP Minecraft Server 架設與管理指南

## 目錄

- [防火牆設定](#防火牆設定)
- [使用 screen 背景執行 server.sh](#使用-screen-背景執行-serversh)
- [重新連線與管理 screen](#重新連線與管理-screen)
- [備份與下載 world 檔案](#備份與下載-world-檔案)

---

## 防火牆設定

1. 回到你開啟 SSH 的 GCP VM 頁面，點選「建立防火牆規則」。
2. 設定如下：
   - **名稱**：例如 `allow-minecraft-25565`
   - **網路**：`default`（或你自定義的網路）
   - **目標**：選擇「所有實例」或使用「指定目標標籤」
   - **來源 IP 範圍**：`0.0.0.0/0`（開放所有 IP）
   - **允許的協定和埠口**：
     - 勾選「指定協定和埠口」
     - 輸入：`tcp:25565`
   - 勾選「ingress」與「允許」

---

## 使用 screen 背景執行 server.sh

使用screen開啟server.sh(需要掛假人不然關掉ssh連線會自動關閉)
若要停用伺服器請直接輸入stop

```bash
sudo apt install screen -y
screen -S Minecraft
./serverfgcp.sh
```

> 按下 `Ctrl + A`，再按 `D`（代表 detach）

---

## 重新連線與管理 screen

當重新登入ssh時使用以下來回到server.sh
請注意盡量不要開啟多個screen

```bash
screen -r Minecraft
```

如果有多個 screen：

```bash
screen -ls      # 列出所有 screen
screen -x       # 進入唯一一個 screen（若只存在一個）
```

強制結束某個 screen(以292800.Minecraft為例)：

```bash
screen -S 292800.Minecraft -X quit
```

> 注意：大小寫有區分，請根據 `screen -ls` 顯示的名稱輸入

---

## 備份與下載 world 檔案

1. 壓縮 world 資料夾：

```bash
zip -r world.zip World
```

2. 建立臨時 HTTP 傳輸服務：

先建立防火牆規則（開 TCP 8000 埠）：
- 名稱：任意
- IP 範圍：`0.0.0.0/0`
- 勾選「Ingress」與「允許」
- 協定：`tcp:8000`

啟動伺服器並開啟下載：

```bash
python3 -m http.server 8000
```

> 使用 Ctrl+C 可中止伺服器。

4. 從 Windows 瀏覽器輸入網址下載：

```
在windows中打開網頁
http://34.171.194.36:8000/world.zip(以ip 34.171.194.36為例)
就會自動下載
```

---


