/**
 * Home Screen — Mawaeedak Mobile
 */

import React, { useEffect, useState } from 'react';
import { View, Text, StyleSheet, ScrollView, RefreshControl } from 'react-native';
import { THEME } from '../constants/theme';
import { Card, SectionHeader, PendingBanner } from '../components/Card';
import { userStorage, settingsStorage } from '../storage/LocalStorage';
import type { AppSettings } from '../types/app';

interface UserProfile {
  name?: string;
  email?: string;
}

export const HomeScreen: React.FC = () => {
  const [user, setUser] = useState<UserProfile | null>(null);
  const [settings, setSettings] = useState<AppSettings | null>(null);
  const [refreshing, setRefreshing] = useState(false);

  useEffect(() => {
    loadData();
  }, []);

  const loadData = async () => {
    const [userData, settingsData] = await Promise.all([
      userStorage.get(),
      settingsStorage.get(),
    ]);
    setUser(userData);
    setSettings(settingsData);
  };

  const onRefresh = async () => {
    setRefreshing(true);
    await loadData();
    setRefreshing(false);
  };

  // Greeting based on time
  const getGreeting = () => {
    const hour = new Date().getHours();
    if (hour < 12) return 'صباح الخير';
    if (hour < 18) return 'مساء الخير';
    return 'مساء الخير';
  };

  // Format dates
  const today = new Date();
  const gregorianDate = today.toLocaleDateString('ar-SA', {
    weekday: 'long',
    year: 'numeric',
    month: 'long',
    day: 'numeric',
  });
  
  // Hijri date stays pending until an approved conversion/source is wired.
  const hijriDate = 'بانتظار اعتماد التاريخ الهجري';

  return (
    <ScrollView
      style={styles.container}
      contentContainerStyle={styles.content}
      refreshControl={
        <RefreshControl refreshing={refreshing} onRefresh={onRefresh} />
      }
    >
      {/* Header */}
      <View style={styles.header}>
        <Text style={styles.logo}>🕌 مواعيدك</Text>
        <View style={styles.headerActions}>
          <Text style={styles.notificationIcon}>🔔</Text>
          <Text style={styles.menuIcon}>☰</Text>
        </View>
      </View>

      {/* Greeting */}
      <View style={styles.greeting}>
        <Text style={styles.greetingText}>
          {getGreeting()}{user?.name ? ` يا ${user.name}` : ''}
        </Text>
        <Text style={styles.dateText}>{gregorianDate}</Text>
        <Text style={styles.hijriText}>{hijriDate}</Text>
      </View>

      {/* Daily Message Card */}
      <Card icon="💬" title="رسالة اليوم">
        <PendingBanner message="بانتظار ربط رسالة اليوم من الإدارة" />
        <Text style={styles.emptyHint}>لم يتم ربط رسالة اليوم بعد</Text>
      </Card>

      {/* Prayer Times Card */}
      <Card icon="🕌" title="مواقيت الصلاة">
        <PendingBanner message="بانتظار ربط مواقيت الصلاة الرسمية" />
        <View style={styles.prayerGrid}>
          <View style={styles.prayerItem}>
            <Text style={styles.prayerName}>الفجر</Text>
            <Text style={styles.prayerTime}>--:--</Text>
          </View>
          <View style={styles.prayerItem}>
            <Text style={styles.prayerName}>الشروق</Text>
            <Text style={styles.prayerTime}>--:--</Text>
          </View>
          <View style={styles.prayerItem}>
            <Text style={styles.prayerName}>الظهر</Text>
            <Text style={styles.prayerTime}>--:--</Text>
          </View>
          <View style={styles.prayerItem}>
            <Text style={styles.prayerName}>العصر</Text>
            <Text style={styles.prayerTime}>--:--</Text>
          </View>
          <View style={styles.prayerItem}>
            <Text style={styles.prayerName}>المغرب</Text>
            <Text style={styles.prayerTime}>--:--</Text>
          </View>
          <View style={styles.prayerItem}>
            <Text style={styles.prayerName}>العشاء</Text>
            <Text style={styles.prayerTime}>--:--</Text>
          </View>
        </View>
      </Card>

      {/* Next Prayer Card */}
      <Card icon="⏰" title="الصلاة القادمة">
        <View style={styles.nextPrayer}>
          <Text style={styles.nextPrayerLabel}>بانتظار الاعتماد</Text>
          <Text style={styles.nextPrayerTime}>--:--</Text>
          <Text style={styles.nextPrayerCountdown}>متبقي: --</Text>
        </View>
      </Card>

      {/* Upcoming Appointments */}
      <SectionHeader icon="📅" title="المواعيد المهمة" />
      <Card>
        <Text style={styles.emptyText}>لا توجد مواعيد قريبة</Text>
        <Text style={styles.emptyHint}>يمكنك إضافة موعد من التقويم</Text>
      </Card>

      {/* Financial Countdowns */}
      <SectionHeader icon="💰" title="المواعيد المالية" />
      <Card>
        <PendingBanner message="بانتظار ربط التواريخ الرسمية" />
        <Text style={styles.emptyText}>لم يتم ربط أي تواريخ مالية</Text>
      </Card>

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
    flexDirection: 'row-reverse',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginBottom: THEME.spacing.lg,
  },
  logo: {
    fontSize: THEME.fontSize.xxl,
    fontWeight: THEME.fontWeight.bold,
    color: THEME.primary,
  },
  headerActions: {
    flexDirection: 'row',
    gap: THEME.spacing.md,
  },
  notificationIcon: {
    fontSize: 22,
  },
  menuIcon: {
    fontSize: 22,
  },
  
  // Greeting
  greeting: {
    backgroundColor: THEME.surface,
    borderRadius: THEME.radius.lg,
    padding: THEME.spacing.lg,
    marginBottom: THEME.spacing.lg,
    borderWidth: 1,
    borderColor: THEME.border,
  },
  greetingText: {
    fontSize: THEME.fontSize.xl,
    fontWeight: THEME.fontWeight.bold,
    color: THEME.text,
    marginBottom: THEME.spacing.xs,
  },
  dateText: {
    fontSize: THEME.fontSize.md,
    color: THEME.textSecondary,
    marginBottom: 4,
  },
  hijriText: {
    fontSize: THEME.fontSize.lg,
    color: THEME.primary,
    fontWeight: THEME.fontWeight.semibold,
  },
  
  // Prayer Grid
  prayerGrid: {
    flexDirection: 'row-reverse',
    flexWrap: 'wrap',
    marginTop: THEME.spacing.sm,
  },
  prayerItem: {
    width: '33%',
    paddingVertical: THEME.spacing.sm,
    alignItems: 'center',
  },
  prayerName: {
    fontSize: THEME.fontSize.sm,
    color: THEME.textSecondary,
    marginBottom: 4,
  },
  prayerTime: {
    fontSize: THEME.fontSize.lg,
    fontWeight: THEME.fontWeight.bold,
    color: THEME.text,
  },
  
  // Next Prayer
  nextPrayer: {
    alignItems: 'center',
    paddingVertical: THEME.spacing.md,
  },
  nextPrayerLabel: {
    fontSize: THEME.fontSize.sm,
    color: THEME.textSecondary,
    marginBottom: 8,
  },
  nextPrayerTime: {
    fontSize: THEME.fontSize.xxxl,
    fontWeight: THEME.fontWeight.bold,
    color: THEME.primary,
  },
  nextPrayerCountdown: {
    fontSize: THEME.fontSize.md,
    color: THEME.textSecondary,
    marginTop: 8,
  },
  
  // Empty states
  emptyText: {
    fontSize: THEME.fontSize.md,
    color: THEME.textSecondary,
    textAlign: 'center',
    paddingVertical: THEME.spacing.md,
  },
  emptyHint: {
    fontSize: THEME.fontSize.sm,
    color: THEME.textMuted,
    textAlign: 'center',
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

export default HomeScreen;
