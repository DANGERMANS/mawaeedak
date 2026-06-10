/**
 * More Screen — Settings and Account for Mawaeedak Mobile
 * 
 * Features:
 * - Daily Card access
 * - Account settings
 * - App settings
 * - Logout
 * - Share app
 */

import { useState } from 'react';
import { View, Text, StyleSheet, ScrollView, Pressable, Alert, Share } from 'react-native';
import { Feather } from '@expo/vector-icons';
import { useRouter } from 'expo-router';

// Theme colors
const GOLD = '#C9A063';
const BROWN = '#8A6B3D';
const INK = '#2F2B25';
const PAPER = '#FAF7F2';
const CREAM = '#F5EFE4';
const TEXT_SECONDARY = '#6F6557';
const ERROR = '#B9483F';

// Menu Row Component
function MenuRow({ icon, label, description, onPress, danger = false }: {
  icon: string;
  label: string;
  description?: string;
  onPress: () => void;
  danger?: boolean;
}) {
  return (
    <Pressable style={styles.menuRow} onPress={onPress}>
      <View style={[styles.menuIcon, danger && styles.menuIconDanger]}>
        <Text style={{ fontSize: 22 }}>{icon}</Text>
      </View>
      <View style={styles.menuContent}>
        <Text style={[styles.menuLabel, danger && styles.menuLabelDanger]}>{label}</Text>
        {description && <Text style={styles.menuDescription}>{description}</Text>}
      </View>
      <Feather name="chevron-left" size={20} color={TEXT_SECONDARY} />
    </Pressable>
  );
}

// Daily Card Row Component
function DailyCardRow({ onPress }: { onPress: () => void }) {
  return (
    <Pressable style={styles.dailyCardRow} onPress={onPress}>
      <View style={styles.dailyCardLeft}>
        <View style={styles.dailyCardIcon}>
          <Text style={{ fontSize: 28 }}>🎴</Text>
        </View>
        <View>
          <Text style={styles.dailyCardTitle}>البطاقة اليومية</Text>
          <Text style={styles.dailyCardSubtitle}>شارك يومك مع الآخرين</Text>
        </View>
      </View>
      <Feather name="chevron-left" size={22} color={BROWN} />
    </Pressable>
  );
}

