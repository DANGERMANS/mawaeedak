/**
 * Daily Card Screen — Share your daily card
 * 
 * Features:
 * - Daily greeting message
 * - Hijri & Gregorian dates
 * - Prayer times with next prayer highlight
 * - Financial countdown (salary, support)
 * - Copy text / Share / Save image
 */

import { useMemo, useRef, useState } from 'react';
import { View, Text, StyleSheet, ScrollView, Pressable, Alert, Share, Platform } from 'react-native';
import { I18nManager } from 'react-native';

// Theme colors - matching web design
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
  lightGold: 'rgba(201,160,99,0.12)',
};

// Saudi-based daily messages pool
const DAILY_MESSAGES = [
  "يبدأ يومك بنية طيبة، وتوكّل على الله في كل خطوة.",
  "حافظ على صلاتك في وقتها، فهي نور لك في الدنيا والآخرة.",
  "ابدأ يومك بالصلاة ثم الذهاب إلى عملك بنشاط.",
  "الورد والصباح الجميل يبدأان من القلب.",
  "لا تؤجل عمل اليوم إلى الغد، فكل يوم له فرصته.",
  "أحسن الظن بالله، وافعل ما بوسعك، وتوكّل على الله.",
  "مهما كانت التحديات، ثق أن الفرج قريب.",
  "اجعل لك هدفاً كل يوم، وحققه قبل منتصف النهار.",
  "التفاؤل يغير الحياة، فابدأ يومك بابتسامة.",
  "ذكر الله نعمة، فاحمده على نعمائه.",
  "العمل عبادة، فأتقن ما بيدك.",
  "لا تستعجل النتائج، فالأجور تأتي.",
  "كن باراً بوالديك، فالدعاء مستجاب.",
  "التوازن بين العمل والعبادة مفتاح السعادة.",
  "كل يوم جديد هو فرصة جديدة للتغيير.",
  "الصلاة على النبي حياة للقلب.",
  "العمل الصالح لا يضيع أبداً.",
  "توكل على الله في كل أمر، فهو خير معين.",
  "ازرع خيراً حيثما حللت، تحصد خيراً حيثما كنت.",
  "ابدأ يومك بالصلاة، واختم يومك بالاستغفار.",
  "الفرج قريب، فلا تيأس.",
  "ابدأ بالتوكل على الله تنجح.",
  "أحسن إلى الناس تستعبد قلوبهم.",
];

// Prayer times data
const PRAYER_ORDER = [
  { key: 'fajr', label: 'الفجر' },
  { key: 'sunrise', label: 'الشروق' },
  { key: 'dhuhr', label: 'الظهر' },
  { key: 'asr', label: 'العصر' },
  { key: 'maghrib', label: 'المغرب' },
  { key: 'isha', label: 'العشاء' },
];

// Get today's message
function getTodayMessage(): string {
  const saudiDate = new Date().toLocaleString('en-US', { timeZone: 'Asia/Riyadh' });
  const today = new Date(saudiDate);
  const dayOfYear = Math.floor((today.getTime() - new Date(today.getFullYear(), 0, 0).getTime()) / (1000 * 60 * 60 * 24));
  return DAILY_MESSAGES[dayOfYear % DAILY_MESSAGES.length];
}

// Format time to 12-hour format
function formatTime(time: string): string {
  const [h, m] = time.split(':').map(Number);
  const period = h >= 12 ? 'م' : 'ص';
  const hour = h % 12 || 12;
  return `${hour}:${m.toString().padStart(2, '0')} ${period}`;
}

// Get Hijri date
function getHijriDate(): string {
  const options: Intl.DateTimeFormatOptions = { calendar: 'islamic', day: 'numeric', month: 'long', year: 'numeric' };
  return new Date().toLocaleDateString('ar-SA', options);
}

// Get Gregorian date
function getGregorianDate(): string {
  const options: Intl.DateTimeFormatOptions = { calendar: 'gregory', day: 'numeric', month: 'long', year: 'numeric' };
  return new Date().toLocaleDateString('ar-SA', options);
}

// Get day name
function getDayName(): string {
  return new Date().toLocaleDateString('ar-SA', { weekday: 'long' });
}

// Mock prayer times
const PRAYER_TIMES = {
  fajr: '04:30',
  sunrise: '05:45',
  dhuhr: '11:45',
  asr: '15:15',
  maghrib: '18:30',
  isha: '20:00',
};

// Mock financial events
const FINANCIAL_EVENTS = [
  { name: 'الراتب', days: 12, icon: '💰' },
  { name: 'حساب المواطن', days: 5, icon: '👤' },
  { name: 'الدعم السكني', days: 18, icon: '🏠' },
];

