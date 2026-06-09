/**
 * Daily Card Screen — بطاقة اليوم
 * Pending official content + local share
 */

import React from 'react';
import { View, Text, StyleSheet, Share, Alert } from 'react-native';
import { THEME } from '../../constants/theme';
import { Card, PendingBanner } from '../../components/Card';
import { Button } from '../../components/Button';

export const DailyCardScreen: React.FC = () => {
  const handleShare = async () => {
    try {
      const message = `🕌 بطاقة اليوم - مواعيدك\n\nبسم الله توكلت على الله`;
      await Share.share({
        message,
        title: 'بطاقة اليوم',
      });
    } catch (error) {
      Alert.alert('خطأ', 'لم يتم العثور على تطبيق للمشاركة');
    }
  };

  // Get current date info
  const today = new Date();
  const gregorianDate = today.toLocaleDateString('ar-SA', {
    weekday: 'long',
    year: 'numeric',
    month: 'long',
    day: 'numeric',
  });

  return (
    <View style={styles.container}>
      <View style={styles.header}>
        <Text style={styles.title}>بطاقة اليوم 🎴</Text>
      </View>

      <View style={styles.content}>
        {/* Date Info */}
        <View style={styles.dateCard}>
          <Text style={styles.dateIcon}>📅</Text>
          <Text style={styles.dateText}>{gregorianDate}</Text>
        </View>

        {/* Pending Official Content */}
        <Card>
          <View style={styles.cardContent}>
            <Text style={styles.cardIcon}>🎴</Text>
            <Text style={styles.cardTitle}>بطاقة اليوم</Text>
            <PendingBanner message="بانتظار ربط رسالة اليوم من الإدارة" />
            <Text style={styles.emptyText}>
              لا توجد بطاقة اليوم حالياً.{'\n'}
             将在 الإدارة إرسال بطاقة يومية عبر النظام.
            </Text>
          </View>
        </Card>

        {/* Share Button */}
        <View style={styles.shareSection}>
          <Text style={styles.shareTitle}>📤 مشاركة</Text>
          <Text style={styles.shareDesc}>
            لا يمكن مشاركة محتوى غير موجود.{'\n'}
            سيتم تفعيل المشاركة عند توفر بطاقة اليوم.
          </Text>
          <Button
            title="مشاركة بطاقة فارغة"
            onPress={handleShare}
            variant="outline"
            icon="📤"
          />
        </View>

        {/* Info */}
        <View style={styles.infoBox}>
          <Text style={styles.infoTitle}>ℹ️ عن بطاقة اليوم</Text>
          <Text style={styles.infoText}>
            بطاقة اليوم هي رسالة يومية من الإدارة{'\n'}
            تتضمن تذكير أو دعاء أو معلومة مفيدة.{'\n'}
            سيتم إرسالها تلقائياً عند توفر الربط الرسمي.
          </Text>
        </View>
      </View>
    </View>
  );
};

const styles = StyleSheet.create({
  container: { flex: 1, backgroundColor: THEME.background },
  header: { padding: THEME.spacing.md, backgroundColor: THEME.surface, borderBottomWidth: 1, borderBottomColor: THEME.border },
  title: { fontSize: THEME.fontSize.xxl, fontWeight: THEME.fontWeight.bold, color: THEME.text },
  content: { flex: 1, padding: THEME.spacing.md, paddingBottom: THEME.spacing.xxl },
  dateCard: { backgroundColor: THEME.surface, borderRadius: THEME.radius.lg, padding: THEME.spacing.lg, marginBottom: THEME.spacing.md, alignItems: 'center', borderWidth: 1, borderColor: THEME.border },
  dateIcon: { fontSize: 32, marginBottom: 8 },
  dateText: { fontSize: THEME.fontSize.lg, fontWeight: THEME.fontWeight.semibold, color: THEME.text },
  cardContent: { alignItems: 'center' },
  cardIcon: { fontSize: 48, marginBottom: 12 },
  cardTitle: { fontSize: THEME.fontSize.xl, fontWeight: THEME.fontWeight.bold, color: THEME.text, marginBottom: 12 },
  emptyText: { fontSize: THEME.fontSize.md, color: THEME.textSecondary, textAlign: 'center', marginTop: 12, lineHeight: 24 },
  shareSection: { marginTop: THEME.spacing.lg, padding: THEME.spacing.md, backgroundColor: THEME.surface, borderRadius: THEME.radius.lg, borderWidth: 1, borderColor: THEME.border },
  shareTitle: { fontSize: THEME.fontSize.lg, fontWeight: THEME.fontWeight.semibold, color: THEME.text, marginBottom: 8 },
  shareDesc: { fontSize: THEME.fontSize.sm, color: THEME.textSecondary, marginBottom: 12, lineHeight: 20 },
  infoBox: { marginTop: THEME.spacing.lg, padding: THEME.spacing.md, backgroundColor: THEME.info + '15', borderRadius: THEME.radius.md },
  infoTitle: { fontSize: THEME.fontSize.sm, fontWeight: THEME.fontWeight.medium, color: THEME.info, marginBottom: 8 },
  infoText: { fontSize: THEME.fontSize.sm, color: THEME.info, lineHeight: 20 },
});

export default DailyCardScreen;