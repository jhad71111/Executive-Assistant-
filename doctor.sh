#!/data/data/com.termux/files/usr/bin/bash

echo "==============================="
echo " ANDROID PROJECT DOCTOR TOOL "
echo "==============================="

echo ""
echo "[1] Checking project structure..."

required_files=(
"settings.gradle"
"build.gradle"
"gradlew"
"app/build.gradle"
"app/src/main/AndroidManifest.xml"
)

for file in "${required_files[@]}"
do
    if [ -f "$file" ]; then
        echo "✅ Found: $file"
    else
        echo "❌ Missing: $file"
    fi
done

echo ""
echo "[2] Checking Gradle Wrapper..."

if grep -q "gradle-8.2-bin.zip" gradle/wrapper/gradle-wrapper.properties; then
    echo "✅ Gradle wrapper OK"
else
    echo "❌ Gradle wrapper invalid"
fi

echo ""
echo "[3] Checking AndroidX..."

if grep -q "android.useAndroidX=true" gradle.properties; then
    echo "✅ AndroidX enabled"
else
    echo "❌ AndroidX missing"
fi

if grep -q "android.enableJetifier=true" gradle.properties; then
    echo "✅ Jetifier enabled"
else
    echo "❌ Jetifier missing"
fi

echo ""
echo "[4] Checking namespace..."

if grep -q "namespace" app/build.gradle; then
    echo "✅ Namespace found"
else
    echo "❌ Namespace missing"
fi

echo ""
echo "[5] Checking plugins..."

if grep -q "com.android.application" app/build.gradle; then
    echo "✅ Android plugin found"
else
    echo "❌ Android plugin missing"
fi

echo ""
echo "[6] Checking SDK versions..."

grep "compileSdk" app/build.gradle
grep "targetSdk" app/build.gradle
grep "minSdk" app/build.gradle

echo ""
echo "[7] Running Gradle diagnostics..."

chmod +x gradlew

./gradlew tasks > gradle_tasks.log 2>&1

if [ $? -eq 0 ]; then
    echo "✅ Gradle responding"
else
    echo "❌ Gradle broken"
fi

echo ""
echo "[8] Attempting APK build..."

./gradlew clean assembleDebug --stacktrace > build_error.log 2>&1

if [ $? -eq 0 ]; then
    echo "✅ APK BUILD SUCCESS"
else
    echo "❌ APK BUILD FAILED"
    echo ""
    echo "========== ERROR REPORT =========="
    tail -n 80 build_error.log
    echo "=================================="
fi

echo ""
echo "[9] Checking workflow files..."

if [ -d ".github/workflows" ]; then
    ls .github/workflows
else
    echo "❌ No workflows found"
fi

echo ""
echo "DONE."
