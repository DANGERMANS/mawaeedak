/**
 * Calendar Screen — Appointments Management for Mawaeedak Mobile
 * 
 * Features:
 * - Monthly calendar view
 * - Appointments list
 * - Add/edit appointments
 * - Today indicator
 * - Event markers
 */

import { useState, useMemo } from 'react';
import { View, Text, StyleSheet, ScrollView, Pressable, Modal, TextInput, Alert } from 'react-native';
import { Feather } from '@expo/vector-icons';

// Theme colors
const GOLD = '#C9A063';
const BROWN = '#8A6B3D';
const INK = '#2F2B25';
const PAPER = '#FAF7F2';
const CREAM = '#F5EFE4';
const TEXT_SECONDARY = '#6F6557';
const ERROR = '#B9483F';
const SUCCESS = '#7A9A74';

// Types
interface Appointment {
  id: string;
  title: string;
  date: string;
  time: string;
  type: 'medical' | 'official' | 'personal';
  notes?: string;
}

// Mock Data
const MOCK_APPOINTMENTS: Appointment[] = [
  { id: '1', title: 'زيارة الطبيب', date: '2026-06-12', time: '10:00', type: 'medical', notes: 'فحص دوري' },
  { id: '2', title: 'تجديد الإقامة', date: '2026-06-15', time: '14:00', type: 'official' },
  { id: '3', title: 'اجتماع عمل', date: '2026-06-18', time: '09:00', type: 'personal', notes: 'فندق الريتز' },
  { id: '4', title: 'صيانة السيارة', date: '2026-06-20', time: '11:00', type: 'personal' },
];

// Calendar helpers
const DAYS_AR = ['أحد', 'إثنين', 'ثلاثاء', 'أربعاء', 'خميس', 'جمعة', 'سبت'];
const MONTHS_AR = ['يناير', 'فبراير', 'مارس', 'أبريل', 'مايو', 'يونيو', 'يوليو', 'أغسطس', 'سبتمبر', 'أكتوبر', 'نوفمبر', 'ديسمبر'];

function getMonthDays(year: number, month: number): Date[] {
  const days: Date[] = [];
  const firstDay = new Date(year, month, 1);
  const lastDay = new Date(year, month + 1, 0);
  
  // Add padding for first week
  const startPadding = firstDay.getDay();
  for (let i = startPadding - 1; i >= 0; i--) {
    const d = new Date(year, month, -i);
    days.push(d);
  }
  
  // Add month days
  for (let d = 1; d <= lastDay.getDate(); d++) {
    days.push(new Date(year, month, d));
  }
  
  // Add padding for last week
  const endPadding = 6 - lastDay.getDay();
  for (let i = 1; i <= endPadding; i++) {
    days.push(new Date(year, month + 1, i));
  }
  
  return days;
}

function formatDate(date: Date): string {
  return `${date.getFullYear()}-${String(date.getMonth() + 1).padStart(2, '0')}-${String(date.getDate()).padStart(2, '0')}`;
}

// Day Cell Component
function DayCell({ date, isCurrentMonth, isToday, hasAppointment, isSelected, onPress }: {
  date: Date;
  isCurrentMonth: boolean;
  isToday: boolean;
  hasAppointment: boolean;
  isSelected: boolean;
  onPress: () => void;
}) {
  return (
    <Pressable
      style={[
        styles.dayCell,
        !isCurrentMonth && styles.dayCellOther,
        isToday && styles.dayCellToday,
        isSelected && styles.dayCellSelected,
      ]}
      onPress={onPress}
    >
      <Text
        style={[
          styles.dayText,
          !isCurrentMonth && styles.dayTextOther,
          isToday && styles.dayTextToday,
          isSelected && styles.dayTextSelected,
        ]}
      >
        {date.getDate()}
      </Text>
      {hasAppointment && <View style={styles.eventDot} />}
    </Pressable>
  );
}

