/**
 * Travel Screen — السفر
 * Full local functionality for trip management
 */

import React, { useState, useEffect } from 'react';
import { View, Text, StyleSheet, ScrollView, TouchableOpacity, Modal, Alert } from 'react-native';
import { THEME } from '../../constants/theme';
import { Card, EmptyState, SectionHeader } from '../../components/Card';
import { Button } from '../../components/Button';
import { Input } from '../../components/Input';
import { tripsStorage } from '../../storage/LocalStorage';
import type { Trip, TravelCheckItem } from '../../types/app';

export const TravelScreen: React.FC = () => {
  const [trips, setTrips] = useState<Trip[]>([]);
  const [showModal, setShowModal] = useState(false);
  const [editingTrip, setEditingTrip] = useState<Trip | null>(null);
  const [selectedTrip, setSelectedTrip] = useState<Trip | null>(null);

  // Form states
  const [tripName, setTripName] = useState('');
  const [destination, setDestination] = useState('');
  const [departureDate, setDepartureDate] = useState('');
  const [returnDate, setReturnDate] = useState('');
  const [notes, setNotes] = useState('');
  const [newDocument, setNewDocument] = useState('');
  const [documents, setDocuments] = useState<string[]>([]);

  useEffect(() => { loadTrips(); }, []);

  const loadTrips = async () => {
    const data = await tripsStorage.getAll();
    setTrips(data);
  };

  const resetForm = () => {
    setTripName(''); setDestination(''); setDepartureDate(''); setReturnDate(''); setNotes('');
    setNewDocument(''); setDocuments([]);
    setEditingTrip(null);
  };

  const handleOpenAdd = () => { resetForm(); setShowModal(true); };

  const handleOpenEdit = (trip: Trip) => {
    setEditingTrip(trip);
    setTripName(trip.name);
    setDestination(trip.destination);
    setDepartureDate(trip.date);
    setReturnDate(trip.documents.find(d => d.includes('عودة')) || '');
    setNotes(trip.documents.filter(d => !d.includes('ذهاب') && !d.includes('عودة')).join('\n'));
    setDocuments(trip.documents);
    setShowModal(true);
  };

  const handleSave = async () => {
    if (!tripName.trim() || !destination || !departureDate) { Alert.alert('خطأ', 'الرجاء ملء الحقول المطلوبة'); return; }
    
    const tripData = {
      name: tripName.trim(),
      destination,
      date: departureDate,
      documents: [...documents, returnDate].filter(Boolean),
      checklist: editingTrip?.checklist || [],
      reminders: [],
    };

    if (editingTrip) {
      await tripsStorage.update(editingTrip.id, tripData);
    } else {
      await tripsStorage.add(tripData);
    }

    await loadTrips();
    setShowModal(false);
    resetForm();
  };

  const handleDelete = (trip: Trip) => {
    Alert.alert('حذف الرحلة', `هل أنت متأكد من حذف "${trip.name}"؟`, [
      { text: 'إلغاء', style: 'cancel' },
      { text: 'حذف', style: 'destructive', onPress: async () => { await tripsStorage.delete(trip.id); await loadTrips(); } },
    ]);
  };

  const toggleCheckItem = async (trip: Trip, itemId: string) => {
    const updatedChecklist = trip.checklist.map(item => 
      item.id === itemId ? { ...item, checked: !item.checked } : item
    );
    await tripsStorage.update(trip.id, { checklist: updatedChecklist });
    await loadTrips();
    if (selectedTrip?.id === trip.id) setSelectedTrip(updatedChecklist ? { ...trip, checklist: updatedChecklist } : null);
  };

  const addCheckItem = async (trip: Trip) => {
    Alert.prompt('إضافة مهمة', 'أدخل اسم المهمة:', async (name) => {
      if (name?.trim()) {
        const newItem: TravelCheckItem = { id: `check_${Date.now()}`, name: name.trim(), checked: false };
        await tripsStorage.update(trip.id, { checklist: [...trip.checklist, newItem] });
        await loadTrips();
      }
    });
  };

  const deleteCheckItem = async (trip: Trip, itemId: string) => {
    await tripsStorage.update(trip.id, { checklist: trip.checklist.filter(i => i.id !== itemId) });
    await loadTrips();
  };

  const formatDate = (dateStr: string) => {
    try { return new Date(dateStr).toLocaleDateString('ar-SA', { year: 'numeric', month: 'long', day: 'numeric' }); }
    catch { return dateStr; }
  };

  return (
    <View style={styles.container}>
      <View style={styles.header}>
        <Text style={styles.title}>السفر ✈️</Text>
      </View>

      <ScrollView style={styles.content} contentContainerStyle={styles.contentInner}>
        <SectionHeader title="رحلاتي" action={{ label: '+ رحلة جديدة', onPress: handleOpenAdd }} />

        {trips.length === 0 ? (
          <Card><EmptyState icon="✈️" title="لا توجد رحلات" description="أضف رحلتك الأولى" action={{ label: 'إضافة رحلة', onPress: handleOpenAdd }} /></Card>
        ) : (
          trips.map((trip) => (
            <Card key={trip.id}>
              <TouchableOpacity onPress={() => setSelectedTrip(selectedTrip?.id === trip.id ? null : trip)}>
                <View style={styles.tripHeader}>
                  <View style={styles.tripInfo}>
                    <Text style={styles.tripName}>{trip.name}</Text>
                    <Text style={styles.tripDestination}>📍 {trip.destination}</Text>
                    <Text style={styles.tripDate}>📅 {formatDate(trip.date)}</Text>
                  </View>
                  <View style={styles.tripActions}>
                    <TouchableOpacity onPress={(e) => { e.stopPropagation(); handleOpenEdit(trip); }}><Text style={styles.actionBtn}>✏️</Text></TouchableOpacity>
                    <TouchableOpacity onPress={(e) => { e.stopPropagation(); handleDelete(trip); }}><Text style={styles.actionBtn}>🗑️</Text></TouchableOpacity>
                  </View>
                </View>
              </TouchableOpacity>

              {selectedTrip?.id === trip.id && (
                <View style={styles.expandedSection}>
                  {/* Checklist */}
                  <View style={styles.checklistSection}>
                    <View style={styles.checklistHeader}>
                      <Text style={styles.sectionTitle}>✅ قائمة المهام</Text>
                      <TouchableOpacity onPress={() => addCheckItem(trip)}><Text style={styles.addBtn}>+ إضافة</Text></TouchableOpacity>
                    </View>
                    {trip.checklist.length === 0 ? (
                      <Text style={styles.emptyChecklist}>لا توجد مهام</Text>
                    ) : (
                      trip.checklist.map((item) => (
                        <View key={item.id} style={styles.checkItem}>
                          <TouchableOpacity onPress={() => toggleCheckItem(trip, item.id)} style={styles.checkBox}>
                            <Text style={styles.checkIcon}>{item.checked ? '☑️' : '⬜'}</Text>
                          </TouchableOpacity>
                          <Text style={[styles.checkText, item.checked && styles.checkTextDone]}>{item.name}</Text>
                          <TouchableOpacity onPress={() => deleteCheckItem(trip, item.id)}><Text style={styles.deleteCheckBtn}>🗑️</Text></TouchableOpacity>
                        </View>
                      ))
                    )}
                  </View>

                  {/* Documents */}
                  <View style={styles.docsSection}>
                    <Text style={styles.sectionTitle}>📄 المستندات</Text>
                    {trip.documents.length === 0 ? (
                      <Text style={styles.emptyDocs}>لا توجد مستندات</Text>
                    ) : (
                      trip.documents.map((doc, idx) => (
                        <Text key={idx} style={styles.docItem}>📄 {doc}</Text>
                      ))
                    )}
                  </View>
                </View>
              )}
            </Card>
          ))
        )}
      </ScrollView>

      <Modal visible={showModal} animationType="slide" presentationStyle="pageSheet">
        <View style={styles.modalContainer}>
          <View style={styles.modalHeader}>
            <Text style={styles.modalTitle}>{editingTrip ? 'تعديل الرحلة' : 'رحلة جديدة'}</Text>
            <TouchableOpacity onPress={() => { setShowModal(false); resetForm(); }}><Text style={styles.closeBtn}>✕</Text></TouchableOpacity>
          </View>
          <ScrollView style={styles.modalContent}>
            <Input label="اسم الرحلة *" placeholder="مثال: رحلة صيف ٢٠٢٥" value={tripName} onChangeText={setTripName} />
            <Input label="الوجهة *" placeholder="مثال: جدة" value={destination} onChangeText={setDestination} />
            <Input label="تاريخ الذهاب *" placeholder="YYYY-MM-DD" value={departureDate} onChangeText={setDepartureDate} />
            <Input label="تاريخ العودة (اختياري)" placeholder="YYYY-MM-DD" value={returnDate} onChangeText={setReturnDate} />
            <Input label="ملاحظات (اختياري)" placeholder="ملاحظات إضافية" value={notes} onChangeText={setNotes} multiline />
            <Button title={editingTrip ? 'حفظ' : 'إضافة'} onPress={handleSave} fullWidth />
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
  tripHeader: { flexDirection: 'row-reverse', justifyContent: 'space-between', alignItems: 'flex-start' },
  tripInfo: { flex: 1 },
  tripName: { fontSize: THEME.fontSize.lg, fontWeight: THEME.fontWeight.bold, color: THEME.text, marginBottom: 4 },
  tripDestination: { fontSize: THEME.fontSize.md, color: THEME.textSecondary },
  tripDate: { fontSize: THEME.fontSize.sm, color: THEME.textMuted, marginTop: 4 },
  tripActions: { flexDirection: 'row', gap: 8 },
  actionBtn: { fontSize: 18, padding: 4 },
  expandedSection: { marginTop: 16, borderTopWidth: 1, borderTopColor: THEME.border, paddingTop: 16 },
  checklistSection: { marginBottom: 16 },
  checklistHeader: { flexDirection: 'row-reverse', justifyContent: 'space-between', alignItems: 'center', marginBottom: 8 },
  sectionTitle: { fontSize: THEME.fontSize.md, fontWeight: THEME.fontWeight.semibold, color: THEME.text },
  addBtn: { fontSize: THEME.fontSize.sm, color: THEME.primary },
  emptyChecklist: { fontSize: THEME.fontSize.sm, color: THEME.textMuted },
  checkItem: { flexDirection: 'row-reverse', alignItems: 'center', paddingVertical: 8, borderBottomWidth: 1, borderBottomColor: THEME.borderLight },
  checkBox: { marginLeft: 8 },
  checkIcon: { fontSize: 18 },
  checkText: { flex: 1, fontSize: THEME.fontSize.md, color: THEME.text },
  checkTextDone: { textDecorationLine: 'line-through', color: THEME.textMuted },
  deleteCheckBtn: { fontSize: 14, padding: 4 },
  docsSection: { marginTop: 8 },
  emptyDocs: { fontSize: THEME.fontSize.sm, color: THEME.textMuted },
  docItem: { fontSize: THEME.fontSize.sm, color: THEME.text, paddingVertical: 4 },
  modalContainer: { flex: 1, backgroundColor: THEME.background },
  modalHeader: { flexDirection: 'row-reverse', justifyContent: 'space-between', alignItems: 'center', padding: THEME.spacing.md, backgroundColor: THEME.surface, borderBottomWidth: 1, borderBottomColor: THEME.border },
  modalTitle: { fontSize: THEME.fontSize.xl, fontWeight: THEME.fontWeight.bold, color: THEME.text },
  closeBtn: { fontSize: 24, color: THEME.textSecondary, padding: 8 },
  modalContent: { padding: THEME.spacing.md },
});

export default TravelScreen;