# Android Release Signing Configuration

This folder contains the keystore configuration for Android release builds.

## Current Setup

The app is currently configured to use your `key.jks` keystore file for release signing.

## Keystore Configuration

The `key.properties` file contains:
- `storePassword`: Keystore password
- `keyPassword`: Key password  
- `keyAlias`: Key alias name
- `storeFile`: Keystore file name

## Creating a New Keystore (if needed)

If you need to create a new keystore, use the following command:

```bash
keytool -genkey -v -keystore key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias key
```

Replace `key.jks` with your desired keystore name and follow the prompts to set passwords.

## Updating Passwords

If you know the correct passwords for your existing `key.jks` file, update them in `key.properties`:

1. Open `key.properties`
2. Update `storePassword` and `keyPassword` with the correct values
3. Save the file

## Building Release APK

Once the keystore is properly configured, build the release APK:

```bash
flutter build apk --release
```

The signed APK will be generated in `build/app/outputs/flutter-apk/app-release.apk`

## Security Note

- Keep your keystore file and passwords secure
- Never commit keystore passwords to version control
- Consider using environment variables for sensitive information in production

