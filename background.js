// Background service worker for Threads Video Downloader
// Manifest V3 compliant

// Download video function
function downloadVideo(url, filename) {
  console.log('[Threads Downloader] Starting download:', url, filename);
  chrome.downloads.download({
    url: url,
    filename: filename,
    saveAs: true
  }, (downloadId) => {
    if (chrome.runtime.lastError) {
      console.error("[Threads Downloader] Download error:", chrome.runtime.lastError);
    } else {
      console.log("[Threads Downloader] Download started:", downloadId);
    }
  });
}

// Handle messages from content script
chrome.runtime.onMessage.addListener((request, sender, sendResponse) => {
  if (request.action === "downloadVideo") {
    downloadVideo(request.videoUrl, request.filename);
    sendResponse({ success: true });
  }
  return true;
});
