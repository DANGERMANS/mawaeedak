import React from 'react';
import { View, Text, StyleSheet, Alert } from 'react-native';
import { THEME } from '../../constants/theme';
import { Card, PendingBanner } from '../../components/Card';
import { Button } from '../../components/Button';

export const DailyCardScreen: React.FC = () => {
  const handleUnavailableShare = () => {
    Alert.alert('بانتظار بطاقة اليوم', 'لا يمكن مشاركة بطاقة اليوم قبل اعتماد المحتوى من الإدارة.');
  };

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
        <View style={styles.dateCard}>
          <Text style={styles.dateIcon}>📅</Text>
          <Text style={styles.dateText}>{gregorianDate}</Text>
        </View>

        <Card>
          <View style={styles.cardContent}>
            <Text style={styles.cardIcon}>🎴</Text>
            <Text style={styles.cardTitle}>بطاقة اليوم</Text>
            <PendingBanner message="بانتظار ربط رسالة اليوم من الإدارة" />
            <Text style={styles.emptyText}>لا توجد بطاقة يومية معتمدة حالياً.</Text>
          </View>
        </Card>

        <View style={styles.shareSection}>
          <Text style={styles.shareTitle}>📤 المشاركة</Text>
          <Text style={styles.shareDesc}>المشاركة غير متاحة حتى توفر بطاقة رسمية.</Text>
          <Button
            title="المشاركة غير متاحة حالياً"
            onPress={handleUnavailableShare}
            variant="outline"
            icon="⏳"
          />
        </View>
      </View>
    </View>
  );
};

const styles = StyleSheet.create({
  container: { flex: 1, backgroundColor: THEME.background },
  header: { padding: THEME.spacing.md, backgroundColor: THEME.surface, borderBottomWidth: 1, borderBottomColor: THEME.border },
  title: { fontSize: THEME.fontSize.xxl, fontWeight: THEME.fontWeight.bold, color: THEME.text },
  content: { flex: 1, padding: THEME.spacing.md },
  dateCard: { backgroundColor: THEME.surface, borderRadius: THEME.radius.lg, padding: THEME.spacing.lg, marginBottom: THEME.spacing.md, alignItems: 'center', borderWidth: 1, borderColor: THEME.border },
  dateIcon: { fontSize: 32, marginBottom: 8 },
  dateText: { fontSize: THEME.fontSize.lg, fontWeight: THEME.fontWeight.semibold, color: THEME.text },
  cardContent: { alignItems: 'center' },
  cardIcon: { fontSize: 48, marginBottom: 12 },
  cardTitle: { fontSize: THEME.fontSize.xl, fontWeight: THEME.fontWeight.bold, color: THEME.text, marginBottom: 12 },
  emptyText: { fontSize: THEME.fontSize.md, color: THEME.textSecondary, textAlign: 'center', marginTop: 12 },
  shareSection: { marginTop: THEME.spacing.lg, padding: THEME.spacing.md, backgroundColor: THEME.surface, borderRadius: THEME.radius.lg, borderWidth: 1, borderColor: THEME.border },
  shareTitle: { fontSize: THEME.fontSize.lg, fontWeight: THEME.fontWeight.semibold, color: THEME.text, marginBottom: 8 },
  shareDesc: { fontSize: THEME.fontSize.sm, color: THEME.textSecondary, marginBottom: 12 },
});

export default DailyCardScreen;
