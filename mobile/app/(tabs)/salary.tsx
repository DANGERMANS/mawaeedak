/**
 * Salary Screen — Financial Management for Mawaeedak Mobile
 * 
 * Features:
 * - Salary tracking
 * - Support payments (حساب المواطن)
 * - Bills management
 * - Financial calendar
 * - Add/edit financial events
 */

import { useState } from 'react';
import { View, Text, StyleSheet, ScrollView, Pressable, TextInput, Modal, Alert } from 'react-native';
import { I18nManager } from 'react-native';
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

// Mock Data
const MOCK_SALARY = {
  company: 'شركة التقنية المتقدمة',
  amount: '12,000',
  currency: 'ر.س',
  nextPayment: '2026-06-25',
  daysRemaining: 16,
  paymentDay: 25,
};

const MOCK_SUPPORT = {
  amount: '2,000',
  currency: 'ر.س',
  nextPayment: '2026-06-10',
  daysRemaining: 1,
  status: 'approved',
};

const MOCK_BILLS = [
  { id: 1, name: 'فاتورة كهرباء', amount: '350', dueDate: '2026-06-12', daysRemaining: 3 },
  { id: 2, name: 'فاتورة ماء', amount: '120', dueDate: '2026-06-15', daysRemaining: 6 },
  { id: 3, name: 'إنترنت', amount: '200', dueDate: '2026-06-20', daysRemaining: 11 },
];

// Type definitions
type FinancialType = 'salary' | 'support' | 'bill' | 'investment';

interface FinancialItem {
  id: string;
  name: string;
  amount: string;
  date: string;
  type: FinancialType;
}

// Financial Card Component
function FinancialCard({ icon, title, amount, date, daysRemaining, color }: {
  icon: string;
  title: string;
  amount: string;
  date: string;
  daysRemaining: number;
  color: string;
}) {
  const getDaysLabel = () => {
    if (daysRemaining === 0) return 'اليوم';
    if (daysRemaining === 1) return 'غداً';
    return `${daysRemaining} يوم`;
  };

  const getDaysColor = () => {
    if (daysRemaining <= 2) return ERROR;
    if (daysRemaining <= 5) return GOLD;
    return SUCCESS;
  };

  return (
    <View style={styles.card}>
      <View style={[styles.cardIcon, { backgroundColor: color + '20' }]}>
        <Text style={{ fontSize: 28 }}>{icon}</Text>
      </View>
      <View style={styles.cardContent}>
        <Text style={styles.cardTitle}>{title}</Text>
        <View style={styles.cardDetails}>
          <Text style={styles.cardAmount}>{amount}</Text>
          <Text style={styles.cardDate}>{date}</Text>
        </View>
      </View>
      <View style={[styles.cardBadge, { backgroundColor: getDaysColor() + '20' }]}>
        <Text style={[styles.cardBadgeText, { color: getDaysColor() }]}>{getDaysLabel()}</Text>
      </View>
    </View>
  );
}

// Bill Item Component
function BillItem({ name, amount, dueDate, daysRemaining, onPress }: {
  name: string;
  amount: string;
  dueDate: string;
  daysRemaining: number;
  onPress: () => void;
}) {
  const getDaysColor = () => {
    if (daysRemaining <= 2) return ERROR;
    if (daysRemaining <= 5) return GOLD;
    return TEXT_SECONDARY;
  };

  return (
    <Pressable style={styles.billItem} onPress={onPress}>
      <View style={styles.billIcon}>
        <Feather name="file-text" size={20} color={BROWN} />
      </View>
      <View style={styles.billContent}>
        <Text style={styles.billName}>{name}</Text>
        <Text style={styles.billDue}>تاريخ الاستحقاق: {dueDate}</Text>
      </View>
      <View style={styles.billRight}>
        <Text style={styles.billAmount}>{amount}</Text>
        <Text style={[styles.billDays, { color: getDaysColor() }]}>
          {daysRemaining === 0 ? 'اليوم' : daysRemaining === 1 ? 'غداً' : `${daysRemaining} يوم`}
        </Text>
      </View>
    </Pressable>
  );
}

