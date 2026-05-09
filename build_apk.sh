#!/data/data/com.termux/files/usr/bin/bash
./gradlew clean
./gradlew assembleDebug
cp app/build/outputs/apk/debug/app-debug.apk ./ExecutiveAssistant.apk
echo "✅ APK جاهز: ExecutiveAssistant.apk"