// Get next prayer
function getNextPrayer() {
  const now = new Date();
  const currentMinutes = now.getHours() * 60 + now.getMinutes();
  
  for (const prayer of PRAYER_ORDER) {
    if (prayer.key === 'sunrise') continue;
    const [h, m] = PRAYER_TIMES[prayer.key as keyof typeof PRAYER_TIMES].split(':').map(Number);
    if (h * 60 + m > currentMinutes) {
      return { ...prayer, time: PRAYER_TIMES[prayer.key as keyof typeof PRAYER_TIMES] };
    }
  }
  return { ...PRAYER_ORDER[0], time: PRAYER_TIMES.fajr };
}

export default function DailyCardScreen() {
  const message = useMemo(() => getTodayMessage(), []);
  const greeting = useMemo(() => {
    const hour = new Date().getHours();
    return hour < 12 ? 'صباح الخير' : 'مساء الخير';
  }, []);
  const nextPrayer = useMemo(() => getNextPrayer(), []);

  const handleCopy = async () => {
    const text = `✦ مواعيدك ✦
${getDayName()}
${getHijriDate()} هـ
${getGregorianDate()} م

${greeting}
${message}

واذكروا الله ذكراً كثيراً

━━━━━━━━━━━━━━
مواعيدك — منصة تجمع وقتك، راتبك، دعمك، وأهم مواعيدك`;

    try {
      await globalThis.navigator?.clipboard?.writeText(text);
      Alert.alert('تم', 'تم نسخ البطاقة بنجاح');
    } catch {
      Alert.alert('خطأ', 'فشل نسخ البطاقة');
    }
  };

  const handleShare = async () => {
    const text = `✦ مواعيدك ✦
${getDayName()}
${getHijriDate()} هـ
${getGregorianDate()} م

${greeting}
${message}

واذكروا الله ذكراً كثيراً

━━━━━━━━━━━━━━
مواعيدك`;

    try {
      await Share.share({
        message: text,
        title: 'بطاقة يومية - مواعيدك',
      });
    } catch {
      // User cancelled
    }
  };

  return (
    <ScrollView style={styles.container} showsVerticalScrollIndicator={false}>
      {/* Header */}
      <View style={styles.header}>
        <Text style={styles.headerTitle}>البطاقة اليومية</Text>
      </View>

      {/* Main Card */}
      <View style={styles.card}>
        {/* Badge */}
        <View style={styles.badge}>
          <Text style={styles.badgeText}>✦ بطاقة يومية ✦</Text>
        </View>

        {/* Logo */}
        <View style={styles.logoSection}>
          <Text style={styles.logoIcon}>✦</Text>
          <Text style={styles.logoTitle}>مواعيدك</Text>
          <Text style={styles.logoSubtitle}>كل مواعيدك.. في مكان واحد</Text>
          <View style={styles.divider} />
        </View>

        {/* Message Banner */}
        <View style={styles.messageBanner}>
          <Text style={styles.messageQuote}>❝</Text>
          <Text style={styles.messageGreeting}>{greeting}</Text>
          <Text style={styles.messageText}>{message}</Text>
          <Text style={styles.messageReminder}>واذكروا الله ذكراً كثيراً</Text>
        </View>

        {/* Date Card */}
        <View style={styles.dateCard}>
          <Text style={styles.dateIcon}>📅</Text>
          <Text style={styles.dateDay}>{getDayName()}</Text>
          <Text style={styles.dateText}>{getHijriDate()} هـ</Text>
          <Text style={styles.dateText}>{getGregorianDate()} م</Text>
        </View>

        {/* Prayer Times Card */}
        <View style={styles.prayerCard}>
          <View style={styles.prayerHeader}>
            <Text style={styles.prayerIcon}>🕌</Text>
            <Text style={styles.prayerTitle}>مواقيت الصلاة</Text>
          </View>
          
          <View style={styles.prayerGrid}>
            {PRAYER_ORDER.filter(p => p.key !== 'sunrise').map((prayer) => {
              const isNext = nextPrayer.key === prayer.key;
              return (
                <View
                  key={prayer.key}
                  style={[
                    styles.prayerItem,
                    isNext && styles.prayerItemActive,
                  ]}
                >
                  <View style={[styles.prayerDot, isNext && styles.prayerDotActive]} />
                  <Text style={[styles.prayerLabel, isNext && styles.prayerLabelActive]}>
                    {prayer.label}
                  </Text>
                  <Text style={[styles.prayerTime, isNext && styles.prayerTimeActive]}>
                    {formatTime(PRAYER_TIMES[prayer.key as keyof typeof PRAYER_TIMES])}
                  </Text>
                </View>
              );
            })}
          </View>

          {nextPrayer && (
            <View style={styles.nextPrayerBanner}>
              <Text style={styles.nextPrayerText}>
                الصلاة القادمة: {nextPrayer.label} — {formatTime(nextPrayer.time)}
              </Text>
            </View>
          )}
        </View>

        {/* Financial Countdown Card */}
        <View style={styles.countdownCard}>
          <View style={styles.countdownHeader}>
            <Text style={styles.countdownIcon}>⏰</Text>
            <Text style={styles.countdownTitle}>كم باقي على</Text>
          </View>
          
          <View style={styles.countdownGrid}>
            {FINANCIAL_EVENTS.map((event, index) => (
              <View key={index} style={styles.countdownItem}>
                <Text style={styles.countdownEventIcon}>{event.icon}</Text>
                <Text style={styles.countdownEventName}>{event.name}</Text>
                <Text style={styles.countdownDays}>{event.days}</Text>
                <Text style={styles.countdownLabel}>يوم</Text>
              </View>
            ))}
          </View>
        </View>

        {/* Footer */}
        <View style={styles.footer}>
          <View style={styles.footerDivider} />
          <Text style={styles.footerLogo}>✦ مواعيدك ✦</Text>
          <Text style={styles.footerTagline}>منصة تجمع وقتك، راتبك، دعمك، وأهم مواعيدك</Text>
        </View>
      </View>

      {/* Action Buttons */}
      <View style={styles.actions}>
        <Pressable style={styles.actionButton} onPress={handleCopy}>
          <Text style={styles.actionIcon}>📋</Text>
          <Text style={styles.actionText}>نسخ النص</Text>
        </Pressable>
        
        <Pressable style={[styles.actionButton, styles.actionButtonSecondary]} onPress={handleShare}>
          <Text style={styles.actionIcon}>📤</Text>
          <Text style={styles.actionTextSecondary}>مشاركة</Text>
        </Pressable>
      </View>

      {/* Footer spacing */}
      <View style={styles.bottomSpacing} />
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
    paddingBottom: 16,
  },
  headerTitle: {
    fontSize: 28,
    fontWeight: 'bold',
    color: THEME.text,
    textAlign: 'center',
  },
  
  // Main Card
  card: {
    backgroundColor: THEME.surface,
    marginHorizontal: 16,
    borderRadius: 28,
    padding: 20,
    borderWidth: 1,
    borderColor: 'rgba(201,160,99,0.3)',
    shadowColor: THEME.secondary,
    shadowOffset: { width: 0, height: 20 },
    shadowOpacity: 0.12,
    shadowRadius: 40,
    elevation: 10,
  },
  
  // Badge
  badge: {
    alignSelf: 'center',
    backgroundColor: THEME.lightGold,
    paddingHorizontal: 20,
    paddingVertical: 10,
    borderRadius: 20,
    borderWidth: 1,
    borderColor: 'rgba(201,160,99,0.35)',
    marginBottom: 16,
  },
  badgeText: {
    fontSize: 13,
    fontWeight: 'bold',
    color: THEME.secondary,
  },
  
  // Logo
  logoSection: {
    alignItems: 'center',
    marginBottom: 20,
  },
  logoIcon: {
    fontSize: 28,
    color: THEME.primary,
    marginBottom: 4,
  },
  logoTitle: {
    fontSize: 32,
    fontWeight: 'bold',
    color: THEME.text,
  },
  logoSubtitle: {
    fontSize: 14,
    color: THEME.textSecondary,
    marginTop: 4,
  },
  divider: {
    width: 100,
    height: 2,
    backgroundColor: THEME.primary,
    marginTop: 12,
    opacity: 0.4,
  },
  
  // Message Banner
  messageBanner: {
    backgroundColor: THEME.lightGold,
    borderRadius: 16,
    padding: 16,
    marginBottom: 16,
    borderWidth: 1,
    borderColor: 'rgba(201,160,99,0.2)',
  },
  messageQuote: {
    fontSize: 24,
    color: THEME.primary,
    textAlign: 'center',
    marginBottom: 8,
  },
  messageGreeting: {
    fontSize: 16,
    fontWeight: 'bold',
    color: THEME.secondary,
    textAlign: 'center',
    marginBottom: 8,
  },
  messageText: {
    fontSize: 14,
    color: THEME.text,
    textAlign: 'center',
    lineHeight: 24,
    marginBottom: 10,
  },
  messageReminder: {
    fontSize: 12,
    color: THEME.primary,
    textAlign: 'center',
    fontWeight: '600',
  },
  
  // Date Card
  dateCard: {
    backgroundColor: THEME.surface,
    borderRadius: 16,
    padding: 16,
    alignItems: 'center',
    marginBottom: 16,
    borderWidth: 1,
    borderColor: 'rgba(201,160,99,0.2)',
  },
  dateIcon: {
    fontSize: 24,
    marginBottom: 8,
  },
  dateDay: {
    fontSize: 20,
    fontWeight: 'bold',
    color: THEME.secondary,
    marginBottom: 4,
  },
  dateText: {
    fontSize: 14,
    color: THEME.text,
    marginBottom: 2,
  },
  
  // Prayer Card
  prayerCard: {
    backgroundColor: THEME.surface,
    borderRadius: 16,
    padding: 16,
    marginBottom: 16,
    borderWidth: 1,
    borderColor: 'rgba(201,160,99,0.2)',
  },
  prayerHeader: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'center',
    marginBottom: 14,
    gap: 8,
  },
  prayerIcon: {
    fontSize: 20,
  },
  prayerTitle: {
    fontSize: 16,
    fontWeight: 'bold',
    color: THEME.secondary,
  },
  prayerGrid: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    justifyContent: 'space-between',
  },
  prayerItem: {
    width: '30%',
    alignItems: 'center',
    paddingVertical: 10,
    marginBottom: 6,
    borderRadius: 12,
  },
  prayerItemActive: {
    backgroundColor: 'rgba(201,160,99,0.15)',
    borderWidth: 1,
    borderColor: 'rgba(201,160,99,0.35)',
  },
  prayerDot: {
    width: 8,
    height: 8,
    borderRadius: 4,
    backgroundColor: THEME.lightGold,
    marginBottom: 6,
  },
  prayerDotActive: {
    backgroundColor: THEME.primary,
  },
  prayerLabel: {
    fontSize: 11,
    color: THEME.textSecondary,
    marginBottom: 4,
  },
  prayerLabelActive: {
    color: THEME.secondary,
    fontWeight: '600',
  },
  prayerTime: {
    fontSize: 12,
    fontWeight: '600',
    color: THEME.secondary,
  },
  prayerTimeActive: {
    color: THEME.primary,
    fontWeight: 'bold',
  },
  nextPrayerBanner: {
    backgroundColor: THEME.lightGold,
    borderRadius: 10,
    paddingVertical: 10,
    paddingHorizontal: 14,
    marginTop: 10,
    alignItems: 'center',
  },
  nextPrayerText: {
    fontSize: 12,
    fontWeight: 'bold',
    color: THEME.primary,
  },
  
  // Countdown Card
  countdownCard: {
    backgroundColor: THEME.lightGold,
    borderRadius: 16,
    padding: 16,
    marginBottom: 16,
    borderWidth: 1,
    borderColor: 'rgba(201,160,99,0.2)',
  },
  countdownHeader: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'center',
    marginBottom: 14,
    gap: 8,
  },
  countdownIcon: {
    fontSize: 18,
  },
  countdownTitle: {
    fontSize: 14,
    fontWeight: 'bold',
    color: THEME.secondary,
  },
  countdownGrid: {
    flexDirection: 'row',
    justifyContent: 'space-around',
  },
  countdownItem: {
    alignItems: 'center',
    backgroundColor: THEME.surface,
    borderRadius: 14,
    paddingVertical: 14,
    paddingHorizontal: 16,
    minWidth: 90,
    borderWidth: 1,
    borderColor: 'rgba(201,160,99,0.15)',
  },
  countdownEventIcon: {
    fontSize: 22,
    marginBottom: 6,
  },
  countdownEventName: {
    fontSize: 11,
    color: THEME.text,
    marginBottom: 4,
  },
  countdownDays: {
    fontSize: 26,
    fontWeight: 'bold',
    color: THEME.primary,
  },
  countdownLabel: {
    fontSize: 10,
    color: THEME.textSecondary,
    marginTop: 2,
  },
  
  // Footer
  footer: {
    alignItems: 'center',
    paddingTop: 8,
  },
  footerDivider: {
    width: '100%',
    height: 1,
    backgroundColor: 'rgba(201,160,99,0.3)',
    marginBottom: 12,
  },
  footerLogo: {
    fontSize: 16,
    fontWeight: 'bold',
    color: THEME.primary,
    marginBottom: 4,
  },
  footerTagline: {
    fontSize: 10,
    color: THEME.textSecondary,
    textAlign: 'center',
  },
  
  // Actions
  actions: {
    flexDirection: 'row',
    justifyContent: 'center',
    gap: 12,
    paddingHorizontal: 16,
    marginTop: 20,
  },
  actionButton: {
    flex: 1,
    backgroundColor: THEME.primary,
    borderRadius: 16,
    paddingVertical: 16,
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'center',
    gap: 8,
  },
  actionButtonSecondary: {
    backgroundColor: THEME.surface,
    borderWidth: 1,
    borderColor: THEME.border,
  },
  actionIcon: {
    fontSize: 20,
  },
  actionText: {
    fontSize: 15,
    fontWeight: 'bold',
    color: '#FFF',
  },
  actionTextSecondary: {
    fontSize: 15,
    fontWeight: 'bold',
    color: THEME.text,
  },
  
  bottomSpacing: {
    height: 100,
  },
});