// Add Modal Component
function AddModal({ visible, onClose, onAdd, type }: {
  visible: boolean;
  onClose: () => void;
  onAdd: (item: FinancialItem) => void;
  type: FinancialType;
}) {
  const [name, setName] = useState('');
  const [amount, setAmount] = useState('');
  const [date, setDate] = useState('');

  const handleAdd = () => {
    if (!name || !amount || !date) {
      Alert.alert('خطأ', 'يرجى ملء جميع الحقول');
      return;
    }
    onAdd({ id: Date.now().toString(), name, amount, date, type });
    setName('');
    setAmount('');
    setDate('');
    onClose();
  };

  const getTypeLabel = () => {
    switch (type) {
      case 'salary': return 'راتب';
      case 'support': return 'دعم';
      case 'bill': return 'فاتورة';
      default: return 'نوع';
    }
  };

  return (
    <Modal visible={visible} animationType="slide" transparent>
      <View style={styles.modalOverlay}>
        <View style={styles.modalContent}>
          <View style={styles.modalHeader}>
            <Text style={styles.modalTitle}>إضافة {getTypeLabel()}</Text>
            <Pressable onPress={onClose}>
              <Feather name="x" size={24} color={INK} />
            </Pressable>
          </View>

          <View style={styles.modalBody}>
            <Text style={styles.inputLabel}>الاسم</Text>
            <TextInput
              style={styles.input}
              value={name}
              onChangeText={setName}
              placeholder="أدخل اسم الصنف"
              placeholderTextColor={TEXT_SECONDARY}
            />

            <Text style={styles.inputLabel}>المبلغ</Text>
            <TextInput
              style={styles.input}
              value={amount}
              onChangeText={setAmount}
              placeholder="أدخل المبلغ"
              keyboardType="numeric"
              placeholderTextColor={TEXT_SECONDARY}
            />

            <Text style={styles.inputLabel}>تاريخ الاستحقاق</Text>
            <TextInput
              style={styles.input}
              value={date}
              onChangeText={setDate}
              placeholder="YYYY-MM-DD"
              placeholderTextColor={TEXT_SECONDARY}
            />
          </View>

          <View style={styles.modalActions}>
            <Pressable style={styles.modalCancel} onPress={onClose}>
              <Text style={styles.modalCancelText}>إلغاء</Text>
            </Pressable>
            <Pressable style={styles.modalAdd} onPress={handleAdd}>
              <Text style={styles.modalAddText}>إضافة</Text>
            </Pressable>
          </View>
        </View>
      </View>
    </Modal>
  );
}

