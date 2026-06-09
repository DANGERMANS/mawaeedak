/**
 * Services Screen — Mawaeedak Mobile
 * 
 * 8 services with full local functionality:
 * 1. احسب هدفك (GoalsScreen)
 * 2. حساب التكاليف (CostsScreen)
 * 3. ذكرني (RemindersScreen)
 * 4. السفر (TravelScreen)
 * 5. الدراسة والإجازات (StudyScreen)
 * 6. الوظائف والأخبار (JobsScreen)
 * 7. بطاقة اليوم (DailyCardScreen)
 * 8. صوتك مسموع (FeedbackScreen)
 */

import React, { useState } from 'react';
import { View, Text, StyleSheet, ScrollView, TouchableOpacity, Modal } from 'react-native';
import { THEME } from '../constants/theme';

// Import real service screens
import { GoalsScreen } from './service-screens/GoalsScreen';
import { CostsScreen } from './service-screens/CostsScreen';
import { RemindersScreen } from './service-screens/RemindersScreen';
import { TravelScreen } from './service-screens/TravelScreen';
import { StudyScreen } from './service-screens/StudyScreen';
import JobsScreen from './service-screens/JobsScreen';
import DailyCardScreen from './service-screens/DailyCardScreen';
import FeedbackScreen from './service-screens/FeedbackScreen';

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

export const ServicesScreen: React.FC = () => {
  const [activeService, setActiveService] = useState<string | null>(null);

  const getServiceTitle = (id: string) => {
    const service = SERVICES.find(s => s.id === id);
    return service?.label || '';
  };

  const renderServiceScreen = () => {
    switch (activeService) {
      case 'goals':
        return <GoalsScreen />;
      case 'costs':
        return <CostsScreen />;
      case 'reminders':
        return <RemindersScreen />;
      case 'travel':
        return <TravelScreen />;
      case 'study':
        return <StudyScreen />;
      case 'jobs':
        return <JobsScreen />;
      case 'dailyCard':
        return <DailyCardScreen />;
      case 'feedback':
        return <FeedbackScreen />;
      default:
        return null;
    }
  };

  // If a service is active, show the service screen
  if (activeService) {
    return (
      <View style={styles.fullScreen}>
        <View style={styles.modalHeader}>
          <Text style={styles.modalTitle}>{getServiceTitle(activeService)}</Text>
          <TouchableOpacity onPress={() => setActiveService(null)}>
            <Text style={styles.closeButton}>✕</Text>
          </TouchableOpacity>
        </View>
        {renderServiceScreen()}
      </View>
    );
  }

  // Otherwise show the services grid
  return (
    <ScrollView style={styles.container} contentContainerStyle={styles.content}>
      <View style={styles.header}>
        <Text style={styles.title}>الخدمات</Text>
        <Text style={styles.subtitle}>اختر الخدمة التي تحتاجها</Text>
      </View>

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
  
  grid: {
    flexDirection: 'row-reverse',
    flexWrap: 'wrap',
    marginHorizontal: -THEME.spacing.xs,
  },
  
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
  
  footer: {
    textAlign: 'center',
    color: THEME.textSecondary,
    fontSize: THEME.fontSize.sm,
    marginTop: THEME.spacing.xl,
    fontStyle: 'italic',
  },
  
  // Full screen for service
  fullScreen: {
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
});

export default ServicesScreen;