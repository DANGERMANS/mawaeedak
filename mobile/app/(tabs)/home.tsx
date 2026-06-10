/**
 * Home Screen — Main entry point for Mawaeedak Mobile
 * 
 * Features:
 * - Greeting hero section
 * - Prayer times with countdown to next prayer
 * - Financial events countdown
 * - Quick actions
 * - Daily message from admin
 */

import { useState, useEffect, useMemo } from 'react';
import { View, Text, StyleSheet, ScrollView, Pressable, ActivityIndicator, RefreshControl } from 'react-native';
import { I18nManager } from 'react-native';
import { Feather } from '@expo/vector-icons';
import { useRouter } from 'expo-router';

// Theme colors
const GOLD = '#C9A063';
const BROWN = '#8A6B3D';
const INK = '#2F2B25';
const PAPER = '#FAF7F2';
const CREAM = '#F5EFE4';
const TEXT_SECONDARY = '#6F6557';

// Mock Prayer Times
const MOCK_PRAYER_TIMES = {
  fajr: '04:30',
  sunrise: '05:45',
  dhuhr: '11:45',
  asr: '15:15',
  maghrib: '18:45',
  isha: '20:00',
};

// Mock Financial Events
const MOCK_FINANCIAL = [
  { id: 1, name: 'راتب شهر ذو الحجة', days: 15, amount: '12,000 ر.س', type: 'salary' },
  { id: 2, name: 'حساب المواطن', days: 8, amount: '2,000 ر.س', type: 'support' },
  { id: 3, name: 'فاتورة كهرباء', days: 3, amount: '350 ر.س', type: 'bill' },
];

// Default daily message
const DEFAULT_MESSAGE = 'ابدأ يومك بنية طيبة، وتوكل على الله في كل خطوة.';

function getGreeting() {
  const hour = new Date().getHours();
  return hour < 12 ? 'صباح الخير' : 'مساء الخير';
}

function formatGregorianDate() {
  const days = ['الأحد', 'الإثنين', 'الثلاثاء', 'الأربعاء', 'الخميس', 'الجمعة', 'السبت'];
  const months = ['يناير', 'فبراير', 'مارس', 'أبريل', 'مايو', 'يونيو', 'يوليو', 'أغسطس', 'سبتمبر', 'أكتوبر', 'نوفمبر', 'ديسمبر'];
  const now = new Date();
  return `${days[now.getDay()]}، ${now.getDate()} ${months[now.getMonth()]} ${now.getFullYear()}`;
}

function formatHijriDate() {
  // Simplified - would use proper Hijri library in production
  const months = ['محرم', 'صفر', 'ربيع الأول', 'ربيع الثاني', 'جمادى الأولى', 'جمادى الآخرة', 'رجب', 'شعبان', 'رمضان', 'شوال', 'ذو القعدة', 'ذو الحجة'];
  const now = new Date();
  return `${now.getDate()} ${months[now.getMonth()]} 1447`;
}

// Prayer Card Component
function PrayerCard({ label, time, icon, isNext = false }: { label: string; time: string; icon: string; isNext?: boolean }) {
  return (
    <View style={[styles.prayerCard, isNext && styles.prayerCardActive]}>
      <Text style={styles.prayerIcon}>{icon}</Text>
      <Text style={[styles.prayerLabel, isNext && styles.prayerLabelActive]}>{label}</Text>
      <Text style={[styles.prayerTime, isNext && styles.prayerTimeActive]}>{time}</Text>
    </View>
  );
}

// Financial Item Component
function FinancialItem({ name, days, amount, type }: { name: string; days: number; amount: string; type: string }) {
  const getTypeIcon = () => {
    switch (type) {
      case 'salary': return '💰';
      case 'support': return '🏠';
      case 'bill': return '📄';
      default: return '💵';
    }
  };

  const getDaysColor = () => {
    if (days <= 3) return '#B9483F';
    if (days <= 7) return '#C9A063';
    return '#7A9A74';
  };

  return (
    <View style={styles.financialItem}>
      <View style={styles.financialIcon}>
        <Text style={{ fontSize: 24 }}>{getTypeIcon()}</Text>
      </View>
      <View style={styles.financialContent}>
        <Text style={styles.financialName}>{name}</Text>
        <Text style={styles.financialAmount}>{amount}</Text>
      </View>
      <View style={[styles.financialDays, { backgroundColor: getDaysColor() + '20' }]}>
        <Text style={[styles.financialDaysText, { color: getDaysColor() }]}>
          {days === 0 ? 'اليوم' : days === 1 ? 'غداً' : `${days} يوم`}
        </Text>
      </View>
    </View>
  );
}

