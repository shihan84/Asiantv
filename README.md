# Asian TV - Flutter Mobile Application

<div align="center">
  <img src="splash.png" alt="Asian TV Logo" width="200" height="200"/>
  
  <h3>📺 Live TV Streaming & Social Media Integration</h3>
  
  [![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev/)
  [![Android](https://img.shields.io/badge/Android-3DDC84?style=for-the-badge&logo=android&logoColor=white)](https://developer.android.com/)
  [![License](https://img.shields.io/badge/License-Proprietary-red?style=for-the-badge)](LICENSE)
</div>

---

## 🌟 Features

### 📱 **Live TV Streaming**
- **High-quality video streaming** with adaptive bitrate
- **Full-screen landscape mode** for optimal viewing experience
- **Portrait mode** with rounded corners and controls
- **Auto-rotation support** - automatically switches to landscape when device rotates
- **Comprehensive player controls** - play/pause, progress bar, volume, settings
- **Live indicator** with real-time status
- **Error handling** with retry mechanism and fallback video

### 🌐 **Social Media Integration**
- **YouTube Channel** - Direct access to Asian TV News videos
- **Facebook Page** - Connect with Asian TV Channel Official
- **Instagram Profile** - Follow Asian TV News updates
- **Deep linking** - Opens native apps when available, falls back to web browser
- **Smooth animations** and loading states

### 🎨 **Modern UI/UX**
- **Glassmorphism design** with beautiful gradients
- **Smooth animations** and transitions
- **Responsive layout** for all screen sizes
- **Dark theme** with Asian TV branding
- **Loading indicators** and error states
- **Copyright footer** with company information

### ⚡ **Performance & Optimization**
- **Memory optimization** with image cache limits
- **Fast app startup** with optimized initialization
- **Smooth video playback** with hardware acceleration
- **Efficient state management** with proper disposal
- **Android 12+ compatibility** with latest SDK versions

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.0 or higher)
- Android Studio / VS Code
- Android device or emulator (API 21+)
- Internet connection for video streaming

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/shihan84/Asiantv.git
   cd Asiantv
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the application**
   ```bash
   flutter run
   ```

### Building for Release

1. **Android Release Build**
   ```bash
   flutter build apk --release
   ```

2. **Android App Bundle (AAB)**
   ```bash
   flutter build appbundle --release
   ```

---

## 📱 Screenshots

<div align="center">
  <img src="docs/screenshots/splash.png" alt="Splash Screen" width="200"/>
  <img src="docs/screenshots/home.png" alt="Home Screen" width="200"/>
  <img src="docs/screenshots/live-tv.png" alt="Live TV Player" width="200"/>
  <img src="docs/screenshots/social.png" alt="Social Media" width="200"/>
</div>

---

## 🛠️ Technical Details

### **Architecture**
- **Flutter Framework** - Cross-platform mobile development
- **State Management** - StatefulWidget with proper lifecycle management
- **Video Player** - VideoPlayerController for streaming
- **URL Launcher** - Deep linking to social media apps
- **Orientation Control** - SystemChrome for device orientation

### **Dependencies**
```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.2
  webview_flutter: ^4.2.2
  video_player: ^2.8.2
  url_launcher: ^6.2.5
```

### **Android Configuration**
- **Target SDK:** 34 (Android 14)
- **Min SDK:** 21 (Android 5.0)
- **Compile SDK:** 36
- **Screen Orientation:** Portrait (with landscape support for Live TV)
- **Permissions:** Internet, Network State, Wake Lock

---

## 📺 Live TV Features

### **Video Streaming**
- **Primary Stream:** `https://live.ekamraott.com/4tv/asian/index.m3u8`
- **Fallback Stream:** Demo video for testing
- **Format:** HLS (HTTP Live Streaming)
- **Quality:** Adaptive bitrate based on network conditions

### **Player Controls**
- **Play/Pause** - Tap to control playback
- **Progress Bar** - Shows current position and duration
- **Volume Control** - Audio level adjustment
- **Settings** - Player configuration options
- **Fullscreen Toggle** - Switch between portrait and landscape
- **Auto-hide Controls** - Controls disappear after 10 seconds

### **Orientation Support**
- **Portrait Mode** - Rounded corners with bottom controls
- **Landscape Mode** - Full-screen video with side controls
- **Auto-rotation** - Automatically switches when device rotates
- **Manual Toggle** - Force orientation change with button

---

## 🌐 Social Media Integration

### **YouTube**
- **Channel:** [@asiantvnews](https://www.youtube.com/@asiantvnews)
- **App URL:** `youtube://www.youtube.com/@asiantvnews`
- **Web URL:** `https://www.youtube.com/@asiantvnews`

### **Facebook**
- **Page:** [Asian TV Channel Official](https://www.facebook.com/asiantvchannelofficial/)
- **App URL:** `fb://page/asiantvchannelofficial`
- **Web URL:** `https://www.facebook.com/asiantvchannelofficial/`

### **Instagram**
- **Profile:** [@asiantvnews.in](https://www.instagram.com/asiantvnews.in)
- **App URL:** `instagram://user?username=asiantvnews.in`
- **Web URL:** `https://www.instagram.com/asiantvnews.in`

---

## 🔧 Configuration

### **Android Release Signing**
The app is configured for release builds with keystore signing:

1. **Keystore Location:** `keys/key.jks`
2. **Properties File:** `keys/key.properties`
3. **Build Configuration:** `android/app/build.gradle.kts`

### **Environment Variables**
Create a `keys/key.properties` file:
```properties
storePassword=your_store_password
keyPassword=your_key_password
keyAlias=your_key_alias
storeFile=key.jks
```

---

## 📁 Project Structure

```
lib/
├── main.dart                 # App entry point
├── screens/
│   ├── splash_screen.dart   # Splash screen with animations
│   ├── home_screen.dart     # Main home screen
│   ├── live_tv_screen.dart  # Live TV player
│   └── social_screens.dart  # Social media screens
android/
├── app/
│   ├── build.gradle.kts     # Android build configuration
│   └── src/main/
│       ├── AndroidManifest.xml
│       └── kotlin/.../MainActivity.kt
keys/
├── key.properties           # Keystore configuration
├── key.jks                  # Android keystore
└── README.md               # Keystore setup guide
```

---

## 🐛 Troubleshooting

### **Common Issues**

1. **Video not loading**
   - Check internet connection
   - Verify stream URL is accessible
   - Try retry button in error state

2. **Social media not opening**
   - Ensure apps are installed
   - Check URL format and permissions
   - Verify Android manifest queries

3. **Build errors**
   - Run `flutter clean`
   - Run `flutter pub get`
   - Check Android SDK versions

### **Debug Mode**
```bash
flutter run --debug
```

### **Release Mode**
```bash
flutter run --release
```

---

## 🤝 Contributing

This project is proprietary software owned by Asian TV Network. For contribution guidelines, please contact the development team.

---

## 📞 Support

For technical support or feature requests, please contact:

- **Email:** support@asiantvnetwork.com
- **Website:** [www.asiantvnetwork.com](https://www.asiantvnetwork.com)
- **GitHub Issues:** [Create an issue](https://github.com/shihan84/Asiantv/issues)

---

## 📄 License

This project is proprietary software owned by **Asian TV Network**. All rights reserved.

See [LICENSE](LICENSE) file for details.

---

## 🏢 About Asian TV Network

**Asian TV Cable Network** is a leading television network based in Hyderabad, India, providing high-quality content and live streaming services to viewers worldwide.

### **Company Information**
- **Name:** Asian TV Cable Network
- **Location:** Hyderabad, India
- **Founded:** 2024
- **Services:** Live TV Streaming, News, Entertainment

### **Contact Information**
- **Address:** Hyderabad, Telangana, India
- **Email:** info@asiantvnetwork.com
- **Website:** [www.asiantvnetwork.com](https://www.asiantvnetwork.com)

---

<div align="center">
  <p><strong>© 2024 Asian TV Cable Network. All rights reserved.</strong></p>
  <p>Made with ❤️ in Hyderabad, India</p>
</div>