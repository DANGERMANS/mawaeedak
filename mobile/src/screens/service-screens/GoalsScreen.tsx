/**
 * Goals Screen — احسب هدفك
 * Full local functionality for goal tracking
 */

import React, { useState, useEffect } from 'react';
import { View, Text, StyleSheet, ScrollView, TouchableOpacity, Modal, Alert } from 'react-native';
import { THEME } from '../../constants/theme';
import { Card, EmptyState, SectionHeader } from '../../components/Card';
import { Button } from '../../components/Button';
import { Input } from '../../components/Input';
import { Select } from '../../components/Input';
import { goalsStorage } from '../../storage/LocalStorage';
import type { Goal } from '../../types/app';

export const GoalsScreen: React.FC = () => {
  const [goals, setGoals] = useState<Goal[]>([]);
  const [showAddModal, setShowAddModal] = useState(false);
  const [editingGoal, setEditingGoal] = useState<Goal | null>(null);
  const [newName, setNewName] = useState('');
  const [newType, setNewType] = useState<'financial' | 'other'>('financial');
  const [newTargetValue, setNewTargetValue] = useState('');
  const [newCurrentValue, setNewCurrentValue] = useState('');
  const [newDeadline, setNewDeadline] = useState('');

  useEffect(() => {
    loadGoals();
  }, []);

  const loadGoals = async () => {
    const data = await goalsStorage.getAll();
    setGoals(data);
  };

  const resetForm = () => {
    setNewName('');
    setNewType('financial');
    setNewTargetValue('');
    setNewCurrentValue('');
    setNewDeadline('');
    setEditingGoal(null);
  };

  const handleOpenAdd = () => {
    resetForm();
    setShowAddModal(true);
  };

  const handleOpenEdit = (goal: Goal) => {
    setEditingGoal(goal);
    setNewName(goal.name);
    setNewType(goal.type);
    setNewTargetValue(goal.targetValue?.toString() || '');
    setNewCurrentValue(goal.currentValue?.toString() || '');
    setNewDeadline(goal.deadline || '');
    setShowAddModal(true);
  };

  const handleSave = async () => {
    if (!newName.trim()) {
      Alert.alert('خطأ', 'الرجاء إدخال اسم الهدف');
      return;
    }

    const goalData = {
      name: newName.trim(),
      type: newType,
      targetValue: newType === 'financial' ? parseFloat(newTargetValue) || 0 : undefined,
      currentValue: newType === 'financial' ? parseFloat(newCurrentValue) || 0 : undefined,
      deadline: newDeadline || undefined,
      status: 'active' as const,
    };

    if (editingGoal) {
      await goalsStorage.update(editingGoal.id, goalData);
    } else {
      await goalsStorage.add(goalData);
    }

    await loadGoals();
    setShowAddModal(false);
    resetForm();
  };

  const handleDelete = (goal: Goal) => {
    Alert.alert('حذف الهدف', `هل أنت متأكد من حذف "${goal.name}"؟`, [
      { text: 'إلغاء', style: 'cancel' },
      { text: 'حذف', style: 'destructive', onPress: async () => { await goalsStorage.delete(goal.id); await loadGoals(); } },
    ]);
  };

  const calculateProgress = (goal: Goal) => {
    if (goal.type !== 'financial' || !goal.targetValue) return 0;
    return Math.min(100, ((goal.currentValue || 0) / goal.targetValue) * 100);
  };

  const calculateRequired = (goal: Goal, period: 'daily' | 'weekly' | 'monthly') => {
    if (goal.type !== 'financial' || !goal.targetValue || !goal.deadline) return null;
    const remaining = goal.targetValue - (goal.currentValue || 0);
    if (remaining <= 0) return 'تم!';
    const deadlineDate = new Date(goal.deadline);
    const today = new Date();
    const daysLeft = Math.max(1, Math.ceil((deadlineDate.getTime() - today.getTime()) / (1000 * 60 * 60 * 24)));
    const multiplier = period === 'daily' ? 1 : period === 'weekly' ? 7 : 30;
    return `${(remaining / (daysLeft / multiplier)).toFixed(0)}`;
  };

  return (
    <View style={styles.container}>
      <View style={styles.header}>
        <Text style={styles.title}>احسب هدفك 🎯</Text>
      </View>

      <ScrollView style={styles.content} contentContainerStyle={styles.contentInner}>
        <SectionHeader title="أهدافي" action={{ label: '+ إضافة', onPress: handleOpenAdd }} />

        {goals.length === 0 ? (
          <Card><EmptyState icon="🎯" title="لا توجد أهداف" description="أضف هدفك الأول" action={{ label: 'إضافة هدف', onPress: handleOpenAdd }} /></Card>
        ) : (
          goals.map((goal) => {
            const progress = calculateProgress(goal);
            return (
              <Card key={goal.id} onPress={() => handleOpenEdit(goal)}>
                <View style={styles.goalHeader}>
                  <Text style={styles.goalName}>{goal.name}</Text>
                  <TouchableOpacity onPress={() => handleDelete(goal)}><Text style={styles.deleteBtn}>🗑️</Text></TouchableOpacity>
                </View>
                <Text style={styles.goalType}>{goal.type === 'financial' ? '💰 مالي' : '📌 غير مالي'}</Text>
                {goal.type === 'financial' && goal.targetValue ? (
                  <>
                    <View style={styles.progressBar}><View style={[styles.progressFill, { width: `${progress}%` }]} /></View>
                    <View style={styles.progressInfo}>
                      <Text style={styles.progressText}>{goal.currentValue || 0} / {goal.targetValue}</Text>
                      <Text style={styles.progressPercent}>{progress.toFixed(0)}%</Text>
                    </View>
                    <View style={styles.requiredRow}>
                      <Text style={styles.requiredLabel}>يومياً:</Text>
                      <Text style={styles.requiredValue}>{calculateRequired(goal, 'daily')}</Text>
                    </View>
                    <View style={styles.requiredRow}>
                      <Text style={styles.requiredLabel}>أسبوعياً:</Text>
                      <Text style={styles.requiredValue}>{calculateRequired(goal, 'weekly')}</Text>
                    </View>
                    <View style={styles.requiredRow}>
                      <Text style={styles.requiredLabel}>شهرياً:</Text>
                      <Text style={styles.requiredValue}>{calculateRequired(goal, 'monthly')}</Text>
                    </View>
                    {goal.deadline && <Text style={styles.deadline}>📅 {goal.deadline}</Text>}
                  </>
                ) : null}
              </Card>
            );
          })
        )}
      </ScrollView>

      <Modal visible={showAddModal} animationType="slide" presentationStyle="pageSheet">
        <View style={styles.modalContainer}>
          <View style={styles.modalHeader}>
            <Text style={styles.modalTitle}>{editingGoal ? 'تعديل الهدف' : 'إضافة هدف'}</Text>
            <TouchableOpacity onPress={() => { setShowAddModal(false); resetForm(); }}><Text style={styles.closeBtn}>✕</Text></TouchableOpacity>
          </View>
          <ScrollView style={styles.modalContent}>
            <Input label="اسم الهدف" placeholder="مثال: شراء سيارة" value={newName} onChangeText={setNewName} />
            <Select label="النوع" options={[{ label: '💰 مالي', value: 'financial' }, { label: '📌 غير مالي', value: 'other' }]} value={newType} onChange={(v) => setNewType(v as 'financial' | 'other')} />
            {newType === 'financial' && (
              <>
                <Input label="المبلغ المستهدف" placeholder="50000" value={newTargetValue} onChangeText={setNewTargetValue} keyboardType="numeric" />
                <Input label="المبلغ الحالي" placeholder="10000" value={newCurrentValue} onChangeText={setNewCurrentValue} keyboardType="numeric" />
              </>
            )}
            <Input label="الموعد النهائي" placeholder="YYYY-MM-DD" value={newDeadline} onChangeText={setNewDeadline} />
            <Button title={editingGoal ? 'حفظ' : 'إضافة'} onPress={handleSave} fullWidth />
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
  goalHeader: { flexDirection: 'row-reverse', justifyContent: 'space-between', alignItems: 'center', marginBottom: 8 },
  goalName: { fontSize: THEME.fontSize.lg, fontWeight: THEME.fontWeight.bold, color: THEME.text },
  deleteBtn: { fontSize: 18, padding: 4 },
  goalType: { fontSize: THEME.fontSize.sm, color: THEME.textSecondary, marginBottom: 12 },
  progressBar: { height: 8, backgroundColor: THEME.border, borderRadius: 4, marginBottom: 8 },
  progressFill: { height: '100%', backgroundColor: THEME.primary, borderRadius: 4 },
  progressInfo: { flexDirection: 'row-reverse', justifyContent: 'space-between', marginBottom: 8 },
  progressText: { fontSize: THEME.fontSize.sm, color: THEME.textSecondary },
  progressPercent: { fontSize: THEME.fontSize.sm, fontWeight: THEME.fontWeight.bold, color: THEME.primary },
  requiredRow: { flexDirection: 'row-reverse', justifyContent: 'space-between', marginBottom: 4 },
  requiredLabel: { fontSize: THEME.fontSize.sm, color: THEME.textSecondary },
  requiredValue: { fontSize: THEME.fontSize.sm, fontWeight: THEME.fontWeight.medium, color: THEME.primary },
  deadline: { fontSize: THEME.fontSize.sm, color: THEME.textSecondary, marginTop: 8 },
  modalContainer: { flex: 1, backgroundColor: THEME.background },
  modalHeader: { flexDirection: 'row-reverse', justifyContent: 'space-between', alignItems: 'center', padding: THEME.spacing.md, backgroundColor: THEME.surface, borderBottomWidth: 1, borderBottomColor: THEME.border },
  modalTitle: { fontSize: THEME.fontSize.xl, fontWeight: THEME.fontWeight.bold, color: THEME.text },
  closeBtn: { fontSize: 24, color: THEME.textSecondary, padding: 8 },
  modalContent: { padding: THEME.spacing.md },
});

export default GoalsScreen;