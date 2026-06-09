/**
 * Services Screen — Mawaeedak Mobile
 * 
 * 8 services as specified:
 * 1. احسب هدفك
 * 2. حساب التكاليف
 * 3. ذكرني
 * 4. السفر
 * 5. الدراسة والإجازات
 * 6. الوظائف والأخبار
 * 7. بطاقة اليوم
 * 8. صوتك مسموع
 */

import React, { useState } from 'react';
import { View, Text, StyleSheet, ScrollView, TouchableOpacity, Modal } from 'react-native';
import { THEME } from '../constants/theme';
import { Button } from '../components/Button';

// Service definitions
const SERVICES = [
  { id: 'goals', icon: '🎯', label: 'احسب هدفك', description: 'حدد أهدافك وتتبع تقدمك' },
  { id: 'costs', icon: '🧮', label: 'حساب التكاليف', description: 'احسب تكاليف مشاريعك' },
  { id: 'reminders', icon: '🔔', label: 'ذكرني', description: 'تذكيرات مخصصة' },
  { id: 'travel', icon: '✈️', label: 'السفر', description: 'رحلات ومستندات' },
  { id: 'study', icon: '📚', label: 'الدراسة والإجازات', description: 'تقويم دراسي وإجازات' },
  { id: 'jobs', icon: '💼', label: 'الوظائف والأخبار', description: 'وظائف وأخبار' },
  { id: 'dailyCard', icon: '🎴', label: 'بطاقة اليوم', description: 'شارك بطاقة يومية' },
  { id: 'feedback', icon: '📝', label: 'صوتك مسموع', description: 'اقتراحات وشكاوى' },
];

interface ServiceScreenProps {
  serviceId: string;
  onClose: () => void;
}

// Placeholder service screens
const ServicePlaceholder: React.FC<ServiceScreenProps & { title: string }> = ({
  serviceId,
  title,
  onClose,
}) => (
  <View style={styles.placeholderContainer}>
    <Text style={styles.placeholderIcon}>🔧</Text>
    <Text style={styles.placeholderTitle}>{title}</Text>
    <Text style={styles.placeholderDesc}>
      شاشة {title} قيد الإنشاء
    </Text>
    <Text style={styles.placeholderNote}>
      سيتم ربط البيانات المحلية والتحديثات لاحقاً
    </Text>
    <Button title="إغلاق" onPress={onClose} variant="outline" />
  </View>
);

