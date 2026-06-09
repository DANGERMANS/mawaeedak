/**
 * Feedback Screen — صوتك مسموع
 * Local feedback/suggestion storage
 */

import React, { useState, useEffect } from 'react';
import { View, Text, StyleSheet, ScrollView, TouchableOpacity, Modal, Alert } from 'react-native';
import { THEME } from '../../constants/theme';
import { Card, EmptyState, SectionHeader, PendingBanner } from '../../components/Card';
import { Button } from '../../components/Button';
import { Input } from '../../components/Input';
import { Select } from '../../components/Input';
import AsyncStorage from '@react-native-async-storage/async-storage';

type FeedbackItem = {
  id: string;
  type: 'suggestion' | 'complaint' | 'note' | 'support';
  title: string;
  content: string;
  status: 'saved' | 'pending' | 'sent';
  createdAt: string;
};

const STORAGE_KEY = 'mawaeedak_feedback';

export const FeedbackScreen: React.FC = () => {
  const [items, setItems] = useState<FeedbackItem[]>([]);
  const [showModal, setShowModal] = useState(false);
  const [editingItem, setEditingItem] = useState<FeedbackItem | null>(null);

  const [type, setType] = useState<FeedbackItem['type']>('suggestion');
  const [title, setTitle] = useState('');
  const [content, setContent] = useState('');

  useEffect(() => { loadItems(); }, []);

  const loadItems = async () => {
    const data = await AsyncStorage.getItem(STORAGE_KEY);
    if (data) setItems(JSON.parse(data));
  };

  const saveItems = async (newItems: FeedbackItem[]) => {
    await AsyncStorage.setItem(STORAGE_KEY, JSON.stringify(newItems));
    setItems(newItems);
  };

  const resetForm = () => { setType('suggestion'); setTitle(''); setContent(''); setEditingItem(null); };

  const handleOpenAdd = () => { resetForm(); setShowModal(true); };

  const handleOpenEdit = (item: FeedbackItem) => {
    setEditingItem(item);
    setType(item.type);
    setTitle(item.title);
    setContent(item.content);
    setShowModal(true);
  };

  const handleSave = async () => {
    if (!title.trim() || !content.trim()) { Alert.alert('خطأ', 'الرجاء ملء العنوان والمحتوى'); return; }

    const newItem: FeedbackItem = {
      id: editingItem?.id || `feedback_${Date.now()}`,
      type,
      title: title.trim(),
      content: content.trim(),
      status: 'saved',
      createdAt: editingItem?.createdAt || new Date().toISOString(),
    };

    let newItems: FeedbackItem[];
    if (editingItem) {
      newItems = items.map(i => i.id === editingItem.id ? newItem : i);
    } else {
      newItems = [newItem, ...items];
    }

    await saveItems(newItems);
    setShowModal(false);
    resetForm();
  };

  const handleDelete = (item: FeedbackItem) => {
    Alert.alert('حذف', `هل أنت متأكد من حذف "${item.title}"؟`, [
      { text: 'إلغاء', style: 'cancel' },
      { text: 'حذف', style: 'destructive', onPress: async () => { await saveItems(items.filter(i => i.id !== item.id)); } },
    ]);
  };

  const getTypeLabel = (t: string) => {
    switch (t) {
      case 'suggestion': return '💡 اقتراح';
      case 'complaint': return '📝 شكوى';
      case 'note': return '📋 ملاحظة';
      case 'support': return '🤝 دعم';
      default: return t;
    }
  };

  const getTypeColor = (t: string) => {
    switch (t) {
      case 'suggestion': return THEME.primary;
      case 'complaint': return THEME.error;
      case 'note': return THEME.info;
      case 'support': return THEME.success;
      default: return THEME.text;
    }
  };

  const sortedItems = [...items].sort((a, b) => new Date(b.createdAt).getTime() - new Date(a.createdAt).getTime());

  return (
    <View style={styles.container}>
      <View style={styles.header}>
        <Text style={styles.title}>صوتك مسموع 📝</Text>
      </View>

      <ScrollView style={styles.content} contentContainerStyle={styles.contentInner}>
        <PendingBanner message="بانتظار الربط للإرسال الرسمي" />

        <SectionHeader title="رسائلي" action={{ label: '+ جديد', onPress: handleOpenAdd }} />

        {sortedItems.length === 0 ? (
          <Card><EmptyState icon="📝" title="لا توجد رسائل" description="أرسل اقتراحاً أو ملاحظة" action={{ label: 'كتابة رسالة', onPress: handleOpenAdd }} /></Card>
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
              <Text style={styles.itemContent} numberOfLines={2}>{item.content}</Text>
              <View style={styles.itemFooter}>
                <Text style={styles.itemDate}>{new Date(item.createdAt).toLocaleDateString('ar-SA')}</Text>
                <Text style={[styles.itemStatus, item.status === 'sent' && styles.itemStatusSent]}>
                  {item.status === 'sent' ? '✓ تم الإرسال' : item.status === 'pending' ? '⏳ بانتظار' : '💾 محفوظ محلياً'}
                </Text>
              </View>
            </Card>
          ))
        )}
      </ScrollView>

      <Modal visible={showModal} animationType="slide" presentationStyle="pageSheet">
        <View style={styles.modalContainer}>
          <View style={styles.modalHeader}>
            <Text style={styles.modalTitle}>{editingItem ? 'تعديل الرسالة' : 'رسالة جديدة'}</Text>
            <TouchableOpacity onPress={() => { setShowModal(false); resetForm(); }}><Text style={styles.closeBtn}>✕</Text></TouchableOpacity>
          </View>
          <ScrollView style={styles.modalContent}>
            <Select
              label="نوع الرسالة"
              options={[
                { label: '💡 اقتراح', value: 'suggestion' },
                { label: '📝 شكوى', value: 'complaint' },
                { label: '📋 ملاحظة', value: 'note' },
                { label: '🤝 دعم', value: 'support' },
              ]}
              value={type}
              onChange={(v) => setType(v as FeedbackItem['type'])}
            />
            <Input label="العنوان *" placeholder="عنوان قصير" value={title} onChangeText={setTitle} />
            <Input label="المحتوى *" placeholder="اكتب رسالتك هنا..." value={content} onChangeText={setContent} multiline />
            <View style={styles.warningBox}>
              <Text style={styles.warningText}>⚠️ هذه الرسالة محفوظة محلياً فقط.{'\n'}سيتم إرسالها للخادم عند توفر الربط.</Text>
            </View>
            <Button title={editingItem ? 'حفظ التعديلات' : 'حفظ محلياً'} onPress={handleSave} fullWidth />
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
  itemTitle: { fontSize: THEME.fontSize.md, fontWeight: THEME.fontWeight.semibold, color: THEME.text, marginBottom: 4 },
  itemContent: { fontSize: THEME.fontSize.sm, color: THEME.textSecondary, lineHeight: 20 },
  itemFooter: { flexDirection: 'row-reverse', justifyContent: 'space-between', alignItems: 'center', marginTop: 12, paddingTop: 12, borderTopWidth: 1, borderTopColor: THEME.borderLight },
  itemDate: { fontSize: THEME.fontSize.xs, color: THEME.textMuted },
  itemStatus: { fontSize: THEME.fontSize.xs, color: THEME.textSecondary },
  itemStatusSent: { color: THEME.success },
  modalContainer: { flex: 1, backgroundColor: THEME.background },
  modalHeader: { flexDirection: 'row-reverse', justifyContent: 'space-between', alignItems: 'center', padding: THEME.spacing.md, backgroundColor: THEME.surface, borderBottomWidth: 1, borderBottomColor: THEME.border },
  modalTitle: { fontSize: THEME.fontSize.xl, fontWeight: THEME.fontWeight.bold, color: THEME.text },
  closeBtn: { fontSize: 24, color: THEME.textSecondary, padding: 8 },
  modalContent: { padding: THEME.spacing.md },
  warningBox: { backgroundColor: THEME.warning + '15', padding: 12, borderRadius: 8, marginBottom: 16 },
  warningText: { fontSize: THEME.fontSize.sm, color: THEME.warning, lineHeight: 20 },
});

export default FeedbackScreen;