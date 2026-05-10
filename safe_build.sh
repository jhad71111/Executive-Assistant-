#!/data/data/com.termux/files/usr/bin/bash

echo "🚀 بدء فحص وبناء المشروع..."

# تنظيف البناء
echo "🧹 تنظيف المشروع..."
./gradlew clean || true

# فحص الملفات الأساسية
echo "🔍 فحص المشروع..."
if [ ! -d "app" ]; then
  echo "❌ خطأ: مجلد app غير موجود (هذا يعني مشروع Android غير مكتمل)"
  exit 1
fi

if [ ! -f "gradlew" ]; then
  echo "❌ خطأ: gradlew غير موجود"
  exit 1
fi

# محاولة البناء
echo "⚙️ محاولة بناء APK..."
./gradlew assembleDebug --stacktrace

# التحقق من الناتج
APK_PATH=$(find . -name "*.apk" | head -n 1)

if [ -z "$APK_PATH" ]; then
  echo "❌ فشل: لم يتم إنشاء APK"
  echo "📌 السبب غالبًا من Gradle أو Android project structure"
else
  echo "✅ نجاح! تم إنشاء APK:"
  echo "$APK_PATH"
fi