export const ServicesScreen: React.FC = () => {
  const [activeService, setActiveService] = useState<string | null>(null);

  const getServiceTitle = (id: string) => {
    const service = SERVICES.find(s => s.id === id);
    return service?.label || '';
  };

  return (
    <>
      <ScrollView style={styles.container} contentContainerStyle={styles.content}>
        {/* Header */}
        <View style={styles.header}>
          <Text style={styles.title}>الخدمات</Text>
          <Text style={styles.subtitle}>اختر الخدمة التي تحتاجها</Text>
        </View>

        {/* Services Grid */}
        <View style={styles.grid}>
          {SERVICES.map((service) => (
            <TouchableOpacity
              key={service.id}
              style={styles.serviceCard}
              onPress={() => setActiveService(service.id)}
              activeOpacity={0.7}
            >
              <Text style={styles.serviceIcon}>{service.icon}</Text>
              <Text style={styles.serviceLabel}>{service.label}</Text>
              <Text style={styles.serviceDesc}>{service.description}</Text>
            </TouchableOpacity>
          ))}
        </View>

        {/* Footer */}
        <Text style={styles.footer}>بسم الله توكلت</Text>
      </ScrollView>

      {/* Service Modal */}
      <Modal
        visible={!!activeService}
        animationType="slide"
        presentationStyle="pageSheet"
        onRequestClose={() => setActiveService(null)}
      >
        <View style={styles.modalContainer}>
          <View style={styles.modalHeader}>
            <Text style={styles.modalTitle}>{getServiceTitle(activeService || '')}</Text>
            <TouchableOpacity onPress={() => setActiveService(null)}>
              <Text style={styles.closeButton}>✕</Text>
            </TouchableOpacity>
          </View>
          
          {activeService === 'goals' && (
            <ServicePlaceholder serviceId="goals" title="احسب هدفك" onClose={() => setActiveService(null)} />
          )}
          {activeService === 'costs' && (
            <ServicePlaceholder serviceId="costs" title="حساب التكاليف" onClose={() => setActiveService(null)} />
          )}
          {activeService === 'reminders' && (
            <ServicePlaceholder serviceId="reminders" title="ذكرني" onClose={() => setActiveService(null)} />
          )}
          {activeService === 'travel' && (
            <ServicePlaceholder serviceId="travel" title="السفر" onClose={() => setActiveService(null)} />
          )}
          {activeService === 'study' && (
            <ServicePlaceholder serviceId="study" title="الدراسة والإجازات" onClose={() => setActiveService(null)} />
          )}
          {activeService === 'jobs' && (
            <ServicePlaceholder serviceId="jobs" title="الوظائف والأخبار" onClose={() => setActiveService(null)} />
          )}
          {activeService === 'dailyCard' && (
            <ServicePlaceholder serviceId="dailyCard" title="بطاقة اليوم" onClose={() => setActiveService(null)} />
          )}
          {activeService === 'feedback' && (
            <ServicePlaceholder serviceId="feedback" title="صوتك مسموع" onClose={() => setActiveService(null)} />
          )}
        </View>
      </Modal>
    </>
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
  
  // Grid
  grid: {
    flexDirection: 'row-reverse',
    flexWrap: 'wrap',
    marginHorizontal: -THEME.spacing.xs,
  },
  
  // Service Card
  serviceCard: {
    width: '48%',
    backgroundColor: THEME.surface,
    borderRadius: THEME.radius.lg,
    padding: THEME.spacing.md,
    marginHorizontal: '1%',
    marginBottom: THEME.spacing.md,
    borderWidth: 1,
    borderColor: THEME.border,
    alignItems: 'center',
  },
  serviceIcon: {
    fontSize: 36,
    marginBottom: THEME.spacing.sm,
  },
  serviceLabel: {
    fontSize: THEME.fontSize.md,
    fontWeight: THEME.fontWeight.bold,
    color: THEME.text,
    marginBottom: 4,
    textAlign: 'center',
  },
  serviceDesc: {
    fontSize: THEME.fontSize.sm,
    color: THEME.textSecondary,
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
  
  // Modal
  modalContainer: {
    flex: 1,
    backgroundColor: THEME.background,
  },
  modalHeader: {
    flexDirection: 'row-reverse',
    justifyContent: 'space-between',
    alignItems: 'center',
    padding: THEME.spacing.md,
    backgroundColor: THEME.surface,
    borderBottomWidth: 1,
    borderBottomColor: THEME.border,
  },
  modalTitle: {
    fontSize: THEME.fontSize.xl,
    fontWeight: THEME.fontWeight.bold,
    color: THEME.text,
  },
  closeButton: {
    fontSize: 24,
    color: THEME.textSecondary,
    padding: THEME.spacing.sm,
  },
  
  // Placeholder
  placeholderContainer: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    padding: THEME.spacing.xl,
  },
  placeholderIcon: {
    fontSize: 64,
    marginBottom: THEME.spacing.lg,
  },
  placeholderTitle: {
    fontSize: THEME.fontSize.xl,
    fontWeight: THEME.fontWeight.bold,
    color: THEME.text,
    marginBottom: THEME.spacing.sm,
  },
  placeholderDesc: {
    fontSize: THEME.fontSize.md,
    color: THEME.textSecondary,
    textAlign: 'center',
    marginBottom: THEME.spacing.md,
  },
  placeholderNote: {
    fontSize: THEME.fontSize.sm,
    color: THEME.textMuted,
    textAlign: 'center',
    marginBottom: THEME.spacing.xl,
    paddingHorizontal: THEME.spacing.lg,
  },
});

export default ServicesScreen;