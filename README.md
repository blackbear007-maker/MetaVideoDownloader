# Meta 影片下載器 Chrome 擴充功能

一個可以一鍵下載 Threads 和 Facebook 貼文和留言中影片的 Chrome 擴充功能。

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

1. 前往 [threads.net](https://www.threads.net) 或 [threads.com](https://www.threads.com)
2. 找到想要下載的影片或圖片或圖片（在貼文或留言中）
3. 影片或圖片或圖片右上角會出現下載按鈕
4. 點擊按鈕下載
5. 選擇儲存位置

## 權限說明

此擴充功能需要最小權限：

- **downloads**: 用於啟動檔案下載
- **https://www.threads.net/** 和 **https://www.threads.com/**: 僅在 Threads 網站上運作

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
├── privacy.html        # 隱私權政策頁面
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

1. 將 SVG 圖示轉換為 PNG 格式
2. 檢視隱私權政策
3. 測試所有功能
4. 確認 Manifest V3 合規
5. 準備截圖和宣傳素材

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
