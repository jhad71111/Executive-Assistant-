#!/data/data/com.termux/files/usr/bin/bash
set -e

echo "🔧 إنشاء هيكل مشروع Android..."

# إنشاء مجلدات أساسية
mkdir -p app/src/main/java/com/executiveassistant
mkdir -p app/src/main/res/layout
mkdir -p app/src/main/res/values

# ملف Gradle رئيسي
cat > build.gradle <<'EOF'
buildscript {
    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        classpath 'com.android.tools.build:gradle:8.3.0'
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}
EOF

# ملف إعدادات Gradle
cat > settings.gradle <<'EOF'
include ':app'
rootProject.name = "ExecutiveAssistant"
EOF

# build.gradle داخل app
cat > app/build.gradle <<'EOF'
plugins {
    id 'com.android.application'
}

android {
    namespace "com.executiveassistant"
    compileSdk 34

    defaultConfig {
        applicationId "com.executiveassistant"
        minSdk 24
        targetSdk 34
        versionCode 1
        versionName "1.0"
    }

    buildTypes {
        release {
            minifyEnabled false
        }
    }
}

dependencies {
    implementation 'androidx.appcompat:appcompat:1.6.1'
    implementation 'com.google.android.material:material:1.11.0'
}
EOF

# AndroidManifest.xml
cat > app/src/main/AndroidManifest.xml <<'EOF'
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="com.executiveassistant">

    <application
        android:allowBackup="true"
        android:label="Executive Assistant"
        android:supportsRtl="true"
        android:theme="@style/Theme.AppCompat.Light.DarkActionBar">
        <activity android:name=".MainActivity">
            <intent-filter>
                <action android:name="android.intent.action.MAIN"/>
                <category android:name="android.intent.category.LAUNCHER"/>
            </intent-filter>
        </activity>
    </application>
</manifest>
EOF

# MainActivity.java
cat > app/src/main/java/com/executiveassistant/MainActivity.java <<'EOF'
package com.executiveassistant;

import android.os.Bundle;
import androidx.appcompat.app.AppCompatActivity;
import android.widget.TextView;

public class MainActivity extends AppCompatActivity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        TextView tv = new TextView(this);
        tv.setText("🚀 المساعد التنفيذي جاهز بلا قيود!");
        setContentView(tv);
    }
}
EOF

# سكربت بناء APK
cat > build_apk.sh <<'EOF'
#!/data/data/com.termux/files/usr/bin/bash
./gradlew clean
./gradlew assembleDebug
cp app/build/outputs/apk/debug/app-debug.apk ./ExecutiveAssistant.apk
echo "✅ APK جاهز: ExecutiveAssistant.apk"
EOF
chmod +x build_apk.sh

echo "✅ هيكل Android جاهز. لتوليد APK شغّل: ./build_apk.sh"
