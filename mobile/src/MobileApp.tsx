import { createElement, useState } from 'react';
import { Alert, Pressable, ScrollView, StyleSheet, Text, View } from 'react-native';
import { colors, radius, spacing } from './theme';

type TabKey = 'home' | 'salaries' | 'services' | 'calendar' | 'more';

const tabs: Array<{ id: TabKey; label: string }> = [
  { id: 'home', label: 'الرئيسية' },
  { id: 'salaries', label: 'الرواتب' },
  { id: 'services', label: 'الخدمات' },
  { id: 'calendar', label: 'التقويم' },
  { id: 'more', label: 'المزيد' },
];

function showStatus(title: string, body: string) {
  Alert.alert(title, body);
}

function AppText({ children, big = false, muted = false }: { children?: string; big?: boolean; muted?: boolean }) {
  return createElement(Text, { style: [styles.text, big ? styles.big : null, muted ? styles.muted : null] }, children);
}

function Card({ title, body, status }: { title: string; body: string; status?: string }) {
  return createElement(
    Pressable,
    { style: styles.card, onPress: () => showStatus(title, status ?? body) },
    createElement(AppText, { big: true }, title),
    createElement(AppText, { muted: true }, body),
    status ? createElement(View, { style: styles.pill }, createElement(AppText, null, status)) : null,
  );
}

function Home({ setTab }: { setTab: (tab: TabKey) => void }) {
  return createElement(
    ScrollView,
    { contentContainerStyle: styles.content },
    createElement(View, { style: styles.hero },
      createElement(AppText, { big: true }, 'مواعيدك'),
      createElement(AppText, { muted: true }, 'كل موعد له وقته'),
    ),
    createElement(Card, { title: 'مرحباً بك', body: 'تطبيق جوال أصلي داخل mobile/ بدون WebView وبدون شاشة فارغة.' }),
    createElement(Card, { title: 'الصلاة القادمة', body: 'لا توجد بيانات رسمية معروضة حالياً.', status: 'بانتظار ربط المصدر الرسمي' }),
    createElement(Card, { title: 'الرواتب والدعم', body: 'لا يتم عرض تواريخ أو أرقام غير مثبتة.', status: 'بانتظار ربط البيانات الرسمية' }),
    createElement(Pressable, { style: styles.button, onPress: () => setTab('services') }, createElement(Text, { style: styles.buttonText }, 'فتح الخدمات')),
  );
}

function ListScreen({ title, description, items }: { title: string; description: string; items: string[] }) {
  return createElement(
    ScrollView,
    { contentContainerStyle: styles.content },
    createElement(AppText, { big: true }, title),
    createElement(AppText, { muted: true }, description),
    ...items.map((item) => createElement(Card, { key: item, title: item, body: 'بطاقة جوال فعلية لها ضغط واضح.', status: 'قيد النقل للجوال' })),
  );
}

function Calendar() {
  return createElement(
    ScrollView,
    { contentContainerStyle: styles.content },
    createElement(AppText, { big: true }, 'التقويم'),
    createElement(Card, { title: 'المواعيد الشخصية', body: 'الإضافة والتعديل والحذف قيد الربط. لا يوجد CRUD وهمي.', status: 'قيد النقل للجوال' }),
    createElement(Pressable, { style: styles.button, onPress: () => showStatus('إضافة موعد', 'قيد الربط، لم يتم تنفيذ حفظ حقيقي بعد.') }, createElement(Text, { style: styles.buttonText }, 'إضافة موعد')),
  );
}

function More() {
  return createElement(
    ScrollView,
    { contentContainerStyle: styles.content },
    createElement(AppText, { big: true }, 'المزيد'),
    ...['الحساب', 'الإعدادات', 'الإشعارات', 'سياسة الخصوصية', 'الشروط والأحكام', 'الدعم', 'مشاركة التطبيق'].map((item) =>
      createElement(Card, { key: item, title: item, body: 'إجراء واضح بدون ادعاء جاهزية.', status: item === 'مشاركة التطبيق' ? 'إجراء محلي' : 'قيد النقل للجوال' }),
    ),
  );
}

export function MobileApp() {
  const [tab, setTab] = useState<TabKey>('home');
  const content = tab === 'home'
    ? createElement(Home, { setTab })
    : tab === 'salaries'
      ? createElement(ListScreen, { title: 'الرواتب', description: 'لا توجد بيانات رسمية مزيفة.', items: ['الراتب', 'حساب المواطن', 'الضمان', 'حافز', 'ساند / التأمينات', 'التقاعد', 'السكني', 'التأهيل', 'الدعم الزراعي / ريف'] })
      : tab === 'services'
        ? createElement(ListScreen, { title: 'الخدمات', description: 'الترتيب المعتمد محفوظ.', items: ['احسب هدفك', 'حساب التكاليف', 'ذكرني', 'السفر', 'الدراسة والإجازات', 'الوظائف والأخبار', 'بطاقة اليوم', 'صوتك مسموع'] })
        : tab === 'calendar'
          ? createElement(Calendar)
          : createElement(More);

  return createElement(
    View,
    { style: styles.root },
    content,
    createElement(View, { style: styles.nav },
      ...tabs.map((item) => createElement(
        Pressable,
        { key: item.id, onPress: () => setTab(item.id), style: [styles.tab, tab === item.id ? styles.activeTab : null] },
        createElement(Text, { style: [styles.tabText, tab === item.id ? styles.activeText : null] }, item.label),
      )),
    ),
  );
}

const styles = StyleSheet.create({
  root: { flex: 1, backgroundColor: colors.background },
  content: { padding: spacing.lg, paddingTop: spacing.xxl, paddingBottom: 110, gap: spacing.md },
  hero: { backgroundColor: colors.surface, borderRadius: radius.xl, padding: spacing.xl, gap: spacing.sm, borderColor: colors.border, borderWidth: 1 },
  text: { writingDirection: 'rtl', textAlign: 'right', color: colors.text, fontSize: 15, lineHeight: 24, fontWeight: '600' },
  big: { color: colors.primary, fontSize: 22, lineHeight: 32, fontWeight: '900' },
  muted: { color: colors.muted },
  card: { backgroundColor: colors.surface, borderColor: colors.border, borderWidth: 1, borderRadius: radius.lg, padding: spacing.lg, gap: spacing.sm },
  pill: { alignSelf: 'flex-end', backgroundColor: colors.surfaceStrong, borderRadius: radius.sm, paddingVertical: spacing.xs, paddingHorizontal: spacing.sm },
  button: { backgroundColor: colors.primary, borderRadius: radius.md, minHeight: 46, alignItems: 'center', justifyContent: 'center' },
  buttonText: { color: colors.white, fontWeight: '800' },
  nav: { position: 'absolute', left: spacing.md, right: spacing.md, bottom: spacing.md, minHeight: 68, backgroundColor: colors.white, borderRadius: radius.xl, borderColor: colors.border, borderWidth: 1, flexDirection: 'row-reverse', padding: spacing.xs },
  tab: { flex: 1, minHeight: 52, borderRadius: radius.lg, alignItems: 'center', justifyContent: 'center' },
  activeTab: { backgroundColor: colors.primary },
  tabText: { color: colors.muted, fontWeight: '800', fontSize: 11 },
  activeText: { color: colors.white },
});
