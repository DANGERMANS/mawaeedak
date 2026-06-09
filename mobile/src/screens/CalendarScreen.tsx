/**
 * Calendar Screen — Mawaeedak Mobile
 */

import React, { useState, useEffect } from 'react';
import { View, Text, StyleSheet, ScrollView, TouchableOpacity, Modal, Alert } from 'react-native';
import { THEME } from '../constants/theme';
import { Card, EmptyState, SectionHeader } from '../components/Card';
import { Button } from '../components/Button';
import { Input } from '../components/Input';
import { Select } from '../components/Input';
import { appointmentsStorage } from '../storage/LocalStorage';
import type { Appointment, AppointmentCategory, AppointmentPriority } from '../types/app';

const CATEGORIES: { label: string; value: AppointmentCategory }[] = [
  { label: 'شخصي', value: 'personal' },
  { label: 'عائلي', value: 'family' },
  { label: 'عمل', value: 'work' },
  { label: 'سفر', value: 'travel' },
  { label: 'صحة', value: 'health' },
  { label: 'وثائق', value: 'documents' },
  { label: 'مال', value: 'financial' },
];

const PRIORITIES: { label: string; value: AppointmentPriority }[] = [
  { label: 'منخفض', value: 'low' },
  { label: 'متوسط', value: 'medium' },
  { label: 'عالي', value: 'high' },
];

// Generate calendar days
const generateCalendarDays = (year: number, month: number) => {
  const firstDay = new Date(year, month, 1);
  const lastDay = new Date(year, month + 1, 0);
  const startDay = firstDay.getDay();
  const daysInMonth = lastDay.getDate();
  
  const days: (number | null)[] = [];
  
  // Add empty cells for days before the first day
  for (let i = 0; i < startDay; i++) {
    days.push(null);
  }
  
  // Add days of the month
  for (let i = 1; i <= daysInMonth; i++) {
    days.push(i);
  }
  
  return days;
};