export default function SalaryScreen() {
  const [bills, setBills] = useState(MOCK_BILLS);
  const [showAddModal, setShowAddModal] = useState(false);
  const [addType, setAddType] = useState<FinancialType>('bill');

  const handleAddBill = (item: { id: string; name: string; amount: string; date: string; type: FinancialType }) => {
    setBills([...bills, { 
      id: parseInt(item.id) || Date.now(), 
      name: item.name, 
      amount: item.amount, 
      dueDate: item.date, 
      daysRemaining: Math.floor(Math.random() * 30) // Mock calculation
    }]);
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
          <Text style={styles.headerTitle}>المواعيد المالية</Text>
          <Pressable style={styles.addButton} onPress={() => { setAddType('bill'); setShowAddModal(true); }}>
            <Feather name="plus" size={20} color="#FFFFFF" />
            <Text style={styles.addButtonText}>إضافة</Text>
          </Pressable>
        </View>

        {/* Salary Card */}
        <View style={styles.salaryCard}>
          <View style={styles.salaryHeader}>
            <View style={[styles.salaryIcon, { backgroundColor: GOLD + '20' }]}>
              <Text style={{ fontSize: 32 }}>💰</Text>
            </View>
            <View style={styles.salaryInfo}>
              <Text style={styles.salaryLabel}>الراتب القادم</Text>
              <Text style={styles.salaryAmount}>{MOCK_SALARY.amount} {MOCK_SALARY.currency}</Text>
            </View>
          </View>
          <View style={styles.salaryDetails}>
            <View style={styles.salaryDetail}>
              <Text style={styles.salaryDetailLabel}>الشركة</Text>
              <Text style={styles.salaryDetailValue}>{MOCK_SALARY.company}</Text>
            </View>
            <View style={styles.salaryDetail}>
              <Text style={styles.salaryDetailLabel}>يوم الدفع</Text>
              <Text style={styles.salaryDetailValue}>يوم {MOCK_SALARY.paymentDay}</Text>
            </View>
            <View style={styles.salaryDetail}>
              <Text style={styles.salaryDetailLabel}>المتبقي</Text>
              <Text style={[styles.salaryDetailValue, { color: GOLD }]}>{MOCK_SALARY.daysRemaining} يوم</Text>
            </View>
          </View>
        </View>

        {/* Support Card */}
        <FinancialCard
          icon="🏠"
          title="حساب المواطن"
          amount={`${MOCK_SUPPORT.amount} ${MOCK_SUPPORT.currency}`}
          date="10 من كل شهر"
          daysRemaining={MOCK_SUPPORT.daysRemaining}
          color={SUCCESS}
        />

        {/* Bills Section */}
        <View style={styles.section}>
          <View style={styles.sectionHeader}>
            <Text style={styles.sectionTitle}>الفواتير</Text>
            <Pressable onPress={() => { setAddType('bill'); setShowAddModal(true); }}>
              <Feather name="plus-circle" size={24} color={GOLD} />
            </Pressable>
          </View>
          <View style={styles.billsList}>
            {bills.map((bill) => (
              <BillItem
                key={bill.id}
                name={bill.name}
                amount={`${bill.amount} ر.س`}
                dueDate={bill.dueDate}
                daysRemaining={bill.daysRemaining}
                onPress={() => Alert.alert(bill.name, `المبلغ: ${bill.amount} ر.س`)}
              />
            ))}
          </View>
        </View>

        {/* Summary */}
        <View style={styles.summary}>
          <Text style={styles.summaryTitle}>ملخص الشهر</Text>
          <View style={styles.summaryRow}>
            <Text style={styles.summaryLabel}>إجمالي المستحق</Text>
            <Text style={styles.summaryValue}>14,670 ر.س</Text>
          </View>
          <View style={styles.summaryRow}>
            <Text style={styles.summaryLabel}>المتبقي حتى الراتب</Text>
            <Text style={[styles.summaryValue, { color: GOLD }]}>16 يوم</Text>
          </View>
        </View>

        {/* Bottom padding */}
        <View style={{ height: 100 }} />
      </ScrollView>

      {/* Add Modal */}
      <AddModal
        visible={showAddModal}
        onClose={() => setShowAddModal(false)}
        onAdd={handleAddBill}
        type={addType}
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
    marginBottom: 20,
  },
  headerTitle: {
    fontSize: 28,
    fontWeight: '800',
    color: INK,
  },
  addButton: {
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: GOLD,
    paddingHorizontal: 16,
    paddingVertical: 10,
    borderRadius: 12,
    gap: 6,
  },
  addButtonText: {
    color: '#FFFFFF',
    fontSize: 14,
    fontWeight: '600',
  },
  salaryCard: {
    backgroundColor: CREAM,
    borderRadius: 20,
    padding: 20,
    marginBottom: 16,
    borderWidth: 1,
    borderColor: GOLD + '30',
  },
  salaryHeader: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 16,
  },
  salaryIcon: {
    width: 64,
    height: 64,
    borderRadius: 18,
    justifyContent: 'center',
    alignItems: 'center',
    marginRight: 16,
  },
  salaryInfo: {
    flex: 1,
  },
  salaryLabel: {
    fontSize: 14,
    color: TEXT_SECONDARY,
    marginBottom: 4,
  },
  salaryAmount: {
    fontSize: 32,
    fontWeight: '800',
    color: INK,
  },
  salaryDetails: {
    flexDirection: 'row',
    borderTopWidth: 1,
    borderTopColor: 'rgba(201,160,99,0.15)',
    paddingTop: 16,
    marginTop: 8,
  },
  salaryDetail: {
    flex: 1,
    alignItems: 'center',
  },
  salaryDetailLabel: {
    fontSize: 12,
    color: TEXT_SECONDARY,
    marginBottom: 4,
  },
  salaryDetailValue: {
    fontSize: 15,
    fontWeight: '600',
    color: INK,
  },
  card: {
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: CREAM,
    borderRadius: 16,
    padding: 16,
    marginBottom: 12,
    borderWidth: 1,
    borderColor: 'rgba(201,160,99,0.10)',
  },
  cardIcon: {
    width: 56,
    height: 56,
    borderRadius: 16,
    justifyContent: 'center',
    alignItems: 'center',
    marginRight: 14,
  },
  cardContent: {
    flex: 1,
  },
  cardTitle: {
    fontSize: 17,
    fontWeight: '700',
    color: INK,
    marginBottom: 4,
  },
  cardDetails: {
    flexDirection: 'row',
    gap: 12,
  },
  cardAmount: {
    fontSize: 14,
    color: TEXT_SECONDARY,
  },
  cardDate: {
    fontSize: 14,
    color: TEXT_SECONDARY,
  },
  cardBadge: {
    paddingHorizontal: 12,
    paddingVertical: 6,
    borderRadius: 8,
  },
  cardBadgeText: {
    fontSize: 13,
    fontWeight: '600',
  },
  section: {
    marginBottom: 20,
  },
  sectionHeader: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginBottom: 12,
  },
  sectionTitle: {
    fontSize: 18,
    fontWeight: '700',
    color: INK,
  },
  billsList: {
    gap: 10,
  },
  billItem: {
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: CREAM,
    borderRadius: 14,
    padding: 14,
    borderWidth: 1,
    borderColor: 'rgba(201,160,99,0.10)',
  },
  billIcon: {
    width: 40,
    height: 40,
    borderRadius: 10,
    backgroundColor: PAPER,
    justifyContent: 'center',
    alignItems: 'center',
    marginRight: 12,
  },
  billContent: {
    flex: 1,
  },
  billName: {
    fontSize: 15,
    fontWeight: '600',
    color: INK,
  },
  billDue: {
    fontSize: 12,
    color: TEXT_SECONDARY,
    marginTop: 2,
  },
  billRight: {
    alignItems: 'flex-end',
  },
  billAmount: {
    fontSize: 16,
    fontWeight: '700',
    color: INK,
  },
  billDays: {
    fontSize: 12,
    fontWeight: '600',
    marginTop: 2,
  },
  summary: {
    backgroundColor: CREAM,
    borderRadius: 16,
    padding: 20,
    borderWidth: 1,
    borderColor: 'rgba(201,160,99,0.15)',
  },
  summaryTitle: {
    fontSize: 16,
    fontWeight: '700',
    color: INK,
    marginBottom: 16,
  },
  summaryRow: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    marginBottom: 12,
  },
  summaryLabel: {
    fontSize: 14,
    color: TEXT_SECONDARY,
  },
  summaryValue: {
    fontSize: 16,
    fontWeight: '700',
    color: INK,
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
    paddingBottom: 40,
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
  modalActions: {
    flexDirection: 'row',
    paddingHorizontal: 20,
    gap: 12,
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