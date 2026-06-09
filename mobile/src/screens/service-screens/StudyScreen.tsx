/**
 * Study Screen — الدراسة والإجازات
 * Full local functionality for study schedule
 */

import React, { useState, useEffect } from 'react';
import { View, Text, StyleSheet, ScrollView, TouchableOpacity, Modal, Alert } from 'react-native';
import { THEME } from '../../constants/theme';
import { Card, EmptyState, SectionHeader, PendingBanner } from '../../components/Card';
import { Button } from '../../components/Button';
import { Input } from '../../components/Input';
import { Select } from '../../components/Input';
import AsyncStorage from '@react-native-async-storage/async-storage';

type StudyItem = {
  id: string;
  title: string;
  type: 'study' | 'vacation' | 'exam' | 'important';
  date: string;
  notes?: string;
  createdAt: string;
};

const STORAGE_KEY = 'mawaeedak_study_items';

export const StudyScreen: React.FC = () => {
  const [items, setItems] = useState<StudyItem[]>([]);
  const [showModal, setShowModal] = useState(false);
  const [editingItem, setEditingItem] = useState<StudyItem | null>(null);
  
  const [title, setTitle] = useState('');
  const [type, setType] = useState<StudyItem['type']>('study');
  const [date, setDate] = useState('');
  const [notes, setNotes] = useState('');

  useEffect(() => { loadItems(); }, []);

  const loadItems = async () => {
    const data = await AsyncStorage.getItem(STORAGE_KEY);
    if (data) setItems(JSON.parse(data));
  };

  const saveItems = async (newItems: StudyItem[]) => {
    await AsyncStorage.setItem(STORAGE_KEY, JSON.stringify(newItems));
    setItems(newItems);
  };

  const resetForm = () => { setTitle(''); setType('study'); setDate(''); setNotes(''); setEditingItem(null); };

  const handleOpenAdd = () => { resetForm(); setShowModal(true); };

  const handleOpenEdit = (item: StudyItem) => {
    setEditingItem(item);
    setTitle(item.title);
    setType(item.type);
    setDate(item.date);
    setNotes(item.notes || '');
    setShowModal(true);
  };

  const handleSave = async () => {
    if (!title.trim() || !date) { Alert.alert('خطأ', 'الرجاء ملء الحقول المطلوبة'); return; }
    
    const newItem: StudyItem = {
      id: editingItem?.id || `study_${Date.now()}`,
      title: title.trim(),
      type,
      date,
      notes: notes.trim() || undefined,
      createdAt: editingItem?.createdAt || new Date().toISOString(),
    };

    let newItems: StudyItem[];
    if (editingItem) {
      newItems = items.map(i => i.id === editingItem.id ? newItem : i);
    } else {
      newItems = [...items, newItem];
    }

    await saveItems(newItems);
    setShowModal(false);
    resetForm();
  };

  const handleDelete = (item: StudyItem) => {
    Alert.alert('حذف', `هل أنت متأكد من حذف "${item.title}"؟`, [
      { text: 'إلغاء', style: 'cancel' },
      { text: 'حذف', style: 'destructive', onPress: async () => { await saveItems(items.filter(i => i.id !== item.id)); } },
    ]);
  };

  const getTypeLabel = (t: string) => {
    switch (t) {
      case 'study': return '📚 دراسة';
      case 'vacation': return '🏖️ إجازة';
      case 'exam': return '📝 اختبار';
      case 'important': return '⭐ موعد مهم';
      default: return t;
    }
  };

  const getTypeColor = (t: string) => {
    switch (t) {
      case 'study': return THEME.primary;
      case 'vacation': return THEME.success;
      case 'exam': return THEME.warning;
      case 'important': return THEME.error;
      default: return THEME.text;
    }
  };

  const formatDate = (dateStr: string) => {
    try { return new Date(dateStr).toLocaleDateString('ar-SA', { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' }); }
    catch { return dateStr; }
  };

  const sortedItems = [...items].sort((a, b) => new Date(a.date).getTime() - new Date(b.date).getTime());

  return (
    <View style={styles.container}>
      <View style={styles.header}>
        <Text style={styles.title}>الدراسة والإجازات 📚</Text>
      </View>

      <ScrollView style={styles.content} contentContainerStyle={styles.contentInner}>
        <PendingBanner message="بانتظار ربط التقويم الدراسي الرسمي" />
        
        <SectionHeader title="المواعيد الدراسية" action={{ label: '+ إضافة', onPress: handleOpenAdd }} />

        {sortedItems.length === 0 ? (
          <Card><EmptyState icon="📚" title="لا توجد مواعيد" description="أضف موعد دراسي أو إجازة" action={{ label: 'إضافة', onPress: handleOpenAdd }} /></Card>
        ) : (
          sortedItems.map((item) => (
            <Card key={item.id} onPress={() => handleOpenEdit(item)}>
              <View style={styles.itemHeader}>
                <View style={[styles.typeBadge, { backgroundColor: getTypeColor(item.type) + '20' }]}>
                  <Text style={[styles.typeBadgeText, { color: getTypeColor(item.type) }]}>{getTypeLabel(item.type)}</Text>
                </View>
                <TouchableOpacity onPress={() => handleDelete(item)}><Text style={styles.deleteBtn}>🗑️</Text></TouchableOpacity>
              </View>
              <Text style={styles.itemTitle}>{item.title}</Text>
              <Text style={styles.itemDate}>📅 {formatDate(item.date)}</Text>
              {item.notes && <Text style={styles.itemNotes}>{item.notes}</Text>}
            </Card>
          ))
        )}
      </ScrollView>

      <Modal visible={showModal} animationType="slide" presentationStyle="pageSheet">
        <View style={styles.modalContainer}>
          <View style={styles.modalHeader}>
            <Text style={styles.modalTitle}>{editingItem ? 'تعديل' : 'إضافة موعد'}</Text>
            <TouchableOpacity onPress={() => { setShowModal(false); resetForm(); }}><Text style={styles.closeBtn}>✕</Text></TouchableOpacity>
          </View>
          <ScrollView style={styles.modalContent}>
            <Input label="العنوان *" placeholder="مثال: بداية الفصل الثاني" value={title} onChangeText={setTitle} />
            <Select label="النوع" options={[{ label: '📚 دراسة', value: 'study' }, { label: '🏖️ إجازة', value: 'vacation' }, { label: '📝 اختبار', value: 'exam' }, { label: '⭐ موعد مهم', value: 'important' }]} value={type} onChange={(v) => setType(v as StudyItem['type'])} />
            <Input label="التاريخ *" placeholder="YYYY-MM-DD" value={date} onChangeText={setDate} />
            <Input label="ملاحظات (اختياري)" placeholder="ملاحظات" value={notes} onChangeText={setNotes} />
            <Button title={editingItem ? 'حفظ' : 'إضافة'} onPress={handleSave} fullWidth />
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
  itemHeader: { flexDirection: 'row-reverse', justifyContent: 'space-between', alignItems: 'center', marginBottom: 8 },
  typeBadge: { paddingHorizontal: 8, paddingVertical: 4, borderRadius: 4 },
  typeBadgeText: { fontSize: THEME.fontSize.xs, fontWeight: THEME.fontWeight.medium },
  deleteBtn: { fontSize: 18, padding: 4 },
  itemTitle: { fontSize: THEME.fontSize.lg, fontWeight: THEME.fontWeight.bold, color: THEME.text, marginBottom: 4 },
  itemDate: { fontSize: THEME.fontSize.sm, color: THEME.textSecondary },
  itemNotes: { fontSize: THEME.fontSize.sm, color: THEME.textMuted, marginTop: 8, fontStyle: 'italic' },
  modalContainer: { flex: 1, backgroundColor: THEME.background },
  modalHeader: { flexDirection: 'row-reverse', justifyContent: 'space-between', alignItems: 'center', padding: THEME.spacing.md, backgroundColor: THEME.surface, borderBottomWidth: 1, borderBottomColor: THEME.border },
  modalTitle: { fontSize: THEME.fontSize.xl, fontWeight: THEME.fontWeight.bold, color: THEME.text },
  closeBtn: { fontSize: 24, color: THEME.textSecondary, padding: 8 },
  modalContent: { padding: THEME.spacing.md },
});

export default StudyScreen;