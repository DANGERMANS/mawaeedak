# MOBILE_MIGRATION_PLAN

## الحكم التنفيذي

تحويل مواعيدك إلى Mobile-first يتم داخل `mobile/` فقط. تطبيق الويب داخل `artifacts/mawaeedak/` مرجع للوظائف والهوية والنصوص فقط، وليس مصدراً للكود المنقول.

## الفرع

- Base branch: `codex/setup-control-files`
- Work branch: `codex/mobile-web-to-mobile-controlled-migration`
- ممنوع العمل على `main`.

## قواعد ثابتة

- `mobile/` هو تطبيق الجوال الحقيقي.
- ممنوع WebView.
- ممنوع نسخ HTML/CSS/DOM من الويب.
- ممنوع تعديل `artifacts/mawaeedak/` في هذه الهجرة.
- ممنوع تعديل لوحة المالك أو API أو Supabase/RLS في هذه المهمة.
- التصميم الحالي المفعل خارج `mobile/` مجمد.
- البيانات الرسمية لا تعرض كحقيقة قبل ربط المصدر الرسمي.
- أي زر أو تبويب يجب أن يكون له إجراء ظاهر.

## ترتيب المراحل

| Phase | الاسم | الهدف | حالة التنفيذ في هذه المهمة |
|---|---|---|---|
| 0 | Setup and Migration Control | تثبيت الخطة والحالة | PARTIAL: تمت الخطة والحالة، ولم يكن `mobile/` موجوداً على base branch |
| 1 | Mobile Foundation Shell | منع شاشة `null` وبناء shell | PARTIAL: تم إنشاء مدخل جوال يستدعي `MobileApp` |
| 2 | Mobile Navigation | تبويب سفلي حقيقي | PARTIAL: تم بناء تبويبات: الرئيسية، الرواتب، الخدمات، التقويم، المزيد |
| 3 | Mobile Design System | مكونات أصلية داخل mobile | PARTIAL: تم إنشاء مكونات أساسية، وبعضها يستخدم createElement لتجاوز قيود الأداة |
| 4 | Home Screen Migration | Home أولي آمن | PARTIAL: شاشة رئيسية أولية بدون بيانات رسمية مزيفة |
| 5 | Salaries Screen Migration | شاشة الرواتب والدعم | PARTIAL: بنية بطاقات بدون بيانات رسمية |
| 6 | Services Screen Migration | شاشة الخدمات بالترتيب المعتمد | PARTIAL: الترتيب المعتمد موجود كبطاقات |
| 7 | Calendar Screen Migration | تقويم أولي | PARTIAL: شاشة تقويم لا تدعي CRUD حقيقي |
| 8 | More / Account Screen Migration | المزيد والحساب | PARTIAL: شاشة المزيد موجودة، بدون حذف حساب وهمي |
| 9 | Auth and User Session Plan | خطة Auth للجوال | DOCUMENTED ONLY |
| 10 | Supabase/Data Source Alignment | مصدر بيانات الجوال | DOCUMENTED ONLY |
| 11 | Reminders/Notifications Architecture | بنية ذكرني والإشعارات | DOCUMENTED ONLY |
| 12 | QA/Accessibility/Arabic | قائمة فحص | DOCUMENTED ONLY |
| 13 | Build/DevOps Readiness | typecheck/Expo/doctor | BLOCKED: لا تشغيل محلي داخل هذه البيئة |
| 14 | Store/Legal/Support/Monitoring | جاهزية غير برمجية | DOCUMENTED ONLY |
| 15 | Final Status | تقرير الحالة | PARTIAL |

## قرار البنية

البنية الحالية تؤسس shell جوال أصلي داخل `mobile/`. لا تعتبر الهجرة مكتملة. المرحلة التالية الآمنة هي تشغيل `npm run typecheck` داخل `mobile/` وإصلاح أخطاء TypeScript/Expo داخل `mobile/` فقط.
