/**
 * More Screen — Settings, Profile, and App Info
 * 
 * Features:
 * - User profile section
 * - App settings
 * - Theme selection
 * - Notifications settings
 * - Share app
 * - Privacy policy
 * - Logout
 */

import { View, Text, StyleSheet, ScrollView, Pressable, Switch, Alert } from 'react-native';
import { I18nManager } from 'react-native';

// Theme colors
const THEME = {
  primary: '#C9A063',
  secondary: '#8A6B3D',
  background: '#FAF7F2',
  surface: '#FFFFFF',
  text: '#2F2B25',
  textSecondary: '#6F6557',
  border: '#DCD7CF',
  error: '#B45A4D',
  success: '#7A9A74',
};

// Menu items
const MENU_SECTIONS = [
  {
    title: 'الحساب',
    items: [
      { id: 1, icon: '👤', title: 'حسابي', subtitle: 'الملف الشخصي والإعدادات', type: 'navigate' },
      { id: 2, icon: '🔔', title: 'الإشعارات', subtitle: 'إعدادات التنبيهات', type: 'navigate' },
    ],
  },
  {
    title: 'التطبيق',
    items: [
      { id: 3, icon: '🎨', title: 'الثيمات', subtitle: 'تغيير مظهر التطبيق', type: 'navigate' },
      { id: 4, icon: '🌙', title: 'الوضع الليلي', subtitle: 'تفعيل الوضع الداكن', type: 'switch', value: false },
      { id: 5, icon: '🌐', title: 'اللغة', subtitle: 'العربية', type: 'navigate' },
    ],
  },
  {
    title: 'المزيد',
    items: [
      { id: 6, icon: '📤', title: 'مشاركة التطبيق', subtitle: 'ادعُ أصدقاءك', type: 'action' },
      { id: 7, icon: '📜', title: 'سياسة الخصوصية', subtitle: 'اقرأ سياسة الخصوصية', type: 'navigate' },
      { id: 8, icon: '📋', title: 'الشروط والأحكام', subtitle: 'شروط استخدام التطبيق', type: 'navigate' },
      { id: 9, icon: '💬', title: 'المساعدة والدعم', subtitle: 'تواصل معنا', type: 'navigate' },
      { id: 10, icon: 'ℹ️', title: 'عن التطبيق', subtitle: 'الإصدار 1.0.0', type: 'navigate' },
    ],
  },
];

