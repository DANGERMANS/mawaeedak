/**
 * Daily Card Screen — Premium Daily Card for Mawaeedak Mobile
 * 
 * Features:
 * - Premium card design with daily summary
 * - Prayer times
 * - Financial countdown
 * - Daily message
 * - Share functionality
 */

import { useState } from 'react';
import { View, Text, StyleSheet, ScrollView, Pressable, Alert, Share, Image, Dimensions } from 'react-native';
import { Feather } from '@expo/vector-icons';
import { useRouter } from 'expo-router';

// Theme colors
const GOLD = '#C9A063';
const BROWN = '#8A6B3D';
const INK = '#2F2B25';
const PAPER = '#FAF7F2';
const CREAM = '#F5EFE4';
const LIGHT_GOLD = 'rgba(201,160,99,0.12)';
const TEXT_SECONDARY = '#6F6557';

const { width } = Dimensions.get('window');

// Mock Data
const MOCK_DAILY = {
  greeting: 'صباح الخير',
  date: 'الأحد، 9 يونيو 2026',
  hijriDate: '12 ذو الحجة 1447 هـ',
  message: 'ابدأ يومك بنية طيبة، وتوكل على الله في كل خطوة.',
  nextPrayer: {
    name: 'العصر',
    time: '03:15 م',
    countdown: '2 ساعة و 30 دقيقة',
  },
  prayers: [
    { name: 'الفجر', time: '04:30', icon: '🌙' },
    { name: 'الشروق', time: '05:45', icon: '🌅' },
    { name: 'الظهر', time: '11:45', icon: '☀️' },
    { name: 'العصر', time: '03:15', icon: '☀️' },
    { name: 'المغرب', time: '06:45', icon: '🌅' },
    { name: 'العشاء', time: '08:00', icon: '🌙' },
  ],
  financial: [
    { name: 'الراتب', days: 16, amount: '12,000 ر.س' },
    { name: 'حساب المواطن', days: 1, amount: '2,000 ر.س' },
  ],
};

// Prayer Card Component
function PrayerCard({ name, time, icon, isNext }: { name: string; time: string; icon: string; isNext?: boolean }) {
  return (
    <View style={[styles.prayerCard, isNext && styles.prayerCardNext]}>
      <Text style={styles.prayerIcon}>{icon}</Text>
      <Text style={[styles.prayerName, isNext && styles.prayerNameNext]}>{name}</Text>
      <Text style={[styles.prayerTime, isNext && styles.prayerTimeNext]}>{time}</Text>
    </View>
  );
}

// Financial Item Component
function FinancialItem({ name, days, amount }: { name: string; days: number; amount: string }) {
  return (
    <View style={styles.financialItem}>
      <View style={styles.financialLeft}>
        <Feather name="dollar-sign" size={18} color={GOLD} />
        <Text style={styles.financialName}>{name}</Text>
      </View>
      <View style={styles.financialRight}>
        <Text style={styles.financialAmount}>{amount}</Text>
        <Text style={[styles.financialDays, { color: days <= 2 ? '#B9483F' : GOLD }]}>
          {days === 0 ? 'اليوم' : days === 1 ? 'غداً' : `${days} يوم`}
        </Text>
      </View>
    </View>
  );
}

