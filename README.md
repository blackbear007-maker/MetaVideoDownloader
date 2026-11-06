# 影片下載器 for Facebook & Threads（Chrome 擴充功能）

一個可以一鍵下載 Threads 和 Facebook 貼文和留言中影片的 Chrome 擴充功能。

> 本專案為獨立開發，與 Meta Platforms, Inc.、Facebook 或 Threads 無任何關聯，亦未獲其背書。

## 功能特色

- ✅ 下載 Threads 貼文中的影片
- ✅ 下載 Facebook 貼文中的影片
- ✅ 下載留言和回覆中的影片
- ✅ 影片右上角顯示下載按鈕
- ✅ 支援桌面版和手機版檢視
- ✅ 不收集任何資料，不追蹤
- ✅ 隱私優先設計
- ✅ 最小權限需求

## 安裝方式

### 開發者模式安裝

1. 下載或複製此儲存庫
2. 開啟 Chrome 並前往 `chrome://extensions/`
3. 在右上角啟用「開發者模式」
4. 點擊「載入未封裝項目」
5. 選擇 `MetaVideoDownloader` 資料夾
6. 擴充功能安裝完成！

## 使用方法

1. 前往 [threads.net](https://www.threads.net)、[threads.com](https://www.threads.com) 或 [facebook.com](https://www.facebook.com)
2. 找到想要下載的影片（在貼文或留言中）
3. 影片右上角會出現下載按鈕
4. 點擊按鈕下載
5. 選擇儲存位置

## 權限說明

此擴充功能需要最小權限：

- **downloads**: 用於啟動檔案下載（會跳出另存新檔對話框）
- **https://www.threads.net/**、**https://www.threads.com/** 和 **https://*.facebook.com/**: 僅在 Threads 與 Facebook 網站上運作

Facebook 影片使用 blob 網址，無法直接下載。擴充功能會在 facebook.com 頁面內（本機）檢查頁面內容與 Facebook 網頁本身收到的網路回應，從中找出影片的真實網址；此過程不會記錄或傳送任何資料。

## 隱私權

此擴充功能注重隱私：

- ❌ 不收集個人資料
- ❌ 不使用追蹤或分析
- ❌ 不儲存任何資料
- ❌ 不與第三方分享資料
- ✅ 所有處理都在本機進行
- ✅ 開源以確保透明度

詳見 [privacy.html](privacy.html) 完整隱私權政策。

## 技術細節

- **Manifest 版本**: V3（Chrome 最新標準）
- **Content Script**: 偵測 Threads 頁面上的影片元素
- **Background Service Worker**: 處理下載請求
- **Popup**: 顯示擴充功能狀態和使用說明

## 相容性

- Chrome 88+
- Edge 88+
- 任何支援擴充功能的 Chromium 瀏覽器

## 開發

### 檔案結構

```
MetaVideoDownloader/
├── manifest.json       # 擴充功能設定
├── background.js       # 下載服務
├── content.js          # 影片偵測腳本
├── popup.html          # 擴充功能彈出視窗 UI
├── popup.js            # 彈出視窗邏輯
├── injected.js         # Facebook 影片網址擷取（頁面 MAIN world）
├── privacy.html        # 隱私權政策頁面
├── package-extension.ps1 # 打包上架用 ZIP
├── icons/              # 擴充功能圖示
│   ├── icon16.png
│   ├── icon48.png
│   └── icon128.png
└── README.md           # 本檔案
```

### 建立圖示

`icons/` 資料夾中的 SVG 圖示需要轉換為 PNG 格式才能提交到 Chrome Web Store。您可以使用任何圖片轉換工具或線上工具轉換：
- icon16.svg → icon16.png
- icon48.svg → icon48.png
- icon128.svg → icon128.png

## Chrome Web Store 提交

提交到 Chrome Web Store 前：

1. 執行 `.\package-extension.ps1` 產生 ZIP（請勿使用 Compress-Archive，它會產生反斜線路徑，商店無法讀取圖示）
2. 檢視隱私權政策，並在開發者後台填入公開網址（例如 GitHub 上的 privacy.html）
3. 測試所有功能
4. 確認 Manifest V3 合規
5. 準備 1280x800 截圖和宣傳素材

## 授權

MIT 授權 - 歡迎修改和散布

## 支援

如有問題或疑問，請使用 Chrome Web Store 支援管道。

## 修改記錄

### 2026-07-02
- 專案更名為「Meta 影片下載器」
- 更新 README.md 中的專案名稱和資料夾名稱
- 更新 manifest.json 中的擴充功能名稱
- 更新 popup.html 中的標題和顯示名稱
- 更新 privacy.html 中的隱私權政策標題
- 更新 popup.js 中的註解
- 更新 PRE_RELEASE_REVIEW.md 中的報告標題
- 執行安全審計 (security-audit-skill)
- 生成 SECURITY_AUDIT_REPORT_20260702.md
- 審計結果：總評分 9.8/10，無重大漏洞
- 修復 injected.js postMessage 萬用字元 origin 問題（改為 window.location.origin）
- 修復 injected.js JSON 解析大小限制問題（添加 1MB 限制）
- 執行上架前審查，更新 PRE_RELEASE_REVIEW.md
- 檢查上架前檢查清單，PNG 圖示已完成
- 推送到 GitHub (https://github.com/blackbear007-maker/MetaVideoDownloader.git)
- 修復頁面切換時下載錯誤影片的 bug（添加 URL 變更監聽器清空 capturedList）
- 修復 Facebook Reel 下載錯誤影片的 bug（改進 Reel URL 正則表達式）
- 修復 Facebook Reel 下載錯誤影片的 bug（對大響應使用 regex 掃描而非 JSON 解析）
- 將所有日誌中的 [Threads Downloader] 改為 [MetaVideoDownloader]
- 修復下載固定/錯誤影片的 bug（regexScan 關聯最近 video id、合併 hd/sd、調整 fallback 順序優先以 id 精準匹配）
- 修復時序競態 bug（正確影片在點擊後才被捕獲）：下載改為 async，輪詢等待最多 3 秒讓對應 id 的捕獲到達
- 修復動態影片 video id = null 抓錯的 bug：新增 React fiber props 走訪，從元件 props 提取 video id
- 新增影片時長匹配（不依賴 Facebook id）：解析 fbcdn URL efg 參數的 duration_s，與點擊影片實際時長比對挑出正確影片
- 新增 currentSrc 直取：blob/空 URL 時先 play() 促使載入，輪詢 videoElement.currentSrc，progressive 影片可直接取得精確 URL（免匹配）
- 新增 React fiber 深度搜尋影片 URL：從點擊影片的元件 props/state 直接取得其 playable_url，即使該影片未被網路捕獲也能精確下載
- 修復動態牆抓到兄弟影片的 bug：停用會向上爬樹的 fiber id 提取；改用 isolate-and-capture（暫停其他影片、強制播放點擊影片、取其 currentSrc 或播放後首個新捕獲）
- 修復 pcb 假 id 的 bug：只接受純數字 video id，拒絕貼文區塊 id（pcb.*）
- 新增解析度匹配：injected.js 捕獲影片 original_width/height，以點擊影片的 videoWidth×videoHeight 對時長相同的多候選做精準二次篩選（含方向備援）
- Reel/watch 觀看者改用網址 id 優先：直接以 window.location 的 /reel/<id> 或 ?v=<id> 對應影片（最可靠）；大回應 warn 降為 log
- 動態牆已緩衝影片改用 currentSrc 輪詢：強制播放後輪詢 currentSrc，直接接受點擊元素的 URL（移除解析度驗證，因為影片播放時尺寸可能不穩定）

### 2026-07-03 (v1.2.0)
- Bug 修復驗證成功：動態牆和 Reel 影片下載功能正常
- 移除 isolateAndCapture 中的解析度驗證（影片播放時尺寸可能不穩定）
- 上架前審查完成：PRE_RELEASE_REVIEW.md 更新為 APPROVED FOR RELEASE
- 更新 manifest.json 版本號至 1.2.0
- 打包專案為 MetaVideoDownloader_v1.2.0.zip
- 準備提交至 Chrome Web Store

### 2026-11-06 (v1.2.0 上架前修正)
- 上架前審查：發現 zip 反斜線路徑、privacy.html 與實際權限不符、名稱含 Meta 商標三項阻擋問題
- 擴充功能更名為「影片下載器 for Facebook & Threads」，描述與 popup 加註「非 Meta 官方產品」
- 重寫 privacy.html：移除不存在的 contextMenus / activeTab 說明，補上 threads.com、*.facebook.com 與 Facebook 網路回應檢查的揭露，加上中文摘要與 GitHub 連結
- popup 版本號改由 chrome.runtime.getManifest() 取得，不再手寫
- background.js 新增下載網址驗證：僅接受 https 且主機為 fbcdn.net / cdninstagram.com / facebook.com / threads.net / threads.com
- manifest 精簡 host_permissions 與 content_scripts matches（*.facebook.com 已涵蓋 www 與 web 子網域）
- content.js 移除未使用的 logVideoDiagnostics、extractVideoIdFromProps、findVideoIdFromReactFiber
- package-extension.ps1 改用 bsdtar 打包（正斜線路徑）、版本號讀自 manifest、不再打包 SVG
- 新增 .gitignore 忽略 *.zip
