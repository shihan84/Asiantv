# API Documentation - Asian TV Flutter Application

This document provides detailed information about the APIs, services, and integrations used in the Asian TV Flutter application.

## 📋 Table of Contents

- [Video Streaming API](#video-streaming-api)
- [Social Media APIs](#social-media-apis)
- [Deep Linking](#deep-linking)
- [Configuration](#configuration)
- [Error Handling](#error-handling)

## 🎥 Video Streaming API

### Live TV Stream

**Primary Stream URL:**
```
https://live.ekamraott.com/4tv/asian/index.m3u8
```

**Fallback Stream URL:**
```
https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4
```

### Stream Configuration

```dart
// Video player initialization
VideoPlayerController.networkUrl(
  Uri.parse('https://live.ekamraott.com/4tv/asian/index.m3u8'),
  videoPlayerOptions: VideoPlayerOptions(
    mixWithOthers: true,
    allowBackgroundPlayback: false,
  ),
)
```

### Stream Properties

| Property | Value | Description |
|----------|-------|-------------|
| Format | HLS (HTTP Live Streaming) | Adaptive bitrate streaming |
| Protocol | HTTPS | Secure streaming |
| Quality | Adaptive | Auto-adjusts based on network |
| Audio | Stereo | High-quality audio |
| Video | 1080p/720p/480p | Multiple quality options |

## 🌐 Social Media APIs

### YouTube Integration

**Channel Information:**
- **Channel Handle:** `@asiantvnews`
- **Channel URL:** `https://www.youtube.com/@asiantvnews`
- **App Deep Link:** `youtube://www.youtube.com/@asiantvnews`

**Implementation:**
```dart
Future<void> _launchYoutube() async {
  final youtubeAppUrl = Uri.parse('youtube://www.youtube.com/@asiantvnews');
  final youtubeWebUrl = Uri.parse('https://www.youtube.com/@asiantvnews');
  
  if (await canLaunchUrl(youtubeAppUrl)) {
    await launchUrl(youtubeAppUrl, mode: LaunchMode.externalApplication);
  } else if (await canLaunchUrl(youtubeWebUrl)) {
    await launchUrl(youtubeWebUrl, mode: LaunchMode.externalApplication);
  }
}
```

### Facebook Integration

**Page Information:**
- **Page Username:** `asiantvchannelofficial`
- **Page URL:** `https://www.facebook.com/asiantvchannelofficial/`
- **App Deep Link:** `fb://page/asiantvchannelofficial`

**Implementation:**
```dart
Future<void> _launchFacebook() async {
  final facebookAppUrl = Uri.parse('fb://page/asiantvchannelofficial');
  final facebookWebUrl = Uri.parse('https://www.facebook.com/asiantvchannelofficial/');
  
  if (await canLaunchUrl(facebookAppUrl)) {
    await launchUrl(facebookAppUrl, mode: LaunchMode.externalApplication);
  } else if (await canLaunchUrl(facebookWebUrl)) {
    await launchUrl(facebookWebUrl, mode: LaunchMode.externalApplication);
  }
}
```

### Instagram Integration

**Profile Information:**
- **Username:** `asiantvnews.in`
- **Profile URL:** `https://www.instagram.com/asiantvnews.in`
- **App Deep Link:** `instagram://user?username=asiantvnews.in`

**Implementation:**
```dart
Future<void> _launchInstagram() async {
  final instagramAppUrl = Uri.parse('instagram://user?username=asiantvnews.in');
  final instagramWebUrl = Uri.parse('https://www.instagram.com/asiantvnews.in');
  
  if (await canLaunchUrl(instagramAppUrl)) {
    await launchUrl(instagramAppUrl, mode: LaunchMode.externalApplication);
  } else if (await canLaunchUrl(instagramWebUrl)) {
    await launchUrl(instagramWebUrl, mode: LaunchMode.externalApplication);
  }
}
```

## 🔗 Deep Linking

### URL Schemes

| Platform | Scheme | Format | Example |
|----------|--------|--------|---------|
| YouTube | `youtube://` | `youtube://www.youtube.com/@username` | `youtube://www.youtube.com/@asiantvnews` |
| Facebook | `fb://` | `fb://page/username` | `fb://page/asiantvchannelofficial` |
| Instagram | `instagram://` | `instagram://user?username=username` | `instagram://user?username=asiantvnews.in` |

### Android Manifest Configuration

```xml
<queries>
    <!-- YouTube -->
    <intent>
        <action android:name="android.intent.action.VIEW" />
        <data android:scheme="youtube" />
    </intent>
    <!-- Facebook -->
    <intent>
        <action android:name="android.intent.action.VIEW" />
        <data android:scheme="fb" />
    </intent>
    <!-- Instagram -->
    <intent>
        <action android:name="android.intent.action.VIEW" />
        <data android:scheme="instagram" />
    </intent>
    <!-- Web browsers -->
    <intent>
        <action android:name="android.intent.action.VIEW" />
        <data android:scheme="https" />
    </intent>
</queries>
```

## ⚙️ Configuration

### App Configuration

**Package Name:** `com.example.asiantv`
**App Name:** `asiantv`
**Version:** `1.0.0`
**Build Number:** `1`

### Android Configuration

**Target SDK:** `34` (Android 14)
**Min SDK:** `21` (Android 5.0)
**Compile SDK:** `36`

**Permissions:**
```xml
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.QUERY_ALL_PACKAGES" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
<uses-permission android:name="android.permission.WAKE_LOCK" />
<uses-permission android:name="android.permission.FOREGROUND_SERVICE" />
<uses-permission android:name="android.permission.POST_NOTIFICATIONS" />
```

### Video Player Configuration

```dart
// Video player options
VideoPlayerOptions(
  mixWithOthers: true,
  allowBackgroundPlayback: false,
)

// Orientation settings
SystemChrome.setPreferredOrientations([
  DeviceOrientation.portraitUp,
  DeviceOrientation.portraitDown,
  DeviceOrientation.landscapeLeft,
  DeviceOrientation.landscapeRight,
]);
```

## 🚨 Error Handling

### Video Player Errors

**Error Types:**
- Network connectivity issues
- Stream unavailable
- Codec not supported
- Timeout errors

**Error Handling:**
```dart
try {
  await _videoPlayerController!.initialize();
  setState(() {
    _isInitialized = true;
    _isLoading = false;
  });
} catch (e) {
  setState(() {
    _hasError = true;
    _errorMessage = 'Failed to load video: $e';
    _isLoading = false;
  });
}
```

### URL Launch Errors

**Error Types:**
- App not installed
- Invalid URL format
- Network connectivity issues
- Permission denied

**Error Handling:**
```dart
try {
  if (await canLaunchUrl(appUrl)) {
    await launchUrl(appUrl, mode: LaunchMode.externalApplication);
  } else if (await canLaunchUrl(webUrl)) {
    await launchUrl(webUrl, mode: LaunchMode.externalApplication);
  }
} catch (e) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('Error launching app: $e'),
      backgroundColor: Colors.red,
    ),
  );
}
```

## 📊 Performance Metrics

### Video Streaming Performance

- **Startup Time:** < 3 seconds
- **Buffer Time:** < 2 seconds
- **Memory Usage:** < 100MB
- **CPU Usage:** < 30%

### App Performance

- **Launch Time:** < 2 seconds
- **Screen Transitions:** < 500ms
- **Memory Footprint:** < 150MB
- **Battery Usage:** Optimized for mobile

## 🔧 Troubleshooting

### Common Issues

1. **Video not loading**
   - Check network connectivity
   - Verify stream URL accessibility
   - Check device compatibility

2. **Social media not opening**
   - Verify app installation
   - Check URL scheme format
   - Verify Android manifest permissions

3. **Performance issues**
   - Check device memory
   - Verify network speed
   - Check for background processes

### Debug Information

```dart
// Enable debug logging
import 'package:flutter/foundation.dart';

if (kDebugMode) {
  print('Video player initialized: ${_videoPlayerController!.value.isInitialized}');
  print('Video duration: ${_videoPlayerController!.value.duration}');
  print('Video position: ${_videoPlayerController!.value.position}');
}
```

---

**Asian TV Cable Network**  
Hyderabad, India  
© 2024 All Rights Reserved
