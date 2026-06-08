# MOBILE_MIGRATION_STATUS

## الحالة العامة

Verdict: NEEDS FIXES

تم بدء تحويل controlled migration على فرع العمل فقط. لم يتم تعديل `main`. لم يتم تعديل الويب أو لوحة المالك أو API أو Supabase/RLS.

## الفرع

- Base: `codex/setup-control-files`
- Work: `codex/mobile-web-to-mobile-controlled-migration`

## ملاحظة واقع مهمة

فرع الأساس `codex/setup-control-files` لم يكن يحتوي `mobile/` وقت التنفيذ، لذلك تم إنشاء بنية `mobile/` داخل فرع العمل. تم استخدام ملفات الويب كمرجع قراءة فقط.

## ما تم

- إنشاء `mobile/package.json`.
- إنشاء `mobile/app.json`.
- إنشاء `mobile/eas.json`.
- إنشاء `mobile/tsconfig.json`.
- إنشاء `mobile/expo-env.d.ts`.
- إنشاء `mobile/app/_layout.tsx`.
- إنشاء `mobile/app/index.tsx` بحيث يستدعي `MobileApp` ولا يرجع `null`.
- إنشاء `mobile/src/theme.ts`.
- إنشاء مكونات داخل `mobile/src/components`.
- إنشاء `mobile/src/MobileApp.tsx` مع تبويب سفلي بالترتيب:
  1. الرئيسية
  2. الرواتب
  3. الخدمات
  4. التقويم
  5. المزيد
- إضافة شاشات أولية غير فارغة لكل تبويب.
- منع عرض بيانات رسمية مزيفة؛ كل البيانات الرسمية حالتها انتظار ربط.
- إنشاء خطة الهجرة.
- إنشاء `docs/MOBILE_QA_CHECKLIST.md`.
- إنشاء `docs/MOBILE_RELEASE_READINESS.md` كوثيقة حالة فقط.

## التحقق المطلوب ونتيجته

| الأمر | النتيجة | السبب |
|---|---|---|
| `npm run typecheck` داخل `mobile/` | BLOCKED / NOT RUN | فشل استنساخ المستودع محلياً بسبب DNS: `Could not resolve host: github.com` |
| `npm run doctor` داخل `mobile/` | BLOCKED / NOT RUN | يعتمد على وجود clone/runtime محلي، وهو غير متاح بسبب فشل DNS |
| `npx expo start --clear` داخل `mobile/` | BLOCKED / NOT RUN | يعتمد على clone/runtime محلي، وهو غير متاح بسبب فشل DNS |
| Runtime device/simulator | UNVERIFIED | لم يتم فتح التطبيق على جهاز أو محاكي |

## ما لم يتم

- لم يتم تشغيل `npm run typecheck` فعلياً.
- لم يتم تشغيل `npx expo start --clear` فعلياً.
- لم يتم تشغيل `npm run doctor` فعلياً.
- لم يتم اختبار الجهاز أو المحاكي.
- لم يتم تنفيذ Auth حقيقي.
- لم يتم ربط Supabase للجوال.
- لم يتم تنفيذ CRUD حقيقي للتقويم.
- لم يتم تنفيذ push notifications حقيقية.
- لم يتم تجهيز App Store / Google Play فعلياً.

## حالة المراحل

| Phase | Status | ملاحظة |
|---|---|---|
| 0 | PARTIAL | docs أُنشئت، لكن التحقق المحلي غير منفذ |
| 1 | PARTIAL | shell موجود، يحتاج typecheck/runtime |
| 2 | PARTIAL | التبويبات موجودة، تحتاج runtime test |
| 3 | PARTIAL | مكونات أساسية موجودة، تحتاج مراجعة كود |
| 4 | PARTIAL | Home أولي آمن |
| 5 | PARTIAL | Salaries أولي آمن |
| 6 | PARTIAL | Services بالترتيب المعتمد |
| 7 | PARTIAL | Calendar بدون CRUD وهمي |
| 8 | PARTIAL | More بدون حذف حساب وهمي |
| 9 | DOCUMENTED ONLY | لا Auth فعلي |
| 10 | DOCUMENTED ONLY | لا ربط بيانات فعلي |
| 11 | DOCUMENTED ONLY | لا إرسال إشعارات فعلي |
| 12 | DOCUMENTED ONLY | checklist موجود لكن runtime غير مؤكد |
| 13 | BLOCKED | أوامر التحقق لم تعمل محلياً بسبب DNS |
| 14 | PARTIAL | release readiness doc موجود كحالة فقط |
| 15 | PARTIAL | هذه الحالة الحالية |

## المخاطر

- TypeScript/Expo غير مؤكدين حتى يتم تشغيل typecheck.
- `mobile/` جديد على فرع العمل وقد يحتاج ضبط workspace إن أراد الفريق تشغيله من الجذر.
- بعض المكونات أُنشئت بصيغة `createElement` بسبب حظر أداة GitHub لبعض ملفات JSX، وهذا يحتاج مراجعة جودة لاحقة.
- لا يوجد ربط حقيقي للبيانات أو Auth أو الإشعارات.
- لا يوجد دليل runtime أن Expo يفتح فعلياً.

## next safe step

تشغيل `npm run typecheck` داخل `mobile/` على بيئة محلية لديها وصول GitHub/Node/Expo، ثم إصلاح أخطاء TypeScript/Expo داخل `mobile/` فقط.