// Appointment Card Component
function AppointmentCard({ appointment, onPress, onDelete }: {
  appointment: Appointment;
  onPress: () => void;
  onDelete: () => void;
}) {
  const getTypeIcon = () => {
    switch (appointment.type) {
      case 'medical': return '🏥';
      case 'official': return '📋';
      default: return '📅';
    }
  };

  const getTypeColor = () => {
    switch (appointment.type) {
      case 'medical': return '#4A7FB5';
      case 'official': return GOLD;
      default: return SUCCESS;
    }
  };

  return (
    <Pressable style={styles.appointmentCard} onPress={onPress}>
      <View style={[styles.appointmentIcon, { backgroundColor: getTypeColor() + '20' }]}>
        <Text style={{ fontSize: 24 }}>{getTypeIcon()}</Text>
      </View>
      <View style={styles.appointmentContent}>
        <Text style={styles.appointmentTitle}>{appointment.title}</Text>
        <View style={styles.appointmentMeta}>
          <Text style={styles.appointmentTime}>{appointment.time}</Text>
          {appointment.notes && (
            <Text style={styles.appointmentNotes}>{appointment.notes}</Text>
          )}
        </View>
      </View>
      <Pressable style={styles.deleteButton} onPress={onDelete}>
        <Feather name="trash-2" size={18} color={ERROR} />
      </Pressable>
    </Pressable>
  );
}

// Add Modal Component
function AddModal({ visible, onClose, onAdd, selectedDate }: {
  visible: boolean;
  onClose: () => void;
  onAdd: (appointment: Omit<Appointment, 'id'>) => void;
  selectedDate: string;
}) {
  const [title, setTitle] = useState('');
  const [time, setTime] = useState('09:00');
  const [type, setType] = useState<'medical' | 'official' | 'personal'>('personal');
  const [notes, setNotes] = useState('');

  const handleAdd = () => {
    if (!title) {
      Alert.alert('خطأ', 'يرجى إدخال عنوان الموعد');
      return;
    }
    onAdd({ title, date: selectedDate, time, type, notes });
    setTitle('');
    setTime('09:00');
    setType('personal');
    setNotes('');
    onClose();
  };

  const types = [
    { key: 'medical', label: 'طبي', icon: '🏥' },
    { key: 'official', label: 'رسمية', icon: '📋' },
    { key: 'personal', label: 'شخصي', icon: '📅' },
  ];

  return (
    <Modal visible={visible} animationType="slide" transparent>
      <View style={styles.modalOverlay}>
        <View style={styles.modalContent}>
          <View style={styles.modalHeader}>
            <Text style={styles.modalTitle}>إضافة موعد</Text>
            <Pressable onPress={onClose}>
              <Feather name="x" size={24} color={INK} />
            </Pressable>
          </View>

          <ScrollView style={styles.modalBody}>
            <Text style={styles.inputLabel}>العنوان</Text>
            <TextInput
              style={styles.input}
              value={title}
              onChangeText={setTitle}
              placeholder="أدخل عنوان الموعد"
              placeholderTextColor={TEXT_SECONDARY}
            />

            <Text style={styles.inputLabel}>التاريخ</Text>
            <View style={styles.dateDisplay}>
              <Feather name="calendar" size={20} color={GOLD} />
              <Text style={styles.dateDisplayText}>{selectedDate}</Text>
            </View>

            <Text style={styles.inputLabel}>الوقت</Text>
            <TextInput
              style={styles.input}
              value={time}
              onChangeText={setTime}
              placeholder="HH:MM"
              placeholderTextColor={TEXT_SECONDARY}
            />

            <Text style={styles.inputLabel}>النوع</Text>
            <View style={styles.typeSelector}>
              {types.map((t) => (
                <Pressable
                  key={t.key}
                  style={[styles.typeOption, type === t.key && styles.typeOptionActive]}
                  onPress={() => setType(t.key as any)}
                >
                  <Text style={{ fontSize: 20 }}>{t.icon}</Text>
                  <Text style={[styles.typeLabel, type === t.key && styles.typeLabelActive]}>
                    {t.label}
                  </Text>
                </Pressable>
              ))}
            </View>

            <Text style={styles.inputLabel}>ملاحظات (اختياري)</Text>
            <TextInput
              style={[styles.input, styles.inputMultiline]}
              value={notes}
              onChangeText={setNotes}
              placeholder="أدخل ملاحظات..."
              placeholderTextColor={TEXT_SECONDARY}
              multiline
              numberOfLines={3}
            />
          </ScrollView>

          <View style={styles.modalActions}>
            <Pressable style={styles.modalCancel} onPress={onClose}>
              <Text style={styles.modalCancelText}>إلغاء</Text>
            </Pressable>
            <Pressable style={styles.modalAdd} onPress={handleAdd}>
              <Text style={styles.modalAddText}>إضافة الموعد</Text>
            </Pressable>
          </View>
        </View>
      </View>
    </Modal>
  );
}

