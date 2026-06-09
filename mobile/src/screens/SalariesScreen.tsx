/**
 * Salaries Screen — Mawaeedak Mobile
 * 
 * Financial dates and salary tracking screen.
 * Shows: الراتب, حساب المواطن, الدعم السكني, الضمان, التقاعد, التأهيل, ساند
 */

import React from 'react';
import { View, Text, StyleSheet, ScrollView } from 'react-native';
import { THEME } from '../constants/theme';
import { Card, PendingBanner } from '../components/Card';

interface FinancialItemProps {
  icon: string;
  name: string;
  status: 'pending' | 'approved' | 'official';
  nextDate?: string;
  countdown?: number;
}

const FinancialItem: React.FC<FinancialItemProps> = ({
  icon,
  name,
  status,
  nextDate,
  countdown,
}) => (
  <View style={styles.financialItem}>
    <Text style={styles.financialIcon}>{icon}</Text>
    <View style={styles.financialInfo}>
      <Text style={styles.financialName}>{name}</Text>
      {nextDate && <Text style={styles.financialDate}>{nextDate}</Text>}
    </View>
    <View style={styles.financialStatus}>
      {status === 'official' ? (
        <View style={[styles.statusBadge, styles.statusOfficial]}>
          <Text style={styles.statusTextOfficial}>رسمي</Text>
        </View>
      ) : status === 'approved' ? (
        <View style={[styles.statusBadge, styles.statusApproved]}>
          <Text style={styles.statusTextApproved}>معتمد</Text>
        </View>
      ) : (
        <View style={[styles.statusBadge, styles.statusPending]}>
          <Text style={styles.statusTextPending}>بانتظار</Text>
        </View>
      )}
      {countdown !== undefined && (
        <Text style={styles.countdown}>{countdown} يوم</Text>
      )}
    </View>
  </View>
);

export const SalariesScreen: React.FC = () => {
  // List of financial items - all pending until official linking
  const financialItems = [
    { icon: '💵', name: 'الراتب', key: 'gov_salary' },
    { icon: '🏦', name: 'حساب المواطن', key: 'citizen_account' },
    { icon: '🏠', name: 'الدعم السكني', key: 'housing_support' },
    { icon: '🛡️', name: 'الضمان الاجتماعي', key: 'social_security' },
    { icon: '👴', name: 'التقاعد', key: 'pension' },
    { icon: '💪', name: 'التأهيل الشامل', key: 'rehabilitation' },
    { icon: '🏥', name: 'ساند', key: 'sanad' },
  ];

  return (
    <ScrollView style={styles.container} contentContainerStyle={styles.content}>
      {/* Header */}
      <View style={styles.header}>
        <Text style={styles.title}>المواعيد المالية</Text>
        <Text style={styles.subtitle}>تتبع مواعيدك المالية بسهولة</Text>
      </View>

      {/* Pending Official Data Banner */}
      <PendingBanner message="بانتظار الربط بمصادر البيانات الرسمية" />

      {/* Financial Items List */}
      <View style={styles.list}>
        {financialItems.map((item) => (
          <Card key={item.key}>
            <FinancialItem
              icon={item.icon}
              name={item.name}
              status="pending"
            />
          </Card>
        ))}
      </View>

      {/* Info Note */}
      <View style={styles.infoNote}>
        <Text style={styles.infoIcon}>ℹ️</Text>
        <Text style={styles.infoText}>
          يتم ربط التواريخ الرسمية من الجهات الحكومية المالكة عند توفر الربط.
          لا يتم عرض تواريخ وهمية غير مؤيدة.
        </Text>
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
    marginBottom: THEME.spacing.xs,
  },
  subtitle: {
    fontSize: THEME.fontSize.md,
    color: THEME.textSecondary,
  },
  
  // List
  list: {
    gap: THEME.spacing.sm,
  },
  
  // Financial Item
  financialItem: {
    flexDirection: 'row-reverse',
    alignItems: 'center',
    paddingVertical: THEME.spacing.sm,
  },
  financialIcon: {
    fontSize: 28,
    marginLeft: THEME.spacing.md,
  },
  financialInfo: {
    flex: 1,
  },
  financialName: {
    fontSize: THEME.fontSize.lg,
    fontWeight: THEME.fontWeight.semibold,
    color: THEME.text,
  },
  financialDate: {
    fontSize: THEME.fontSize.sm,
    color: THEME.textSecondary,
    marginTop: 2,
  },
  financialStatus: {
    alignItems: 'flex-end',
    gap: 4,
  },
  
  // Status Badges
  statusBadge: {
    paddingHorizontal: THEME.spacing.sm,
    paddingVertical: 4,
    borderRadius: THEME.radius.full,
  },
  statusOfficial: {
    backgroundColor: THEME.success + '20',
  },
  statusTextOfficial: {
    color: THEME.success,
    fontSize: THEME.fontSize.xs,
    fontWeight: THEME.fontWeight.medium,
  },
  statusApproved: {
    backgroundColor: THEME.primary + '20',
  },
  statusTextApproved: {
    color: THEME.primary,
    fontSize: THEME.fontSize.xs,
    fontWeight: THEME.fontWeight.medium,
  },
  statusPending: {
    backgroundColor: THEME.warning + '20',
  },
  statusTextPending: {
    color: THEME.warning,
    fontSize: THEME.fontSize.xs,
    fontWeight: THEME.fontWeight.medium,
  },
  
  countdown: {
    fontSize: THEME.fontSize.sm,
    color: THEME.textSecondary,
    marginTop: 4,
  },
  
  // Info Note
  infoNote: {
    flexDirection: 'row-reverse',
    backgroundColor: THEME.info + '15',
    padding: THEME.spacing.md,
    borderRadius: THEME.radius.md,
    marginTop: THEME.spacing.lg,
    gap: THEME.spacing.sm,
  },
  infoIcon: {
    fontSize: 16,
  },
  infoText: {
    flex: 1,
    fontSize: THEME.fontSize.sm,
    color: THEME.info,
    lineHeight: 20,
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

export default SalariesScreen;