export const CalendarScreen: React.FC = () => {
  const [appointments, setAppointments] = useState<Appointment[]>([]);
  const [selectedDate, setSelectedDate] = useState<number | null>(null);
  const [showAddModal, setShowAddModal] = useState(false);
  const [newTitle, setNewTitle] = useState('');
  const [newCategory, setNewCategory] = useState<AppointmentCategory>('personal');
  const [newPriority, setNewPriority] = useState<AppointmentPriority>('medium');
  
  const today = new Date();
  const [currentMonth, setCurrentMonth] = useState(today.getMonth());
  const [currentYear, setCurrentYear] = useState(today.getFullYear());
  
  const calendarDays = generateCalendarDays(currentYear, currentMonth);
  const weekDays = ['أحد', 'إثنين', 'ثلاثاء', 'أربعاء', 'خميس', 'جمعة', 'سبت'];

  useEffect(() => {
    loadAppointments();
  }, []);

  const loadAppointments = async () => {
    const data = await appointmentsStorage.getAll();
    setAppointments(data);
  };

  const navigateMonth = (direction: number) => {
    let newMonth = currentMonth + direction;
    let newYear = currentYear;
    
    if (newMonth < 0) {
      newMonth = 11;
      newYear--;
    } else if (newMonth > 11) {
      newMonth = 0;
      newYear++;
    }
    
    setCurrentMonth(newMonth);
    setCurrentYear(newYear);
  };

  const getMonthName = (month: number) => {
    const months = [
      'يناير', 'فبراير', 'مارس', 'أبريل', 'مايو', 'يونيو',
      'يوليو', 'أغسطس', 'سبتمبر', 'أكتوبر', 'نوفمبر', 'ديسمبر'
    ];
    return months[month];
  };

  const getAppointmentsForDay = (day: number) => {
    const dateStr = `${currentYear}-${String(currentMonth + 1).padStart(2, '0')}-${String(day).padStart(2, '0')}`;
    return appointments.filter(a => a.date === dateStr);
  };

  const handleAddAppointment = async () => {
    if (!selectedDate || !newTitle.trim()) {
      Alert.alert('خطأ', 'الرجاء إدخال عنوان الموعد');
      return;
    }

    const dateStr = `${currentYear}-${String(currentMonth + 1).padStart(2, '0')}-${String(selectedDate).padStart(2, '0')}`;
    
    const newAppointment = await appointmentsStorage.add({
      title: newTitle.trim(),
      date: dateStr,
      hijriDate: '',
      category: newCategory,
      priority: newPriority,
      notes: '',
      reminder: false,
    });

    if (newAppointment) {
      await loadAppointments();
      setNewTitle('');
      setSelectedDate(null);
      setShowAddModal(false);
      Alert.alert('تم', 'تم إضافة الموعد بنجاح');
    }
  };

  const handleDeleteAppointment = async (id: string) => {
    Alert.alert(
      'حذف الموعد',
      'هل أنت متأكد من حذف هذا الموعد؟',
      [
        { text: 'إلغاء', style: 'cancel' },
        {
          text: 'حذف',
          style: 'destructive',
          onPress: async () => {
            await appointmentsStorage.delete(id);
            await loadAppointments();
          },
        },
      ]
    );
  };

  return (
    <View style={styles.container}>
      {/* Calendar Header */}
      <View style={styles.calendarHeader}>
        <TouchableOpacity onPress={() => navigateMonth(-1)}>
          <Text style={styles.navButton}>→</Text>
        </TouchableOpacity>
        <Text style={styles.monthYear}>
          {getMonthName(currentMonth)} {currentYear}
        </Text>
        <TouchableOpacity onPress={() => navigateMonth(1)}>
          <Text style={styles.navButton}>←</Text>
        </TouchableOpacity>
      </View>

      {/* Week Days */}
      <View style={styles.weekDays}>
        {weekDays.map((day, index) => (
          <View key={index} style={styles.weekDayCell}>
            <Text style={styles.weekDayText}>{day}</Text>
          </View>
        ))}
      </View>

      {/* Calendar Grid */}
      <View style={styles.calendarGrid}>
        {calendarDays.map((day, index) => {
          const dayAppointments = day ? getAppointmentsForDay(day) : [];
          const isToday = day === today.getDate() && 
            currentMonth === today.getMonth() && 
            currentYear === today.getFullYear();
          const isSelected = day === selectedDate;

          return (
            <TouchableOpacity
              key={index}
              style={[
                styles.dayCell,
                isToday && styles.dayCellToday,
                isSelected && styles.dayCellSelected,
              ]}
              onPress={() => day && setSelectedDate(day)}
              disabled={!day}
            >
              {day && (
                <>
                  <Text style={[
                    styles.dayText,
                    isToday && styles.dayTextToday,
                    isSelected && styles.dayTextSelected,
                  ]}>
                    {day}
                  </Text>
                  {dayAppointments.length > 0 && (
                    <View style={styles.appointmentDot} />
                  )}
                </>
              )}
            </TouchableOpacity>
          );
        })}
      </View>

      {/* Selected Day Appointments */}
      {selectedDate && (
        <View style={styles.appointmentsSection}>
          <SectionHeader 
            title={`مواعيد يوم ${selectedDate}`} 
            action={{ label: 'إضافة', onPress: () => setShowAddModal(true) }}
          />
          
          {getAppointmentsForDay(selectedDate).length === 0 ? (
            <Card>
              <EmptyState
                icon="📅"
                title="لا توجد مواعيد"
                description="اضغط على إضافة لإضافة موعد جديد"
                action={{ label: 'إضافة موعد', onPress: () => setShowAddModal(true) }}
              />
            </Card>
          ) : (
            getAppointmentsForDay(selectedDate).map((apt) => (
              <Card key={apt.id}>
                <View style={styles.appointmentItem}>
                  <View style={styles.appointmentInfo}>
                    <Text style={styles.appointmentTitle}>{apt.title}</Text>
                    <View style={styles.appointmentMeta}>
                      <Text style={styles.appointmentCategory}>
                        {CATEGORIES.find(c => c.value === apt.category)?.label}
                      </Text>
                      <View style={[styles.priorityBadge, 
                        apt.priority === 'high' && styles.priorityHigh,
                        apt.priority === 'low' && styles.priorityLow
                      ]}>
                        <Text style={styles.priorityText}>
                          {PRIORITIES.find(p => p.value === apt.priority)?.label}
                        </Text>
                      </View>
                    </View>
                  </View>
                  <TouchableOpacity onPress={() => handleDeleteAppointment(apt.id)}>
                    <Text style={styles.deleteButton}>🗑️</Text>
                  </TouchableOpacity>
                </View>
              </Card>
            ))
          )}
        </View>
      )}

      {/* Add Modal */}
      <Modal visible={showAddModal} animationType="slide" presentationStyle="pageSheet">
        <View style={styles.modalContainer}>
          <View style={styles.modalHeader}>
            <Text style={styles.modalTitle}>إضافة موعد</Text>
            <TouchableOpacity onPress={() => setShowAddModal(false)}>
              <Text style={styles.closeButton}>✕</Text>
            </TouchableOpacity>
          </View>
          
          <ScrollView style={styles.modalContent}>
            <Input
              label="عنوان الموعد"
              placeholder="مثال: موعد عند الطبيب"
              value={newTitle}
              onChangeText={setNewTitle}
            />
            
            <Select
              label="التصنيف"
              options={CATEGORIES}
              value={newCategory}
              onChange={(v) => setNewCategory(v as AppointmentCategory)}
            />
            
            <Select
              label="الأهمية"
              options={PRIORITIES}
              value={newPriority}
              onChange={(v) => setNewPriority(v as AppointmentPriority)}
            />
            
            <Button 
              title="حفظ الموعد" 
              onPress={handleAddAppointment} 
              fullWidth
            />
          </ScrollView>
        </View>
      </Modal>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: THEME.background,
  },
  
  // Calendar Header
  calendarHeader: {
    flexDirection: 'row-reverse',
    justifyContent: 'space-between',
    alignItems: 'center',
    padding: THEME.spacing.md,
    backgroundColor: THEME.surface,
  },
  navButton: {
    fontSize: 24,
    color: THEME.primary,
    padding: THEME.spacing.sm,
  },
  monthYear: {
    fontSize: THEME.fontSize.xl,
    fontWeight: THEME.fontWeight.bold,
    color: THEME.text,
  },
  
  // Week Days
  weekDays: {
    flexDirection: 'row-reverse',
    backgroundColor: THEME.surfaceAlt,
    paddingVertical: THEME.spacing.sm,
    borderBottomWidth: 1,
    borderBottomColor: THEME.border,
  },
  weekDayCell: {
    flex: 1,
    alignItems: 'center',
  },
  weekDayText: {
    fontSize: THEME.fontSize.sm,
    color: THEME.textSecondary,
    fontWeight: THEME.fontWeight.medium,
  },
  
  // Calendar Grid
  calendarGrid: {
    flexDirection: 'row-reverse',
    flexWrap: 'wrap',
    padding: THEME.spacing.sm,
    backgroundColor: THEME.surface,
  },
  dayCell: {
    width: '14.28%',
    aspectRatio: 1,
    justifyContent: 'center',
    alignItems: 'center',
    borderWidth: 0.5,
    borderColor: THEME.borderLight,
  },
  dayCellToday: {
    backgroundColor: THEME.primary + '20',
  },
  dayCellSelected: {
    backgroundColor: THEME.primary,
  },
  dayText: {
    fontSize: THEME.fontSize.md,
    color: THEME.text,
  },
  dayTextToday: {
    fontWeight: THEME.fontWeight.bold,
    color: THEME.primary,
  },
  dayTextSelected: {
    color: '#FFFFFF',
    fontWeight: THEME.fontWeight.bold,
  },
  appointmentDot: {
    position: 'absolute',
    bottom: 4,
    width: 6,
    height: 6,
    borderRadius: 3,
    backgroundColor: THEME.primary,
  },
  
  // Appointments Section
  appointmentsSection: {
    flex: 1,
    padding: THEME.spacing.md,
  },
  appointmentItem: {
    flexDirection: 'row-reverse',
    justifyContent: 'space-between',
    alignItems: 'center',
  },
  appointmentInfo: {
    flex: 1,
  },
  appointmentTitle: {
    fontSize: THEME.fontSize.lg,
    fontWeight: THEME.fontWeight.semibold,
    color: THEME.text,
    marginBottom: 4,
  },
  appointmentMeta: {
    flexDirection: 'row-reverse',
    gap: THEME.spacing.sm,
    alignItems: 'center',
  },
  appointmentCategory: {
    fontSize: THEME.fontSize.sm,
    color: THEME.textSecondary,
  },
  priorityBadge: {
    backgroundColor: THEME.warning + '20',
    paddingHorizontal: THEME.spacing.sm,
    paddingVertical: 2,
    borderRadius: THEME.radius.sm,
  },
  priorityHigh: {
    backgroundColor: THEME.error + '20',
  },
  priorityLow: {
    backgroundColor: THEME.success + '20',
  },
  priorityText: {
    fontSize: THEME.fontSize.xs,
    color: THEME.warning,
  },
  deleteButton: {
    fontSize: 20,
    padding: THEME.spacing.sm,
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
  modalContent: {
    padding: THEME.spacing.md,
  },
});

export default CalendarScreen;