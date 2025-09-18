@echo off
echo ========================================
echo Asian TV Flutter App - Release Script
echo ========================================
echo.

REM Check if Flutter is installed
flutter --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Flutter is not installed or not in PATH
    echo Please install Flutter and try again
    pause
    exit /b 1
)

echo Flutter found, proceeding with build...
echo.

REM Clean previous builds
echo Cleaning previous builds...
flutter clean
if %errorlevel% neq 0 (
    echo ERROR: Failed to clean project
    pause
    exit /b 1
)

REM Get dependencies
echo Getting dependencies...
flutter pub get
if %errorlevel% neq 0 (
    echo ERROR: Failed to get dependencies
    pause
    exit /b 1
)

REM Build APK
echo Building release APK...
flutter build apk --release
if %errorlevel% neq 0 (
    echo ERROR: Failed to build APK
    pause
    exit /b 1
)

REM Build App Bundle
echo Building release App Bundle...
flutter build appbundle --release
if %errorlevel% neq 0 (
    echo ERROR: Failed to build App Bundle
    pause
    exit /b 1
)

REM Create releases directory if it doesn't exist
if not exist "releases" mkdir releases

REM Copy APK to releases directory
echo Copying APK to releases directory...
copy "build\app\outputs\flutter-apk\app-release.apk" "releases\AsianTV-v1.0.0-release.apk"
if %errorlevel% neq 0 (
    echo ERROR: Failed to copy APK
    pause
    exit /b 1
)

REM Copy AAB to releases directory
echo Copying App Bundle to releases directory...
copy "build\app\outputs\bundle\release\app-release.aab" "releases\AsianTV-v1.0.0-release.aab"
if %errorlevel% neq 0 (
    echo ERROR: Failed to copy App Bundle
    pause
    exit /b 1
)

echo.
echo ========================================
echo Build completed successfully!
echo ========================================
echo.
echo Files created:
echo - releases\AsianTV-v1.0.0-release.apk
echo - releases\AsianTV-v1.0.0-release.aab
echo.
echo Next steps:
echo 1. Test the APK on a device
echo 2. Commit and push changes to GitHub
echo 3. Create a GitHub release
echo 4. Upload the APK and AAB files
echo.
echo Asian TV Cable Network
echo Hyderabad, India
echo © 2024 All Rights Reserved
echo.
pause