export default function CalendarScreen() {
  const today = new Date();
  const [currentDate, setCurrentDate] = useState(today);
  const [selectedDate, setSelectedDate] = useState<string>(formatDate(today));
  const [appointments, setAppointments] = useState(MOCK_APPOINTMENTS);
  const [showAddModal, setShowAddModal] = useState(false);

  const year = currentDate.getFullYear();
  const month = currentDate.getMonth();
  const monthDays = useMemo(() => getMonthDays(year, month), [year, month]);

  const selectedAppointments = appointments.filter(a => a.date === selectedDate);

  const hasAppointment = (date: Date): boolean => {
    return appointments.some(a => a.date === formatDate(date));
  };

  const goToPrevMonth = () => {
    setCurrentDate(new Date(year, month - 1, 1));
  };

  const goToNextMonth = () => {
    setCurrentDate(new Date(year, month + 1, 1));
  };

  const goToToday = () => {
    setCurrentDate(new Date());
    setSelectedDate(formatDate(today));
  };

  const handleAddAppointment = (appointment: Omit<Appointment, 'id'>) => {
    setAppointments([...appointments, { ...appointment, id: Date.now().toString() }]);
  };

  const handleDeleteAppointment = (id: string) => {
    Alert.alert(
      'حذف الموعد',
      'هل أنت متأكد من حذف هذا الموعد؟',
      [
        { text: 'إلغاء', style: 'cancel' },
        {
          text: 'حذف',
          style: 'destructive',
          onPress: () => setAppointments(appointments.filter(a => a.id !== id)),
        },
      ]
    );
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
          <Text style={styles.headerTitle}>التقويم</Text>
          <Pressable style={styles.todayButton} onPress={goToToday}>
            <Text style={styles.todayButtonText}>اليوم</Text>
          </Pressable>
        </View>

        {/* Month Navigation */}
        <View style={styles.monthNav}>
          <Pressable style={styles.navButton} onPress={goToPrevMonth}>
            <Feather name="chevron-right" size={24} color={BROWN} />
          </Pressable>
          <Text style={styles.monthTitle}>{MONTHS_AR[month]} {year}</Text>
          <Pressable style={styles.navButton} onPress={goToNextMonth}>
            <Feather name="chevron-left" size={24} color={BROWN} />
          </Pressable>
        </View>

        {/* Days Header */}
        <View style={styles.daysHeader}>
          {DAYS_AR.map((day) => (
            <Text key={day} style={styles.dayHeader}>{day}</Text>
          ))}
        </View>

        {/* Calendar Grid */}
        <View style={styles.calendarGrid}>
          {monthDays.map((date, index) => (
            <DayCell
              key={index}
              date={date}
              isCurrentMonth={date.getMonth() === month}
              isToday={formatDate(date) === formatDate(today)}
              hasAppointment={hasAppointment(date)}
              isSelected={formatDate(date) === selectedDate}
              onPress={() => setSelectedDate(formatDate(date))}
            />
          ))}
        </View>

        {/* Selected Date Appointments */}
        <View style={styles.appointmentsSection}>
          <View style={styles.appointmentsHeader}>
            <Text style={styles.appointmentsTitle}>
              مواعيد {selectedDate}
            </Text>
            <Pressable style={styles.addButton} onPress={() => setShowAddModal(true)}>
              <Feather name="plus" size={18} color="#FFFFFF" />
              <Text style={styles.addButtonText}>إضافة</Text>
            </Pressable>
          </View>

          {selectedAppointments.length > 0 ? (
            <View style={styles.appointmentsList}>
              {selectedAppointments.map((apt) => (
                <AppointmentCard
                  key={apt.id}
                  appointment={apt}
                  onPress={() => Alert.alert(apt.title, apt.notes || 'لا توجد ملاحظات')}
                  onDelete={() => handleDeleteAppointment(apt.id)}
                />
              ))}
            </View>
          ) : (
            <View style={styles.emptyState}>
              <Text style={styles.emptyIcon}>📅</Text>
              <Text style={styles.emptyText}>لا توجد مواعيد في هذا اليوم</Text>
              <Pressable style={styles.emptyButton} onPress={() => setShowAddModal(true)}>
                <Text style={styles.emptyButtonText}>إضافة موعد جديد</Text>
              </Pressable>
            </View>
          )}
        </View>

        {/* Bottom padding */}
        <View style={{ height: 100 }} />
      </ScrollView>

      {/* Add Modal */}
      <AddModal
        visible={showAddModal}
        onClose={() => setShowAddModal(false)}
        onAdd={handleAddAppointment}
        selectedDate={selectedDate}
      />
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
  header: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginBottom: 16,
  },
  headerTitle: {
    fontSize: 28,
    fontWeight: '800',
    color: INK,
  },
  todayButton: {
    backgroundColor: GOLD,
    paddingHorizontal: 16,
    paddingVertical: 8,
    borderRadius: 10,
  },
  todayButtonText: {
    color: '#FFFFFF',
    fontSize: 14,
    fontWeight: '600',
  },
  monthNav: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginBottom: 16,
  },
  navButton: {
    width: 40,
    height: 40,
    borderRadius: 12,
    backgroundColor: CREAM,
    justifyContent: 'center',
    alignItems: 'center',
  },
  monthTitle: {
    fontSize: 20,
    fontWeight: '700',
    color: INK,
  },
  daysHeader: {
    flexDirection: 'row',
    marginBottom: 8,
  },
  dayHeader: {
    flex: 1,
    textAlign: 'center',
    fontSize: 12,
    fontWeight: '600',
    color: TEXT_SECONDARY,
  },
  calendarGrid: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    marginBottom: 24,
  },
  dayCell: {
    width: '14.28%',
    aspectRatio: 1,
    justifyContent: 'center',
    alignItems: 'center',
    borderRadius: 10,
    marginVertical: 2,
  },
  dayCellOther: {
    opacity: 0.3,
  },
  dayCellToday: {
    backgroundColor: GOLD + '20',
  },
  dayCellSelected: {
    backgroundColor: GOLD,
  },
  dayText: {
    fontSize: 14,
    fontWeight: '500',
    color: INK,
  },
  dayTextOther: {
    color: TEXT_SECONDARY,
  },
  dayTextToday: {
    color: GOLD,
    fontWeight: '700',
  },
  dayTextSelected: {
    color: '#FFFFFF',
    fontWeight: '700',
  },
  eventDot: {
    width: 6,
    height: 6,
    borderRadius: 3,
    backgroundColor: GOLD,
    position: 'absolute',
    bottom: 6,
  },
  appointmentsSection: {
    marginTop: 8,
  },
  appointmentsHeader: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginBottom: 16,
  },
  appointmentsTitle: {
    fontSize: 18,
    fontWeight: '700',
    color: INK,
  },
  addButton: {
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: GOLD,
    paddingHorizontal: 14,
    paddingVertical: 8,
    borderRadius: 10,
    gap: 6,
  },
  addButtonText: {
    color: '#FFFFFF',
    fontSize: 13,
    fontWeight: '600',
  },
  appointmentsList: {
    gap: 10,
  },
  appointmentCard: {
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: CREAM,
    borderRadius: 14,
    padding: 14,
    borderWidth: 1,
    borderColor: 'rgba(201,160,99,0.10)',
  },
  appointmentIcon: {
    width: 50,
    height: 50,
    borderRadius: 14,
    justifyContent: 'center',
    alignItems: 'center',
    marginRight: 14,
  },
  appointmentContent: {
    flex: 1,
  },
  appointmentTitle: {
    fontSize: 16,
    fontWeight: '600',
    color: INK,
    marginBottom: 4,
  },
  appointmentMeta: {
    flexDirection: 'row',
    gap: 12,
  },
  appointmentTime: {
    fontSize: 13,
    color: TEXT_SECONDARY,
  },
  appointmentNotes: {
    fontSize: 13,
    color: TEXT_SECONDARY,
  },
  deleteButton: {
    padding: 8,
  },
  emptyState: {
    alignItems: 'center',
    paddingVertical: 32,
  },
  emptyIcon: {
    fontSize: 48,
    marginBottom: 12,
  },
  emptyText: {
    fontSize: 16,
    color: TEXT_SECONDARY,
    marginBottom: 16,
  },
  emptyButton: {
    backgroundColor: CREAM,
    paddingHorizontal: 20,
    paddingVertical: 12,
    borderRadius: 12,
    borderWidth: 1,
    borderColor: 'rgba(201,160,99,0.20)',
  },
  emptyButtonText: {
    color: GOLD,
    fontSize: 15,
    fontWeight: '600',
  },
  modalOverlay: {
    flex: 1,
    backgroundColor: 'rgba(0,0,0,0.5)',
    justifyContent: 'flex-end',
  },
  modalContent: {
    backgroundColor: PAPER,
    borderTopLeftRadius: 24,
    borderTopRightRadius: 24,
    maxHeight: '85%',
  },
  modalHeader: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    padding: 20,
    borderBottomWidth: 1,
    borderBottomColor: 'rgba(201,160,99,0.15)',
  },
  modalTitle: {
    fontSize: 18,
    fontWeight: '700',
    color: INK,
  },
  modalBody: {
    padding: 20,
  },
  inputLabel: {
    fontSize: 14,
    fontWeight: '600',
    color: INK,
    marginBottom: 8,
  },
  input: {
    backgroundColor: CREAM,
    borderRadius: 12,
    padding: 16,
    fontSize: 16,
    color: INK,
    marginBottom: 16,
    borderWidth: 1,
    borderColor: 'rgba(201,160,99,0.15)',
  },
  inputMultiline: {
    height: 80,
    textAlignVertical: 'top',
  },
  dateDisplay: {
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: CREAM,
    borderRadius: 12,
    padding: 16,
    marginBottom: 16,
    gap: 12,
  },
  dateDisplayText: {
    fontSize: 16,
    color: INK,
    fontWeight: '500',
  },
  typeSelector: {
    flexDirection: 'row',
    gap: 10,
    marginBottom: 16,
  },
  typeOption: {
    flex: 1,
    flexDirection: 'column',
    alignItems: 'center',
    backgroundColor: CREAM,
    borderRadius: 12,
    padding: 14,
    borderWidth: 1,
    borderColor: 'rgba(201,160,99,0.10)',
  },
  typeOptionActive: {
    borderColor: GOLD,
    backgroundColor: GOLD + '10',
  },
  typeLabel: {
    fontSize: 12,
    color: TEXT_SECONDARY,
    marginTop: 6,
  },
  typeLabelActive: {
    color: GOLD,
    fontWeight: '600',
  },
  modalActions: {
    flexDirection: 'row',
    paddingHorizontal: 20,
    paddingVertical: 16,
    gap: 12,
    borderTopWidth: 1,
    borderTopColor: 'rgba(201,160,99,0.15)',
  },
  modalCancel: {
    flex: 1,
    backgroundColor: CREAM,
    paddingVertical: 14,
    borderRadius: 12,
    alignItems: 'center',
  },
  modalCancelText: {
    fontSize: 16,
    fontWeight: '600',
    color: TEXT_SECONDARY,
  },
  modalAdd: {
    flex: 1,
    backgroundColor: GOLD,
    paddingVertical: 14,
    borderRadius: 12,
    alignItems: 'center',
  },
  modalAddText: {
    fontSize: 16,
    fontWeight: '600',
    color: '#FFFFFF',
  },
});