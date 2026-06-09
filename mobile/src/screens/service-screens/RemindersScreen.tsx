/**
 * Reminders Screen — ذكرني
 * Full local functionality for custom reminders
 */

import React, { useState, useEffect } from 'react';
import { View, Text, StyleSheet, ScrollView, TouchableOpacity, Modal, Alert } from 'react-native';
import { THEME } from '../../constants/theme';
import { Card, EmptyState, SectionHeader, PendingBanner } from '../../components/Card';
import { Button } from '../../components/Button';
import { Input } from '../../components/Input';
import { Select } from '../../components/Input';
import { remindersStorage } from '../../storage/LocalStorage';
import type { Reminder } from '../../types/app';

export const RemindersScreen: React.FC = () => {
  const [reminders, setReminders] = useState<Reminder[]>([]);
  const [showModal, setShowModal] = useState(false);
  const [editingReminder, setEditingReminder] = useState<Reminder | null>(null);
  
  // Form states
  const [title, setTitle] = useState('');
  const [date, setDate] = useState('');
  const [hijriDate, setHijriDate] = useState('');
  const [time, setTime] = useState('');
  const [notifyBefore, setNotifyBefore] = useState<'day' | 'hour'>('day');
  const [note, setNote] = useState('');

  useEffect(() => { loadReminders(); }, []);

  const loadReminders = async () => {
    const data = await remindersStorage.getAll();
    setReminders(data.sort((a, b) => new Date(a.date + ' ' + a.time).getTime() - new Date(b.date + ' ' + b.time).getTime()));
  };

  const resetForm = () => {
    setTitle(''); setDate(''); setHijriDate(''); setTime(''); setNotifyBefore('day'); setNote('');
    setEditingReminder(null);
  };

  const handleOpenAdd = () => { resetForm(); setShowModal(true); };

  const handleOpenEdit = (reminder: Reminder) => {
    setEditingReminder(reminder);
    setTitle(reminder.title);
    setDate(reminder.date);
    setHijriDate(reminder.hijriDate);
    setTime(reminder.time);
    setNotifyBefore(reminder.notifyBefore);
    setNote(reminder.note || '');
    setShowModal(true);
  };

  const handleSave = async () => {
    if (!title.trim() || !date || !time) { Alert.alert('خطأ', 'الرجاء ملء الحقول المطلوبة'); return; }
    
    const reminderData = {
      title: title.trim(),
      date,
      hijriDate: hijriDate || date,
      time,
      notifyBefore,
      note: note.trim() || undefined,
    };

    if (editingReminder) {
      await remindersStorage.update(editingReminder.id, reminderData);
    } else {
      await remindersStorage.add(reminderData);
    }

    await loadReminders();
    setShowModal(false);
    resetForm();
  };

  const handleDelete = (reminder: Reminder) => {
    Alert.alert('حذف التذكير', `هل أنت متأكد من حذف "${reminder.title}"؟`, [
      { text: 'إلغاء', style: 'cancel' },
      { text: 'حذف', style: 'destructive', onPress: async () => { await remindersStorage.delete(reminder.id); await loadReminders(); } },
    ]);
  };

  const formatDate = (dateStr: string) => {
    try {
      const date = new Date(dateStr);
      return date.toLocaleDateString('ar-SA', { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' });
    } catch { return dateStr; }
  };

  return (
    <View style={styles.container}>
      <View style={styles.header}>
        <Text style={styles.title}>ذكرني 🔔</Text>
      </View>

      <ScrollView style={styles.content} contentContainerStyle={styles.contentInner}>
        <PendingBanner message="بانتظار تفعيل الإشعارات المحلية" />
        
        <SectionHeader title="تذكيراتي" action={{ label: '+ إضافة', onPress: handleOpenAdd }} />

        {reminders.length === 0 ? (
          <Card><EmptyState icon="🔔" title="لا توجد تذكيرات" description="أضف تذكير مخصص" action={{ label: 'إضافة تذكير', onPress: handleOpenAdd }} /></Card>
        ) : (
          reminders.map((reminder) => (
            <Card key={reminder.id} onPress={() => handleOpenEdit(reminder)}>
              <View style={styles.reminderHeader}>
                <Text style={styles.reminderTitle}>{reminder.title}</Text>
                <TouchableOpacity onPress={() => handleDelete(reminder)}><Text style={styles.deleteBtn}>🗑️</Text></TouchableOpacity>
              </View>
              
              <View style={styles.reminderDetails}>
                <View style={styles.detailRow}>
                  <Text style={styles.detailLabel}>📅</Text>
                  <Text style={styles.detailValue}>{formatDate(reminder.date)}</Text>
                </View>
                <View style={styles.detailRow}>
                  <Text style={styles.detailLabel}>🕐</Text>
                  <Text style={styles.detailValue}>{reminder.time}</Text>
                </View>
                <View style={styles.detailRow}>
                  <Text style={styles.detailLabel}>⏰</Text>
                  <Text style={styles.detailValue}>
                    تذكير قبل: {reminder.notifyBefore === 'day' ? 'يوم كامل' : 'ساعة'}
                  </Text>
                </View>
              </View>

              {reminder.note && (
                <View style={styles.noteSection}>
                  <Text style={styles.noteLabel}>ملاحظة:</Text>
                  <Text style={styles.noteText}>{reminder.note}</Text>
                </View>
              )}

              <View style={styles.notificationHint}>
                <Text style={styles.hintText}>🔔 نص الإشعار:</Text>
                <Text style={styles.notificationText}>
                  ياحبيبنا حبينا نذكرك موعدك ({reminder.title}) بإذن الله بعد {reminder.notifyBefore === 'day' ? 'يوم' : 'ساعة'}
                </Text>
                {reminder.note && (
                  <Text style={styles.notificationText}>لا تنسى ({reminder.note}) وفقك الله</Text>
                )}
              </View>
            </Card>
          ))
        )}
      </ScrollView>

      <Modal visible={showModal} animationType="slide" presentationStyle="pageSheet">
        <View style={styles.modalContainer}>
          <View style={styles.modalHeader}>
            <Text style={styles.modalTitle}>{editingReminder ? 'تعديل التذكير' : 'تذكير جديد'}</Text>
            <TouchableOpacity onPress={() => { setShowModal(false); resetForm(); }}><Text style={styles.closeBtn}>✕</Text></TouchableOpacity>
          </View>
          <ScrollView style={styles.modalContent}>
            <Input label="عنوان التذكير *" placeholder="مثال: موعد عند الطبيب" value={title} onChangeText={setTitle} />
            
            <Input label="التاريخ (ميلادي) *" placeholder="YYYY-MM-DD" value={date} onChangeText={setDate} />
            <Input label="التاريخ (هجري) - اختياري" placeholder="١٥ رمضان ١٤٤٥" value={hijriDate} onChangeText={setHijriDate} />
            <Input label="الوقت *" placeholder="09:00" value={time} onChangeText={setTime} />
            
            <Select
              label="تذكير قبل"
              options={[{ label: '⏰ يوم كامل', value: 'day' }, { label: '🕐 ساعة', value: 'hour' }]}
              value={notifyBefore}
              onChange={(v) => setNotifyBefore(v as 'day' | 'hour')}
            />
            
            <Input label="ملاحظة (اختياري)" placeholder="مثال: إحضار البطاقة" value={note} onChangeText={setNote} />
            
            <View style={styles.notificationPreview}>
              <Text style={styles.previewTitle}>📱 معاينة الإشعار:</Text>
              <Text style={styles.previewText}>
                ياحبيبنا حبينا نذكرك موعدك ({title || '...'}) بإذن الله بعد {notifyBefore === 'day' ? 'يوم' : 'ساعة'}
              </Text>
              {note && <Text style={styles.previewText}>لا تنسى ({note}) وفقك الله</Text>}
            </View>

            <Button title={editingReminder ? 'حفظ' : 'إضافة'} onPress={handleSave} fullWidth />
          </ScrollView>
        </View>
      </Modal>
    </View>
  );
};

const styles = StyleSheet.create({
  container: { flex: 1, backgroundColor: THEME.background },
  header: { padding: THEME.spacing.md, backgroundColor: THEME.surface, borderBottomWidth: 1, borderBottomColor: THEME.border },
  title: { fontSize: THEME.fontSize.xxl, fontWeight: THEME.fontWeight.bold, color: THEME.text },
  content: { flex: 1 },
  contentInner: { padding: THEME.spacing.md, paddingBottom: THEME.spacing.xxl },
  reminderHeader: { flexDirection: 'row-reverse', justifyContent: 'space-between', alignItems: 'center', marginBottom: 12 },
  reminderTitle: { fontSize: THEME.fontSize.lg, fontWeight: THEME.fontWeight.bold, color: THEME.text, flex: 1 },
  deleteBtn: { fontSize: 18, padding: 4 },
  reminderDetails: { gap: 8 },
  detailRow: { flexDirection: 'row-reverse', alignItems: 'center', gap: 8 },
  detailLabel: { fontSize: 16 },
  detailValue: { fontSize: THEME.fontSize.md, color: THEME.text },
  noteSection: { backgroundColor: THEME.surfaceAlt, padding: 12, borderRadius: 8, marginTop: 12 },
  noteLabel: { fontSize: THEME.fontSize.sm, color: THEME.textSecondary, marginBottom: 4 },
  noteText: { fontSize: THEME.fontSize.md, color: THEME.text },
  notificationHint: { backgroundColor: THEME.primary + '15', padding: 12, borderRadius: 8, marginTop: 12 },
  hintText: { fontSize: THEME.fontSize.sm, fontWeight: THEME.fontWeight.medium, color: THEME.primary, marginBottom: 4 },
  notificationText: { fontSize: THEME.fontSize.sm, color: THEME.primary, marginTop: 2 },
  modalContainer: { flex: 1, backgroundColor: THEME.background },
  modalHeader: { flexDirection: 'row-reverse', justifyContent: 'space-between', alignItems: 'center', padding: THEME.spacing.md, backgroundColor: THEME.surface, borderBottomWidth: 1, borderBottomColor: THEME.border },
  modalTitle: { fontSize: THEME.fontSize.xl, fontWeight: THEME.fontWeight.bold, color: THEME.text },
  closeBtn: { fontSize: 24, color: THEME.textSecondary, padding: 8 },
  modalContent: { padding: THEME.spacing.md },
  notificationPreview: { backgroundColor: THEME.surfaceAlt, padding: 12, borderRadius: 8, marginBottom: 16 },
  previewTitle: { fontSize: THEME.fontSize.sm, fontWeight: THEME.fontWeight.semibold, color: THEME.text, marginBottom: 8 },
  previewText: { fontSize: THEME.fontSize.sm, color: THEME.textSecondary, marginTop: 2 },
});

export default RemindersScreen;