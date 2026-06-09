/**
 * Costs Screen — حساب التكاليف
 * Full local functionality for cost tracking
 */

import React, { useState, useEffect } from 'react';
import { View, Text, StyleSheet, ScrollView, TouchableOpacity, Modal, Alert } from 'react-native';
import { THEME } from '../../constants/theme';
import { Card, EmptyState, SectionHeader } from '../../components/Card';
import { Button } from '../../components/Button';
import { Input } from '../../components/Input';
import { Select } from '../../components/Input';
import { costProjectsStorage, costItemsStorage } from '../../storage/LocalStorage';
import type { CostProject, CostItem } from '../../types/app';

const toSafeAmount = (value: number | undefined, max: number) => {
  const amount = Number.isFinite(value ?? NaN) ? Number(value) : 0;
  return Math.max(0, Math.min(amount, max));
};

const getPaidAmountForItem = (item: CostItem) => {
  if (item.status === 'paid') return item.cost;
  if (item.status === 'partial') return toSafeAmount(item.paidAmount, item.cost);
  return 0;
};

export const CostsScreen: React.FC = () => {
  const [projects, setProjects] = useState<CostProject[]>([]);
  const [items, setItems] = useState<CostItem[]>([]);
  const [selectedProject, setSelectedProject] = useState<CostProject | null>(null);
  const [showProjectModal, setShowProjectModal] = useState(false);
  const [showItemModal, setShowItemModal] = useState(false);
  const [editingProject, setEditingProject] = useState<CostProject | null>(null);
  const [editingItem, setEditingItem] = useState<CostItem | null>(null);
  
  const [projectName, setProjectName] = useState('');
  const [itemName, setItemName] = useState('');
  const [itemCost, setItemCost] = useState('');
  const [itemStatus, setItemStatus] = useState<CostItem['status']>('unpaid');
  const [itemPaidAmount, setItemPaidAmount] = useState('');
  const [itemDueDate, setItemDueDate] = useState('');

  useEffect(() => { loadData(); }, []);

  const loadData = async () => {
    const [projectsData, itemsData] = await Promise.all([
      costProjectsStorage.getAll(),
      costItemsStorage.getAll(),
    ]);
    setProjects(projectsData);
    setItems(itemsData);
  };

  const getProjectItems = (projectId: string) => items.filter(i => i.projectId === projectId);
  const getProjectTotal = (projectId: string) => getProjectItems(projectId).reduce((sum, i) => sum + i.cost, 0);
  const getProjectPaid = (projectId: string) => getProjectItems(projectId).reduce((sum, item) => sum + getPaidAmountForItem(item), 0);
  const getProjectRemaining = (projectId: string) => Math.max(0, getProjectTotal(projectId) - getProjectPaid(projectId));

  const resetProjectForm = () => { setProjectName(''); setEditingProject(null); };
  const resetItemForm = () => { setItemName(''); setItemCost(''); setItemStatus('unpaid'); setItemPaidAmount(''); setItemDueDate(''); setEditingItem(null); };

  const handleSaveProject = async () => {
    if (!projectName.trim()) { Alert.alert('خطأ', 'الرجاء إدخال اسم المشروع'); return; }
    if (editingProject) {
      await costProjectsStorage.update(editingProject.id, { name: projectName.trim() });
    } else {
      await costProjectsStorage.add(projectName.trim());
    }
    await loadData();
    setShowProjectModal(false);
    resetProjectForm();
  };

  const handleDeleteProject = (project: CostProject) => {
    Alert.alert('حذف المشروع', `هل أنت متأكد من حذف "${project.name}"؟`, [
      { text: 'إلغاء', style: 'cancel' },
      { text: 'حذف', style: 'destructive', onPress: async () => { await costProjectsStorage.delete(project.id); await loadData(); if (selectedProject?.id === project.id) setSelectedProject(null); } },
    ]);
  };

  const handleSaveItem = async () => {
    if (!itemName.trim() || !selectedProject) { Alert.alert('خطأ', 'الرجاء إدخال اسم البند'); return; }
    const cost = parseFloat(itemCost) || 0;
    const requestedPaidAmount = parseFloat(itemPaidAmount) || 0;
    const safePaidAmount = itemStatus === 'paid' ? cost : itemStatus === 'partial' ? toSafeAmount(requestedPaidAmount, cost) : undefined;
    const itemData = {
      projectId: selectedProject.id,
      name: itemName.trim(),
      cost,
      status: itemStatus,
      paidAmount: safePaidAmount,
      paidAt: itemStatus === 'paid' ? new Date().toISOString() : undefined,
      dueDate: itemDueDate || undefined,
    };
    if (editingItem) {
      await costItemsStorage.update(editingItem.id, itemData);
    } else {
      await costItemsStorage.add(itemData);
    }
    await loadData();
    setShowItemModal(false);
    resetItemForm();
  };

  const handleDeleteItem = async (item: CostItem) => {
    await costItemsStorage.delete(item.id);
    await loadData();
  };

  const handleOpenEditItem = (item: CostItem) => {
    setEditingItem(item);
    setItemName(item.name);
    setItemCost(String(item.cost));
    setItemStatus(item.status);
    setItemPaidAmount(item.paidAmount ? String(item.paidAmount) : '');
    setItemDueDate(item.dueDate || '');
    setShowItemModal(true);
  };

  const handleMarkPaid = (item: CostItem) => {
    Alert.alert('تحديد كمدفوع', `هل تخصم ${item.cost} من المتبقي؟`, [
      { text: 'إلغاء', style: 'cancel' },
      { text: 'نعم', onPress: async () => { await costItemsStorage.update(item.id, { status: 'paid', paidAmount: item.cost, paidAt: new Date().toISOString() }); await loadData(); } },
    ]);
  };

  return (
    <View style={styles.container}>
      <View style={styles.header}>
        <Text style={styles.title}>حساب التكاليف 🧮</Text>
      </View>

      <ScrollView style={styles.content} contentContainerStyle={styles.contentInner}>
        <SectionHeader title="مشاريعي" action={{ label: '+ مشروع جديد', onPress: () => { resetProjectForm(); setShowProjectModal(true); } }} />

        {projects.length === 0 ? (
          <Card><EmptyState icon="🧮" title="لا توجد مشاريع" description="أنشئ مشروع تكلفة جديد" action={{ label: 'إنشاء مشروع', onPress: () => { resetProjectForm(); setShowProjectModal(true); } }} /></Card>
        ) : (
          projects.map((project) => {
            const projectItems = getProjectItems(project.id);
            const total = getProjectTotal(project.id);
            const paid = getProjectPaid(project.id);
            const remaining = getProjectRemaining(project.id);
            const isExpanded = selectedProject?.id === project.id;
            return (
              <Card key={project.id}>
                <TouchableOpacity onPress={() => setSelectedProject(isExpanded ? null : project)}>
                  <View style={styles.projectHeader}>
                    <View style={styles.projectInfo}>
                      <Text style={styles.projectName}>{project.name}</Text>
                      <View style={styles.projectStats}>
                        <Text style={styles.statText}>الإجمالي: <Text style={styles.statValue}>{total.toLocaleString()}</Text></Text>
                        <Text style={styles.statText}>المدفوع: <Text style={styles.statSuccess}>{paid.toLocaleString()}</Text></Text>
                        <Text style={styles.statText}>المتبقي: <Text style={styles.statRemaining}>{remaining.toLocaleString()}</Text></Text>
                      </View>
                    </View>
                    <View style={styles.projectActions}>
                      <TouchableOpacity onPress={(e) => { e.stopPropagation(); setSelectedProject(project); resetItemForm(); setShowItemModal(true); }}><Text style={styles.actionBtn}>+ بند</Text></TouchableOpacity>
                      <TouchableOpacity onPress={(e) => { e.stopPropagation(); setEditingProject(project); setProjectName(project.name); setShowProjectModal(true); }}><Text style={styles.actionBtn}>✏️</Text></TouchableOpacity>
                      <TouchableOpacity onPress={(e) => { e.stopPropagation(); handleDeleteProject(project); }}><Text style={styles.actionBtn}>🗑️</Text></TouchableOpacity>
                    </View>
                  </View>
                </TouchableOpacity>

                {isExpanded && projectItems.length > 0 && (
                  <View style={styles.itemsList}>
                    {projectItems.map((item) => {
                      const itemPaidAmount = getPaidAmountForItem(item);
                      const itemRemaining = Math.max(0, item.cost - itemPaidAmount);
                      return (
                        <View key={item.id} style={[styles.itemRow, item.status === 'paid' && styles.itemPaid]}>
                          <View style={styles.itemInfo}>
                            <Text style={[styles.itemName, item.status === 'paid' && styles.itemNamePaid]}>{item.name}</Text>
                            <Text style={styles.itemCost}>{item.cost.toLocaleString()} ر.س</Text>
                            {item.status === 'partial' && <Text style={styles.itemSubText}>مدفوع: {itemPaidAmount.toLocaleString()} | متبقي: {itemRemaining.toLocaleString()}</Text>}
                          </View>
                          <View style={styles.itemStatus}>
                            <Text style={[styles.statusBadge, styles[`status_${item.status}`]]}>
                              {item.status === 'unpaid' ? 'غير مدفوع' : item.status === 'partial' ? 'جزئي' : item.status === 'paid' ? '✓ مدفوع' : 'مجدول'}
                            </Text>
                          </View>
                          <View style={styles.itemActions}>
                            <TouchableOpacity onPress={() => handleOpenEditItem(item)}><Text style={styles.actionBtn}>✏️</Text></TouchableOpacity>
                            {item.status !== 'paid' && <TouchableOpacity onPress={() => handleMarkPaid(item)}><Text style={styles.actionBtn}>✓</Text></TouchableOpacity>}
                            <TouchableOpacity onPress={() => handleDeleteItem(item)}><Text style={styles.actionBtn}>🗑️</Text></TouchableOpacity>
                          </View>
                        </View>
                      );
                    })}
                  </View>
                )}
              </Card>
            );
          })
        )}
      </ScrollView>

      <Modal visible={showProjectModal} animationType="slide" presentationStyle="pageSheet">
        <View style={styles.modalContainer}>
          <View style={styles.modalHeader}>
            <Text style={styles.modalTitle}>{editingProject ? 'تعديل المشروع' : 'مشروع جديد'}</Text>
            <TouchableOpacity onPress={() => { setShowProjectModal(false); resetProjectForm(); }}><Text style={styles.closeBtn}>✕</Text></TouchableOpacity>
          </View>
          <View style={styles.modalContent}>
            <Input label="اسم المشروع" placeholder="مثال: تكاليف الزواج" value={projectName} onChangeText={setProjectName} />
            <Button title={editingProject ? 'حفظ' : 'إنشاء'} onPress={handleSaveProject} fullWidth />
          </View>
        </View>
      </Modal>

      <Modal visible={showItemModal} animationType="slide" presentationStyle="pageSheet">
        <View style={styles.modalContainer}>
          <View style={styles.modalHeader}>
            <Text style={styles.modalTitle}>{editingItem ? 'تعديل البند' : 'بند جديد'}</Text>
            <TouchableOpacity onPress={() => { setShowItemModal(false); resetItemForm(); }}><Text style={styles.closeBtn}>✕</Text></TouchableOpacity>
          </View>
          <ScrollView style={styles.modalContent}>
            <Input label="اسم البند" placeholder="مثال: العربية" value={itemName} onChangeText={setItemName} />
            <Input label="التكلفة" placeholder="10000" value={itemCost} onChangeText={setItemCost} keyboardType="numeric" />
            <Select label="حالة الدفع" options={[{ label: '❌ غير مدفوع', value: 'unpaid' }, { label: '🔄 جزئي', value: 'partial' }, { label: '✓ مكتمل', value: 'paid' }, { label: '📅 مجدول', value: 'scheduled' }]} value={itemStatus} onChange={(v) => setItemStatus(v as CostItem['status'])} />
            {itemStatus === 'partial' && <Input label="المدفوع جزئياً" placeholder="5000" value={itemPaidAmount} onChangeText={setItemPaidAmount} keyboardType="numeric" />}
            <Input label="تاريخ الاستحقاق (اختياري)" placeholder="YYYY-MM-DD" value={itemDueDate} onChangeText={setItemDueDate} />
            <Button title={editingItem ? 'حفظ' : 'إضافة'} onPress={handleSaveItem} fullWidth />
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
  projectHeader: { flexDirection: 'row-reverse', justifyContent: 'space-between', alignItems: 'flex-start' },
  projectInfo: { flex: 1 },
  projectName: { fontSize: THEME.fontSize.lg, fontWeight: THEME.fontWeight.bold, color: THEME.text, marginBottom: 8 },
  projectStats: { gap: 4 },
  statText: { fontSize: THEME.fontSize.sm, color: THEME.textSecondary },
  statValue: { fontWeight: THEME.fontWeight.bold, color: THEME.text },
  statSuccess: { fontWeight: THEME.fontWeight.bold, color: THEME.success },
  statRemaining: { fontWeight: THEME.fontWeight.bold, color: THEME.error },
  projectActions: { flexDirection: 'row', gap: 8 },
  actionBtn: { fontSize: 16, padding: 4, color: THEME.primary },
  itemsList: { marginTop: 16, borderTopWidth: 1, borderTopColor: THEME.border, paddingTop: 12 },
  itemRow: { flexDirection: 'row-reverse', alignItems: 'center', paddingVertical: 8, borderBottomWidth: 1, borderBottomColor: THEME.borderLight },
  itemPaid: { opacity: 0.6 },
  itemInfo: { flex: 1 },
  itemName: { fontSize: THEME.fontSize.md, color: THEME.text },
  itemNamePaid: { textDecorationLine: 'line-through' },
  itemCost: { fontSize: THEME.fontSize.sm, color: THEME.textSecondary, marginTop: 2 },
  itemSubText: { fontSize: THEME.fontSize.xs, color: THEME.textMuted, marginTop: 2 },
  itemStatus: { marginHorizontal: 8 },
  statusBadge: { fontSize: THEME.fontSize.xs, paddingHorizontal: 6, paddingVertical: 2, borderRadius: 4 },
  status_unpaid: { backgroundColor: THEME.error + '20', color: THEME.error },
  status_partial: { backgroundColor: THEME.warning + '20', color: THEME.warning },
  status_paid: { backgroundColor: THEME.success + '20', color: THEME.success },
  status_scheduled: { backgroundColor: THEME.info + '20', color: THEME.info },
  itemActions: { flexDirection: 'row', gap: 8 },
  modalContainer: { flex: 1, backgroundColor: THEME.background },
  modalHeader: { flexDirection: 'row-reverse', justifyContent: 'space-between', alignItems: 'center', padding: THEME.spacing.md, backgroundColor: THEME.surface, borderBottomWidth: 1, borderBottomColor: THEME.border },
  modalTitle: { fontSize: THEME.fontSize.xl, fontWeight: THEME.fontWeight.bold, color: THEME.text },
  closeBtn: { fontSize: 24, color: THEME.textSecondary, padding: 8 },
  modalContent: { padding: THEME.spacing.md },
});

export default CostsScreen;
