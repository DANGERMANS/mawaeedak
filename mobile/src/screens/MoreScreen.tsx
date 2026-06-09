/**
 * More Screen — Mawaeedak Mobile
 * 
 * Settings, account, and app information
 */

import React, { useState, useEffect } from 'react';
import { View, Text, StyleSheet, ScrollView, TouchableOpacity, Switch, Alert } from 'react-native';
import { THEME } from '../constants/theme';
import { Card } from '../components/Card';
import { settingsStorage, userStorage } from '../storage/LocalStorage';
import type { AppSettings } from '../types/app';

interface MenuItemProps {
  icon: string;
  label: string;
  onPress: () => void;
  rightText?: string;
  danger?: boolean;
}

const MenuItem: React.FC<MenuItemProps> = ({ icon, label, onPress, rightText, danger }) => (
  <TouchableOpacity style={styles.menuItem} onPress={onPress}>
    <Text style={styles.menuIcon}>{icon}</Text>
    <Text style={[styles.menuLabel, danger && styles.menuLabelDanger]}>{label}</Text>
    {rightText && <Text style={styles.menuRightText}>{rightText}</Text>}
    <Text style={styles.menuArrow}>←</Text>
  </TouchableOpacity>
);

export const MoreScreen: React.FC = () => {
  const [settings, setSettings] = useState<AppSettings | null>(null);
  const [user, setUser] = useState<{ name?: string; email?: string } | null>(null);

  useEffect(() => {
    loadData();
  }, []);

  const loadData = async () => {
    const [settingsData, userData] = await Promise.all([
      settingsStorage.get(),
      userStorage.get(),
    ]);
    setSettings(settingsData);
    setUser(userData);
  };

  const handleToggleSetting = async (key: keyof AppSettings, value: boolean) => {
    await settingsStorage.update({ [key]: value });
    const updated = await settingsStorage.get();
    setSettings(updated);
  };

  const handleTimeFormatToggle = async () => {
    const newFormat = settings?.timeFormat === '12h' ? '24h' : '12h';
    await settingsStorage.update({ timeFormat: newFormat });
    const updated = await settingsStorage.get();
    setSettings(updated);
  };

  const handleLogout = () => {
    Alert.alert(
      'تسجيل الخروج',
      'هل أنت متأكد من تسجيل الخروج؟',
      [
        { text: 'إلغاء', style: 'cancel' },
        {
          text: 'تسجيل الخروج',
          style: 'destructive',
          onPress: async () => {
            await userStorage.clear();
            Alert.alert('تم', 'تم تسجيل الخروج');
          },
        },
      ]
    );
  };

  const handleDeleteAccount = () => {
    Alert.alert(
      'حذف الحساب',
      'يتطلب حذف الحساب الربط بقاعدة البيانات. هذه الميزة غير متاحة حالياً.',
      [{ text: 'حسناً' }]
    );
  };

  return (
    <ScrollView style={styles.container} contentContainerStyle={styles.content}>
      {/* Header */}
      <View style={styles.header}>
        <Text style={styles.title}>المزيد</Text>
      </View>

      {/* Account Section */}
      <Text style={styles.sectionTitle}>حسابي</Text>
      <Card>
        <MenuItem
          icon="👤"
          label="حسابي"
          onPress={() => Alert.alert('حسابي', 'إدارة الحساب الشخصي')}
          rightText={user?.name || 'غير محدد'}
        />
        <View style={styles.divider} />
        <MenuItem
          icon="🏙️"
          label="المدينة"
          onPress={() => Alert.alert('المدينة', 'الرياض - تغيير المدينة')}
          rightText={settings?.city || 'الرياض'}
        />
      </Card>

      {/* Notifications Section */}
      <Text style={styles.sectionTitle}>الإشعارات</Text>
      <Card>
        <View style={styles.switchItem}>
          <View style={styles.switchLeft}>
            <Text style={styles.menuIcon}>🔔</Text>
            <Text style={styles.menuLabel}>تفعيل الإشعارات</Text>
          </View>
          <Switch
            value={settings?.notificationsEnabled ?? true}
            onValueChange={(v) => handleToggleSetting('notificationsEnabled', v)}
            trackColor={{ false: THEME.border, true: THEME.primary + '60' }}
            thumbColor={settings?.notificationsEnabled ? THEME.primary : '#f4f3f4'}
          />
        </View>
      </Card>

      {/* Time & Calendar Section */}
      <Text style={styles.sectionTitle}>الوقت والتقويم</Text>
      <Card>
        <MenuItem
          icon="🕐"
          label="صيغة الوقت"
          onPress={handleTimeFormatToggle}
          rightText={settings?.timeFormat === '12h' ? '12 ساعة' : '24 ساعة'}
        />
        <View style={styles.divider} />
        <MenuItem
          icon="🕌"
          label="مصدر مواقيت الصلاة"
          onPress={() => Alert.alert('مصدر مواقيت الصلاة', 'تلقائي - من المصادر الرسمية')}
          rightText="تلقائي"
        />
      </Card>

      {/* Appearance Section */}
      <Text style={styles.sectionTitle}>المظهر</Text>
      <Card>
        <MenuItem
          icon="🎨"
          label="الثيمات"
          onPress={() => Alert.alert('الثيمات', 'الإطار - فاتح - داكن')}
          rightText="الإطار"
        />
        <View style={styles.divider} />
        <MenuItem
          icon="🌙"
          label="الوضع الليلي"
          onPress={() => Alert.alert('الوضع الليلي', 'غير متاح حالياً')}
          rightText="غير متاح"
        />
      </Card>

      {/* Legal Section */}
      <Text style={styles.sectionTitle}>قانوني</Text>
      <Card>
        <MenuItem
          icon="📜"
          label="سياسة الخصوصية"
          onPress={() => Alert.alert('سياسة الخصوصية', 'سيتم عرض سياسة الخصوصية عند توفر الربط')}
        />
        <View style={styles.divider} />
        <MenuItem
          icon="📋"
          label="الشروط والأحكام"
          onPress={() => Alert.alert('الشروط والأحكام', 'سيتم عرض الشروط عند توفر الربط')}
        />
      </Card>

      {/* About Section */}
      <Text style={styles.sectionTitle}>عن التطبيق</Text>
      <Card>
        <MenuItem
          icon="ℹ️"
          label="عن مواعيدك"
          onPress={() => Alert.alert('مواعيدك', 'الإصدار 0.1.0\nتطبيق إدارة المواعيد والمواعيد المالية')}
        />
      </Card>

      {/* Account Actions */}
      <View style={styles.accountActions}>
        <TouchableOpacity style={styles.logoutButton} onPress={handleLogout}>
          <Text style={styles.logoutIcon}>🚪</Text>
          <Text style={styles.logoutText}>تسجيل الخروج</Text>
        </TouchableOpacity>
        
        <TouchableOpacity style={styles.deleteButton} onPress={handleDeleteAccount}>
          <Text style={styles.deleteText}>حذف الحساب</Text>
        </TouchableOpacity>
      </View>

      {/* Footer */}
      <Text style={styles.footer}>بسم الله توكلت</Text>
    </ScrollView>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: THEME.background,
  },
  content: {
    padding: THEME.spacing.md,
    paddingBottom: THEME.spacing.xxl,
  },
  
  // Header
  header: {
    marginBottom: THEME.spacing.lg,
  },
  title: {
    fontSize: THEME.fontSize.xxl,
    fontWeight: THEME.fontWeight.bold,
    color: THEME.text,
  },
  
  // Section
  sectionTitle: {
    fontSize: THEME.fontSize.sm,
    fontWeight: THEME.fontWeight.medium,
    color: THEME.textSecondary,
    marginBottom: THEME.spacing.sm,
    marginTop: THEME.spacing.md,
    paddingRight: THEME.spacing.xs,
  },
  
  // Menu Item
  menuItem: {
    flexDirection: 'row-reverse',
    alignItems: 'center',
    paddingVertical: THEME.spacing.sm + 2,
  },
  menuIcon: {
    fontSize: 20,
    marginLeft: THEME.spacing.md,
  },
  menuLabel: {
    flex: 1,
    fontSize: THEME.fontSize.md,
    color: THEME.text,
  },
  menuLabelDanger: {
    color: THEME.error,
  },
  menuRightText: {
    fontSize: THEME.fontSize.sm,
    color: THEME.textSecondary,
    marginLeft: THEME.spacing.sm,
  },
  menuArrow: {
    fontSize: 16,
    color: THEME.textMuted,
    marginRight: THEME.spacing.sm,
  },
  divider: {
    height: 1,
    backgroundColor: THEME.borderLight,
    marginVertical: THEME.spacing.xs,
  },
  
  // Switch Item
  switchItem: {
    flexDirection: 'row-reverse',
    justifyContent: 'space-between',
    alignItems: 'center',
    paddingVertical: THEME.spacing.sm + 2,
  },
  switchLeft: {
    flexDirection: 'row-reverse',
    alignItems: 'center',
  },
  
  // Account Actions
  accountActions: {
    marginTop: THEME.spacing.xl,
    gap: THEME.spacing.md,
  },
  logoutButton: {
    flexDirection: 'row-reverse',
    alignItems: 'center',
    justifyContent: 'center',
    backgroundColor: THEME.surface,
    borderRadius: THEME.radius.md,
    padding: THEME.spacing.md,
    borderWidth: 1,
    borderColor: THEME.border,
    gap: THEME.spacing.sm,
  },
  logoutIcon: {
    fontSize: 18,
  },
  logoutText: {
    fontSize: THEME.fontSize.md,
    color: THEME.text,
    fontWeight: THEME.fontWeight.medium,
  },
  deleteButton: {
    alignItems: 'center',
    padding: THEME.spacing.md,
  },
  deleteText: {
    fontSize: THEME.fontSize.sm,
    color: THEME.error,
  },
  
  // Footer
  footer: {
    textAlign: 'center',
    color: THEME.textSecondary,
    fontSize: THEME.fontSize.sm,
    marginTop: THEME.spacing.xl,
    fontStyle: 'italic',
  },
});

export default MoreScreen;