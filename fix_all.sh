#!/data/data/com.termux/files/usr/bin/bash

echo "======================================"
echo "🚑 ANDROID FULL FIX + BUILD SCRIPT"
echo "======================================"

set -e

echo "🧹 1) Cleaning project..."
./gradlew clean || true

echo "🔧 2) Fixing Gradle wrapper permissions..."
chmod +x ./gradlew

echo "📄 3) Fixing AndroidManifest (removing package issue)..."

cat > app/src/main/AndroidManifest.xml <<'EOF'
<?xml version="1.0" encoding="utf-8"?>

<manifest xmlns:android="http://schemas.android.com/apk/res/android">

    <application
        android:allowBackup="true"
        android:label="Executive Assistant"
        android:icon="@mipmap/ic_launcher"
        android:roundIcon="@mipmap/ic_launcher_round"
        android:supportsRtl="true"
        android:theme="@android:style/Theme.Material.Light.NoActionBar">

        <activity
            android:name=".MainActivity"
            android:exported="true">

            <intent-filter>
                <action android:name="android.intent.action.MAIN"/>
                <category android:name="android.intent.category.LAUNCHER"/>
            </intent-filter>

        </activity>

    </application>

</manifest>
EOF

echo "⚙️ 4) Ensuring correct Gradle namespace..."

if ! grep -q "namespace" app/build.gradle; then
  sed -i 's/android {/android {\n    namespace "com.executiveassistant"/' app/build.gradle
fi

echo "🧪 5) Checking Gradle setup..."
./gradlew tasks --quiet || true

echo "🚀 6) Building Debug APK..."
./gradlew assembleDebug --stacktrace

echo "🚀 7) Building Release APK..."
./gradlew assembleRelease --stacktrace || true

echo "📦 8) Searching APK output..."
find app/build/outputs -name "*.apk" || true

echo "======================================"
echo "✅ FIX + BUILD COMPLETED"
echo "======================================"
