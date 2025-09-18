@echo off
echo Creating Android Keystore for Release Signing
echo =============================================
echo.

REM Check if Java is available
where java >nul 2>nul
if %errorlevel% neq 0 (
    echo Error: Java is not installed or not in PATH
    echo Please install Java JDK and add it to your PATH
    pause
    exit /b 1
)

echo Creating keystore with the following details:
echo - Keystore file: key.jks
echo - Key alias: key
echo - Validity: 10000 days
echo - Algorithm: RSA
echo - Key size: 2048 bits
echo.

keytool -genkey -v -keystore key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias key -storepass 123456 -keypass 123456 -dname "CN=Asian TV, OU=IT, O=Asian TV Cable Network, L=Hyderabad, S=Telangana, C=IN"

if %errorlevel% equ 0 (
    echo.
    echo Keystore created successfully!
    echo.
    echo The keystore is configured with:
    echo - Store password: 123456
    echo - Key password: 123456
    echo - Key alias: key
    echo.
    echo You can now build the release APK with:
    echo flutter build apk --release
) else (
    echo.
    echo Error creating keystore. Please check the error messages above.
)

echo.
pause