export default function MoreScreen() {
  const router = useRouter();
  const [isLogoutOpen, setIsLogoutOpen] = useState(false);

  const handleDailyCard = () => {
    router.push('/daily-card');
  };

  const handleAccount = () => {
    router.push('/account');
  };

  const handleSettings = () => {
    router.push('/settings');
  };

  const handleShare = async () => {
    try {
      await Share.share({
        title: 'مواعيدك',
        message: 'كل مواعيدك في مكان واحد - تطبيق مواعيدك',
        url: 'https://mawaeedak.app',
      });
    } catch (error) {
      Alert.alert('خطأ', 'فشل مشاركة التطبيق');
    }
  };

  const handleLogout = () => {
    setIsLogoutOpen(true);
    Alert.alert(
      'تسجيل الخروج',
      'هل أنت متأكد من تسجيل الخروج؟',
      [
        { text: 'إلغاء', style: 'cancel', onPress: () => setIsLogoutOpen(false) },
        {
          text: 'تسجيل الخروج',
          style: 'destructive',
          onPress: () => {
            setIsLogoutOpen(false);
            Alert.alert('تم', 'تم تسجيل الخروج بنجاح');
          },
        },
      ]
    );
  };

  const handleAbout = () => {
    Alert.alert(
      'عن التطبيق',
      'مواعيدك v1.0.0\n\nكل مواعيدك في مكان واحد\n\n© 2026 مواعيدك',
      [{ text: 'حسناً' }]
    );
  };

  const handleSupport = () => {
    Alert.alert('الدعم', 'تواصل معنا على: support@mawaeedak.app', [{ text: 'حسناً' }]);
  };

  return (
    <View style={styles.container}>
      <ScrollView
        style={styles.scrollView}
        contentContainerStyle={styles.scrollContent}
        showsVerticalScrollIndicator={false}
      >
        {/* Header */}
        <View style={styles.header}>
          <Text style={styles.headerTitle}>المزيد</Text>
        </View>

        {/* Daily Card Section */}
        <View style={styles.section}>
          <DailyCardRow onPress={handleDailyCard} />
        </View>

        {/* Account Section */}
        <View style={styles.section}>
          <Text style={styles.sectionTitle}>الحساب</Text>
          <View style={styles.menuList}>
            <MenuRow
              icon="👤"
              label="حسابي"
              description="الملف الشخصي والإعدادات"
              onPress={handleAccount}
            />
            <MenuRow
              icon="🔔"
              label="الإشعارات"
              description="إدارة التنبيهات"
              onPress={() => Alert.alert('الإشعارات', 'قريباً')}
            />
          </View>
        </View>

        {/* Settings Section */}
        <View style={styles.section}>
          <Text style={styles.sectionTitle}>الإعدادات</Text>
          <View style={styles.menuList}>
            <MenuRow
              icon="⚙️"
              label="إعدادات التطبيق"
              description="المظهر والإشعارات"
              onPress={handleSettings}
            />
            <MenuRow
              icon="🌍"
              label="المدينة"
              description="الرياض"
              onPress={() => Alert.alert('المدينة', 'الرياض - يمكنك تغييرها من حسابي')}
            />
          </View>
        </View>

        {/* Support Section */}
        <View style={styles.section}>
          <Text style={styles.sectionTitle}>الدعم</Text>
          <View style={styles.menuList}>
            <MenuRow
              icon="💬"
              label="تواصل معنا"
              description="مساعدة واستفسارات"
              onPress={handleSupport}
            />
            <MenuRow
              icon="ℹ️"
              label="عن التطبيق"
              onPress={handleAbout}
            />
          </View>
        </View>

        {/* Actions Section */}
        <View style={styles.section}>
          <View style={styles.menuList}>
            <MenuRow
              icon="📤"
              label="مشاركة التطبيق"
              onPress={handleShare}
            />
            <MenuRow
              icon="🚪"
              label="تسجيل الخروج"
              onPress={handleLogout}
              danger
            />
          </View>
        </View>

        {/* App Version */}
        <View style={styles.footer}>
          <Text style={styles.footerText}>مواعيدك v1.0.0</Text>
          <Text style={styles.footerSubtext}>كل مواعيدك في مكان واحد</Text>
        </View>

        {/* Bottom padding */}
        <View style={{ height: 100 }} />
      </ScrollView>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: PAPER,
  },
  scrollView: {
    flex: 1,
  },
  scrollContent: {
    paddingHorizontal: 16,
    paddingTop: 60,
  },
  header: {
    marginBottom: 24,
  },
  headerTitle: {
    fontSize: 28,
    fontWeight: '800',
    color: INK,
  },
  section: {
    marginBottom: 24,
  },
  sectionTitle: {
    fontSize: 14,
    fontWeight: '600',
    color: TEXT_SECONDARY,
    marginBottom: 12,
    textTransform: 'uppercase',
    letterSpacing: 0.5,
  },
  menuList: {
    backgroundColor: CREAM,
    borderRadius: 16,
    overflow: 'hidden',
    borderWidth: 1,
    borderColor: 'rgba(201,160,99,0.10)',
  },
  menuRow: {
    flexDirection: 'row',
    alignItems: 'center',
    paddingVertical: 16,
    paddingHorizontal: 16,
    borderBottomWidth: 1,
    borderBottomColor: 'rgba(201,160,99,0.08)',
  },
  menuIcon: {
    width: 44,
    height: 44,
    borderRadius: 12,
    backgroundColor: PAPER,
    justifyContent: 'center',
    alignItems: 'center',
    marginRight: 14,
  },
  menuIconDanger: {
    backgroundColor: ERROR + '10',
  },
  menuContent: {
    flex: 1,
  },
  menuLabel: {
    fontSize: 16,
    fontWeight: '600',
    color: INK,
  },
  menuLabelDanger: {
    color: ERROR,
  },
  menuDescription: {
    fontSize: 13,
    color: TEXT_SECONDARY,
    marginTop: 2,
  },
  dailyCardRow: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
    backgroundColor: CREAM,
    borderRadius: 20,
    padding: 18,
    borderWidth: 1,
    borderColor: 'rgba(201,160,99,0.25)',
    shadowColor: '#8A6B3D',
    shadowOffset: { width: 0, height: 4 },
    shadowOpacity: 0.08,
    shadowRadius: 12,
    elevation: 4,
  },
  dailyCardLeft: {
    flexDirection: 'row',
    alignItems: 'center',
  },
  dailyCardIcon: {
    width: 56,
    height: 56,
    borderRadius: 16,
    backgroundColor: GOLD + '20',
    justifyContent: 'center',
    alignItems: 'center',
    marginRight: 14,
  },
  dailyCardTitle: {
    fontSize: 18,
    fontWeight: '700',
    color: INK,
    marginBottom: 2,
  },
  dailyCardSubtitle: {
    fontSize: 13,
    color: TEXT_SECONDARY,
  },
  footer: {
    alignItems: 'center',
    paddingVertical: 24,
  },
  footerText: {
    fontSize: 14,
    fontWeight: '600',
    color: INK,
    marginBottom: 4,
  },
  footerSubtext: {
    fontSize: 12,
    color: TEXT_SECONDARY,
  },
});