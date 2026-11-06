// Background service worker for Video Downloader for Facebook & Threads
// Manifest V3 compliant

// Only allow downloads from Meta's own content delivery hosts
const ALLOWED_HOST_SUFFIXES = ['.fbcdn.net', '.cdninstagram.com', '.facebook.com', '.threads.net', '.threads.com'];

function isAllowedVideoUrl(url) {
  try {
    const u = new URL(url);
    if (u.protocol !== 'https:') return false;
    return ALLOWED_HOST_SUFFIXES.some((suffix) =>
      u.hostname === suffix.slice(1) || u.hostname.endsWith(suffix));
  } catch (e) {
    return false;
  }
}

// Download video function
function downloadVideo(url, filename) {
  if (!isAllowedVideoUrl(url)) {
    console.error('[MetaVideoDownloader] Refused download from unexpected host:', url);
    return false;
  }
  console.log('[MetaVideoDownloader] Starting download:', url, filename);
  chrome.downloads.download({
    url: url,
    filename: filename,
    saveAs: true
  }, (downloadId) => {
    if (chrome.runtime.lastError) {
      console.error("[MetaVideoDownloader] Download error:", chrome.runtime.lastError);
    } else {
      console.log("[MetaVideoDownloader] Download started:", downloadId);
    }
  });
  return true;
}

// Handle messages from content script
chrome.runtime.onMessage.addListener((request, sender, sendResponse) => {
  if (request.action === "downloadVideo") {
    const ok = downloadVideo(request.videoUrl, request.filename);
    sendResponse({ success: ok });
  }
  return true;
});