export default function MoreScreen() {
  const handleLogout = () => {
    Alert.alert(
      'تسجيل الخروج',
      'هل أنت متأكد من تسجيل الخروج؟',
      [
        { text: 'إلغاء', style: 'cancel' },
        { text: 'تسجيل الخروج', style: 'destructive', onPress: () => console.log('Logout') },
      ]
    );
  };

  const handleMenuPress = (item: { id: number; title: string; type: string }) => {
    if (item.type === 'action') {
      if (item.id === 6) {
        Alert.alert('مشاركة التطبيق', 'رابط المشاركة: mawaeedak.app');
      }
    }
  };

  return (
    <ScrollView style={styles.container} showsVerticalScrollIndicator={false}>
      {/* Header */}
      <View style={styles.header}>
        <Text style={styles.headerTitle}>المزيد</Text>
      </View>

      {/* Profile Card */}
      <View style={styles.profileCard}>
        <View style={styles.profileAvatar}>
          <Text style={styles.profileAvatarText}>م</Text>
        </View>
        <View style={styles.profileInfo}>
          <Text style={styles.profileName}>مستخدم التطبيق</Text>
          <Text style={styles.profileEmail}>user@mawaeedak.sa</Text>
        </View>
        <Pressable style={styles.editButton}>
          <Text style={styles.editButtonText}>تعديل</Text>
        </Pressable>
      </View>

      {/* Menu Sections */}
      {MENU_SECTIONS.map((section) => (
        <View key={section.title} style={styles.menuSection}>
          <Text style={styles.menuSectionTitle}>{section.title}</Text>
          <View style={styles.menuCard}>
            {section.items.map((item, index) => (
              <Pressable
                key={item.id}
                style={[
                  styles.menuItem,
                  index < section.items.length - 1 && styles.menuItemBorder,
                ]}
                onPress={() => handleMenuPress(item)}
              >
                <Text style={styles.menuIcon}>{item.icon}</Text>
                <View style={styles.menuContent}>
                  <Text style={styles.menuTitle}>{item.title}</Text>
                  <Text style={styles.menuSubtitle}>{item.subtitle}</Text>
                </View>
                {item.type === 'switch' ? (
                  <Switch
                    value={false}
                    trackColor={{ false: THEME.border, true: THEME.primary }}
                    thumbColor={THEME.surface}
                  />
                ) : item.type === 'navigate' ? (
                  <Text style={styles.menuArrow}>›</Text>
                ) : null}
              </Pressable>
            ))}
          </View>
        </View>
      ))}

      {/* Logout Button */}
      <Pressable style={styles.logoutButton} onPress={handleLogout}>
        <Text style={styles.logoutIcon}>🚪</Text>
        <Text style={styles.logoutText}>تسجيل الخروج</Text>
      </Pressable>

      {/* App Branding */}
      <View style={styles.branding}>
        <Text style={styles.brandingLogo}>🕌 مواعيدك</Text>
        <Text style={styles.brandingTagline}>بسم الله توكلت</Text>
        <Text style={styles.brandingVersion}>الإصدار 1.0.0</Text>
      </View>

      {/* Footer spacing */}
      <View style={styles.footer} />
    </ScrollView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: THEME.background,
    direction: I18nManager.isRTL ? 'rtl' : 'ltr',
  },
  header: {
    paddingHorizontal: 20,
    paddingTop: 60,
    paddingBottom: 20,
  },
  headerTitle: {
    fontSize: 28,
    fontWeight: 'bold',
    color: THEME.text,
  },

  // Profile Card
  profileCard: {
    backgroundColor: THEME.surface,
    marginHorizontal: 16,
    borderRadius: 20,
    padding: 20,
    flexDirection: 'row',
    alignItems: 'center',
    borderWidth: 1,
    borderColor: THEME.border,
    marginBottom: 24,
  },
  profileAvatar: {
    width: 60,
    height: 60,
    borderRadius: 30,
    backgroundColor: THEME.primary,
    justifyContent: 'center',
    alignItems: 'center',
    marginLeft: 16,
  },
  profileAvatarText: {
    fontSize: 28,
    fontWeight: 'bold',
    color: '#FFF',
  },
  profileInfo: {
    flex: 1,
  },
  profileName: {
    fontSize: 18,
    fontWeight: 'bold',
    color: THEME.text,
    marginBottom: 4,
  },
  profileEmail: {
    fontSize: 14,
    color: THEME.textSecondary,
  },
  editButton: {
    backgroundColor: THEME.background,
    paddingHorizontal: 16,
    paddingVertical: 8,
    borderRadius: 12,
    borderWidth: 1,
    borderColor: THEME.border,
  },
  editButtonText: {
    fontSize: 14,
    fontWeight: '600',
    color: THEME.primary,
  },

  // Menu Sections
  menuSection: {
    marginBottom: 20,
    paddingHorizontal: 16,
  },
  menuSectionTitle: {
    fontSize: 14,
    fontWeight: '600',
    color: THEME.textSecondary,
    marginBottom: 8,
    marginRight: 4,
  },
  menuCard: {
    backgroundColor: THEME.surface,
    borderRadius: 16,
    overflow: 'hidden',
    borderWidth: 1,
    borderColor: THEME.border,
  },
  menuItem: {
    flexDirection: 'row',
    alignItems: 'center',
    paddingVertical: 14,
    paddingHorizontal: 16,
  },
  menuItemBorder: {
    borderBottomWidth: 1,
    borderBottomColor: THEME.border,
  },
  menuIcon: {
    fontSize: 22,
    marginLeft: 14,
  },
  menuContent: {
    flex: 1,
  },
  menuTitle: {
    fontSize: 16,
    fontWeight: '600',
    color: THEME.text,
    marginBottom: 2,
  },
  menuSubtitle: {
    fontSize: 13,
    color: THEME.textSecondary,
  },
  menuArrow: {
    fontSize: 24,
    color: THEME.textSecondary,
  },

  // Logout Button
  logoutButton: {
    backgroundColor: THEME.surface,
    marginHorizontal: 16,
    borderRadius: 16,
    paddingVertical: 16,
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'center',
    borderWidth: 1,
    borderColor: THEME.error,
    marginBottom: 24,
  },
  logoutIcon: {
    fontSize: 20,
    marginLeft: 8,
  },
  logoutText: {
    fontSize: 16,
    fontWeight: '600',
    color: THEME.error,
  },

  // Branding
  branding: {
    alignItems: 'center',
    paddingVertical: 24,
  },
  brandingLogo: {
    fontSize: 24,
    marginBottom: 4,
  },
  brandingTagline: {
    fontSize: 14,
    color: THEME.textSecondary,
    marginBottom: 8,
    fontStyle: 'italic',
  },
  brandingVersion: {
    fontSize: 12,
    color: THEME.textSecondary,
  },

  footer: {
    height: 100,
  },
});