export default function DailyCardScreen() {
  const router = useRouter();

  const handleShare = async () => {
    try {
      await Share.share({
        title: 'البطاقة اليومية - مواعيدك',
        message: `${MOCK_DAILY.greeting}\n\n${MOCK_DAILY.date}\n${MOCK_DAILY.hijriDate}\n\n${MOCK_DAILY.message}\n\nمواعيدك - كل مواعيدك في مكان واحد`,
      });
    } catch (error) {
      Alert.alert('خطأ', 'فشل مشاركة البطاقة');
    }
  };

  const handleSave = () => {
    Alert.alert('تم', 'تم حفظ البطاقة');
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
          <Pressable style={styles.backButton} onPress={() => router.back()}>
            <Feather name="arrow-right" size={24} color={INK} />
          </Pressable>
          <Text style={styles.headerTitle}>البطاقة اليومية</Text>
          <Pressable style={styles.shareButton} onPress={handleShare}>
            <Feather name="share-2" size={22} color={BROWN} />
          </Pressable>
        </View>

        {/* Premium Card */}
        <View style={styles.card}>
          {/* Card Header */}
          <View style={styles.cardHeader}>
            <View style={styles.cardBadge}>
              <Text style={styles.cardBadgeText}>بطاقة اليوم</Text>
            </View>
            <Text style={styles.cardLogo}>🕌</Text>
          </View>

          {/* Greeting */}
          <Text style={styles.greeting}>{MOCK_DAILY.greeting}</Text>
          <Text style={styles.date}>{MOCK_DAILY.date}</Text>
          <Text style={styles.hijriDate}>{MOCK_DAILY.hijriDate}</Text>

          {/* Next Prayer Highlight */}
          <View style={styles.nextPrayerSection}>
            <Text style={styles.nextPrayerLabel}>الصلاة القادمة</Text>
            <View style={styles.nextPrayerCard}>
              <View style={styles.nextPrayerLeft}>
                <Text style={styles.nextPrayerIcon}>☀️</Text>
                <View>
                  <Text style={styles.nextPrayerName}>{MOCK_DAILY.nextPrayer.name}</Text>
                  <Text style={styles.nextPrayerTime}>{MOCK_DAILY.nextPrayer.time}</Text>
                </View>
              </View>
              <View style={styles.nextPrayerRight}>
                <Text style={styles.countdownLabel}>متبقي</Text>
                <Text style={styles.countdown}>{MOCK_DAILY.nextPrayer.countdown}</Text>
              </View>
            </View>
          </View>

          {/* Daily Message */}
          <View style={styles.messageSection}>
            <View style={styles.quoteIcon}>
              <Text style={{ fontSize: 24 }}>❝</Text>
            </View>
            <Text style={styles.messageText}>{MOCK_DAILY.message}</Text>
          </View>

          {/* Prayer Times */}
          <View style={styles.prayerSection}>
            <Text style={styles.sectionTitle}>مواقيت الصلاة</Text>
            <View style={styles.prayerGrid}>
              {MOCK_DAILY.prayers.map((prayer, index) => (
                <PrayerCard
                  key={prayer.name}
                  name={prayer.name}
                  time={prayer.time}
                  icon={prayer.icon}
                  isNext={prayer.name === 'العصر'}
                />
              ))}
            </View>
          </View>

          {/* Financial Countdown */}
          <View style={styles.financialSection}>
            <Text style={styles.sectionTitle}>المواعيد المالية</Text>
            {MOCK_DAILY.financial.map((item) => (
              <FinancialItem key={item.name} name={item.name} days={item.days} amount={item.amount} />
            ))}
          </View>

          {/* Card Footer */}
          <View style={styles.cardFooter}>
            <Text style={styles.footerText}>كل مواعيدك في مكان واحد</Text>
            <Text style={styles.footerBrand}>مواعيدك</Text>
          </View>
        </View>

        {/* Action Buttons */}
        <View style={styles.actions}>
          <Pressable style={styles.saveButton} onPress={handleSave}>
            <Feather name="download" size={20} color="#FFFFFF" />
            <Text style={styles.saveButtonText}>حفظ البطاقة</Text>
          </Pressable>
          <Pressable style={styles.shareActionButton} onPress={handleShare}>
            <Feather name="share" size={20} color={BROWN} />
            <Text style={styles.shareActionText}>مشاركة</Text>
          </Pressable>
        </View>

        {/* Bottom padding */}
        <View style={{ height: 40 }} />
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
    paddingTop: 20,
  },
  header: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
    marginBottom: 24,
  },
  backButton: {
    width: 44,
    height: 44,
    borderRadius: 12,
    backgroundColor: CREAM,
    justifyContent: 'center',
    alignItems: 'center',
  },
  headerTitle: {
    fontSize: 20,
    fontWeight: '700',
    color: INK,
  },
  shareButton: {
    width: 44,
    height: 44,
    borderRadius: 12,
    backgroundColor: CREAM,
    justifyContent: 'center',
    alignItems: 'center',
  },
  card: {
    backgroundColor: CREAM,
    borderRadius: 28,
    padding: 24,
    borderWidth: 1,
    borderColor: 'rgba(201,160,99,0.25)',
    shadowColor: '#8A6B3D',
    shadowOffset: { width: 0, height: 8 },
    shadowOpacity: 0.15,
    shadowRadius: 24,
    elevation: 10,
  },
  cardHeader: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginBottom: 20,
  },
  cardBadge: {
    backgroundColor: GOLD + '20',
    paddingHorizontal: 14,
    paddingVertical: 6,
    borderRadius: 20,
  },
  cardBadgeText: {
    fontSize: 12,
    fontWeight: '600',
    color: GOLD,
  },
  cardLogo: {
    fontSize: 36,
  },
  greeting: {
    fontSize: 28,
    fontWeight: '800',
    color: INK,
    marginBottom: 4,
  },
  date: {
    fontSize: 15,
    color: TEXT_SECONDARY,
    marginBottom: 2,
  },
  hijriDate: {
    fontSize: 14,
    color: GOLD,
    marginBottom: 24,
  },
  nextPrayerSection: {
    marginBottom: 24,
  },
  nextPrayerLabel: {
    fontSize: 12,
    fontWeight: '600',
    color: TEXT_SECONDARY,
    marginBottom: 8,
    textTransform: 'uppercase',
  },
  nextPrayerCard: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    backgroundColor: GOLD + '15',
    borderRadius: 18,
    padding: 18,
    borderWidth: 1,
    borderColor: GOLD + '30',
  },
  nextPrayerLeft: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 12,
  },
  nextPrayerIcon: {
    fontSize: 32,
  },
  nextPrayerName: {
    fontSize: 20,
    fontWeight: '700',
    color: INK,
  },
  nextPrayerTime: {
    fontSize: 15,
    color: TEXT_SECONDARY,
  },
  nextPrayerRight: {
    alignItems: 'flex-end',
  },
  countdownLabel: {
    fontSize: 11,
    color: TEXT_SECONDARY,
    marginBottom: 2,
  },
  countdown: {
    fontSize: 16,
    fontWeight: '700',
    color: GOLD,
  },
  messageSection: {
    flexDirection: 'row',
    alignItems: 'flex-start',
    backgroundColor: PAPER,
    borderRadius: 16,
    padding: 16,
    marginBottom: 24,
  },
  quoteIcon: {
    marginRight: 12,
  },
  messageText: {
    flex: 1,
    fontSize: 16,
    color: INK,
    lineHeight: 26,
    fontStyle: 'italic',
  },
  prayerSection: {
    marginBottom: 24,
  },
  sectionTitle: {
    fontSize: 14,
    fontWeight: '600',
    color: TEXT_SECONDARY,
    marginBottom: 12,
    textTransform: 'uppercase',
  },
  prayerGrid: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    gap: 10,
  },
  prayerCard: {
    width: '30%',
    backgroundColor: PAPER,
    borderRadius: 14,
    padding: 12,
    alignItems: 'center',
    borderWidth: 1,
    borderColor: 'rgba(201,160,99,0.10)',
  },
  prayerCardNext: {
    backgroundColor: GOLD + '15',
    borderColor: GOLD,
  },
  prayerIcon: {
    fontSize: 18,
    marginBottom: 4,
  },
  prayerName: {
    fontSize: 11,
    color: TEXT_SECONDARY,
    marginBottom: 4,
  },
  prayerNameNext: {
    color: GOLD,
    fontWeight: '600',
  },
  prayerTime: {
    fontSize: 15,
    fontWeight: '700',
    color: INK,
  },
  prayerTimeNext: {
    color: GOLD,
  },
  financialSection: {
    marginBottom: 24,
  },
  financialItem: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    backgroundColor: PAPER,
    borderRadius: 14,
    padding: 14,
    marginBottom: 8,
  },
  financialLeft: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 10,
  },
  financialName: {
    fontSize: 15,
    fontWeight: '600',
    color: INK,
  },
  financialRight: {
    alignItems: 'flex-end',
  },
  financialAmount: {
    fontSize: 15,
    fontWeight: '700',
    color: INK,
  },
  financialDays: {
    fontSize: 12,
    fontWeight: '600',
    marginTop: 2,
  },
  cardFooter: {
    alignItems: 'center',
    paddingTop: 16,
    borderTopWidth: 1,
    borderTopColor: 'rgba(201,160,99,0.15)',
  },
  footerText: {
    fontSize: 13,
    color: TEXT_SECONDARY,
    marginBottom: 4,
  },
  footerBrand: {
    fontSize: 16,
    fontWeight: '700',
    color: GOLD,
  },
  actions: {
    flexDirection: 'row',
    gap: 12,
    marginTop: 24,
  },
  saveButton: {
    flex: 2,
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'center',
    backgroundColor: GOLD,
    borderRadius: 16,
    paddingVertical: 16,
    gap: 10,
  },
  saveButtonText: {
    fontSize: 16,
    fontWeight: '700',
    color: '#FFFFFF',
  },
  shareActionButton: {
    flex: 1,
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'center',
    backgroundColor: CREAM,
    borderRadius: 16,
    paddingVertical: 16,
    gap: 8,
    borderWidth: 1,
    borderColor: 'rgba(201,160,99,0.20)',
  },
  shareActionText: {
    fontSize: 15,
    fontWeight: '600',
    color: BROWN,
  },
});