// Loading Screen
function LoadingScreen() {
  return (
    <View style={styles.loadingContainer}>
      <Text style={styles.loadingLogo}>🕌</Text>
      <Text style={styles.loadingText}>جاري تحميل مواعيدك...</Text>
      <ActivityIndicator size="large" color={GOLD} />
    </View>
  );
}

export default function HomeScreen() {
  const router = useRouter();
  const [isLoading, setIsLoading] = useState(true);
  const [refreshing, setRefreshing] = useState(false);

  // Simulate loading
  useEffect(() => {
    const timer = setTimeout(() => setIsLoading(false), 800);
    return () => clearTimeout(timer);
  }, []);

  const onRefresh = () => {
    setRefreshing(true);
    setTimeout(() => setRefreshing(false), 1000);
  };

  if (isLoading) {
    return <LoadingScreen />;
  }

  const prayers = [
    { key: 'fajr', label: 'الفجر', time: MOCK_PRAYER_TIMES.fajr, icon: '🌙' },
    { key: 'sunrise', label: 'الشروق', time: MOCK_PRAYER_TIMES.sunrise, icon: '🌅' },
    { key: 'dhuhr', label: 'الظهر', time: MOCK_PRAYER_TIMES.dhuhr, icon: '☀️' },
    { key: 'asr', label: 'العصر', time: MOCK_PRAYER_TIMES.asr, icon: '☀️' },
    { key: 'maghrib', label: 'المغرب', time: MOCK_PRAYER_TIMES.maghrib, icon: '🌅' },
    { key: 'isha', label: 'العشاء', time: MOCK_PRAYER_TIMES.isha, icon: '🌙' },
  ];

  return (
    <View style={styles.container}>
      <ScrollView
        style={styles.scrollView}
        contentContainerStyle={styles.scrollContent}
        showsVerticalScrollIndicator={false}
        refreshControl={<RefreshControl refreshing={refreshing} onRefresh={onRefresh} colors={[GOLD]} />}
      >
        {/* Header */}
        <View style={styles.header}>
          <View>
            <Text style={styles.greeting}>{getGreeting()}</Text>
            <Text style={styles.dateText}>{formatGregorianDate()}</Text>
            <Text style={styles.hijriText}>{formatHijriDate()} هـ</Text>
          </View>
          <View style={styles.logoContainer}>
            <Text style={styles.logo}>🕌</Text>
          </View>
        </View>

        {/* Daily Message Card */}
        <View style={styles.messageCard}>
          <View style={styles.messageIcon}>
            <Feather name="message-circle" size={20} color={GOLD} />
          </View>
          <Text style={styles.messageText}>{DEFAULT_MESSAGE}</Text>
        </View>

        {/* Prayer Times Section */}
        <View style={styles.section}>
          <Text style={styles.sectionTitle}>مواقيت الصلاة</Text>
          <Text style={styles.sectionSubtitle}>الرياض</Text>
          <View style={styles.prayerGrid}>
            {prayers.map((prayer) => (
              <PrayerCard key={prayer.key} label={prayer.label} time={prayer.time} icon={prayer.icon} />
            ))}
          </View>
        </View>

        {/* Financial Events Section */}
        <View style={styles.section}>
          <Text style={styles.sectionTitle}>المواعيد المالية</Text>
          <View style={styles.financialList}>
            {MOCK_FINANCIAL.map((item) => (
              <FinancialItem key={item.id} name={item.name} days={item.days} amount={item.amount} type={item.type} />
            ))}
          </View>
        </View>

        {/* Quick Actions */}
        <View style={styles.section}>
          <Text style={styles.sectionTitle}>إجراءات سريعة</Text>
          <View style={styles.quickActions}>
            <Pressable style={styles.quickAction} onPress={() => router.push('/daily-card')}>
              <View style={[styles.quickActionIcon, { backgroundColor: GOLD + '20' }]}>
                <Text style={{ fontSize: 24 }}>🎴</Text>
              </View>
              <Text style={styles.quickActionLabel}>البطاقة اليومية</Text>
            </Pressable>
            <Pressable style={styles.quickAction} onPress={() => router.push('/(tabs)/calendar')}>
              <View style={[styles.quickActionIcon, { backgroundColor: BROWN + '20' }]}>
                <Text style={{ fontSize: 24 }}>📅</Text>
              </View>
              <Text style={styles.quickActionLabel}>المواعيد</Text>
            </Pressable>
            <Pressable style={styles.quickAction} onPress={() => router.push('/(tabs)/services')}>
              <View style={[styles.quickActionIcon, { backgroundColor: '#7A9A7420' }]}>
                <Text style={{ fontSize: 24 }}>🏢</Text>
              </View>
              <Text style={styles.quickActionLabel}>الخدمات</Text>
            </Pressable>
          </View>
        </View>

        {/* Bottom padding for tab bar */}
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
  loadingContainer: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: PAPER,
  },
  loadingLogo: {
    fontSize: 48,
    marginBottom: 16,
  },
  loadingText: {
    fontSize: 18,
    color: BROWN,
    marginBottom: 24,
  },
  header: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'flex-start',
    marginBottom: 20,
  },
  greeting: {
    fontSize: 28,
    fontWeight: '800',
    color: INK,
  },
  dateText: {
    fontSize: 14,
    color: TEXT_SECONDARY,
    marginTop: 4,
  },
  hijriText: {
    fontSize: 14,
    color: GOLD,
    marginTop: 2,
  },
  logoContainer: {
    width: 56,
    height: 56,
    borderRadius: 16,
    backgroundColor: CREAM,
    justifyContent: 'center',
    alignItems: 'center',
  },
  logo: {
    fontSize: 32,
  },
  messageCard: {
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: CREAM,
    borderRadius: 16,
    padding: 16,
    marginBottom: 24,
    borderWidth: 1,
    borderColor: 'rgba(201,160,99,0.15)',
  },
  messageIcon: {
    width: 36,
    height: 36,
    borderRadius: 10,
    backgroundColor: GOLD + '20',
    justifyContent: 'center',
    alignItems: 'center',
    marginRight: 12,
  },
  messageText: {
    flex: 1,
    fontSize: 15,
    color: INK,
    lineHeight: 24,
  },
  section: {
    marginBottom: 24,
  },
  sectionTitle: {
    fontSize: 20,
    fontWeight: '700',
    color: INK,
    marginBottom: 4,
  },
  sectionSubtitle: {
    fontSize: 14,
    color: TEXT_SECONDARY,
    marginBottom: 12,
  },
  prayerGrid: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    gap: 8,
  },
  prayerCard: {
    width: '31%',
    backgroundColor: CREAM,
    borderRadius: 14,
    padding: 12,
    alignItems: 'center',
    borderWidth: 1,
    borderColor: 'rgba(201,160,99,0.10)',
  },
  prayerCardActive: {
    backgroundColor: GOLD + '15',
    borderColor: GOLD,
  },
  prayerIcon: {
    fontSize: 20,
    marginBottom: 4,
  },
  prayerLabel: {
    fontSize: 12,
    color: TEXT_SECONDARY,
    marginBottom: 4,
  },
  prayerLabelActive: {
    color: GOLD,
    fontWeight: '600',
  },
  prayerTime: {
    fontSize: 16,
    fontWeight: '700',
    color: INK,
  },
  prayerTimeActive: {
    color: GOLD,
  },
  financialList: {
    gap: 8,
  },
  financialItem: {
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: CREAM,
    borderRadius: 14,
    padding: 14,
    borderWidth: 1,
    borderColor: 'rgba(201,160,99,0.10)',
  },
  financialIcon: {
    width: 44,
    height: 44,
    borderRadius: 12,
    backgroundColor: PAPER,
    justifyContent: 'center',
    alignItems: 'center',
    marginRight: 12,
  },
  financialContent: {
    flex: 1,
  },
  financialName: {
    fontSize: 15,
    fontWeight: '600',
    color: INK,
  },
  financialAmount: {
    fontSize: 13,
    color: TEXT_SECONDARY,
    marginTop: 2,
  },
  financialDays: {
    paddingHorizontal: 12,
    paddingVertical: 6,
    borderRadius: 8,
  },
  financialDaysText: {
    fontSize: 13,
    fontWeight: '600',
  },
  quickActions: {
    flexDirection: 'row',
    gap: 12,
  },
  quickAction: {
    flex: 1,
    backgroundColor: CREAM,
    borderRadius: 16,
    padding: 16,
    alignItems: 'center',
    borderWidth: 1,
    borderColor: 'rgba(201,160,99,0.10)',
  },
  quickActionIcon: {
    width: 48,
    height: 48,
    borderRadius: 14,
    justifyContent: 'center',
    alignItems: 'center',
    marginBottom: 8,
  },
  quickActionLabel: {
    fontSize: 13,
    color: INK,
    fontWeight: '600',
  },
});