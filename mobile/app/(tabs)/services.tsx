/**
 * Services Screen — Service Centers for Mawaeedak Mobile
 * 
 * Features:
 * - 8 Service Centers
 * - Services list per center
 * - Quick actions
 * - Search/filter
 */

import { useState } from 'react';
import { View, Text, StyleSheet, ScrollView, Pressable, TextInput, Alert } from 'react-native';
import { Feather } from '@expo/vector-icons';

// Theme colors
const GOLD = '#C9A063';
const BROWN = '#8A6B3D';
const INK = '#2F2B25';
const PAPER = '#FAF7F2';
const CREAM = '#F5EFE4';
const TEXT_SECONDARY = '#6F6557';

// Service Centers Data
const SERVICE_CENTERS = [
  { id: 1, name: 'الأحوال المدنية', icon: '🪪', services: ['تجديد الهوية', 'تعديل البيانات', 'تصريح سفر', 'إثبات وتصديق'] },
  { id: 2, name: 'الجوازات', icon: '📋', services: ['تأشيرات', 'تمديد إقامة', 'نقل كفالة', 'تعديل مهنة'] },
  { id: 3, name: 'المرور', icon: '🚗', services: ['رخصة قيادة', 'تجديد تسجيل', 'استمارة السيارة', 'نقل ملكية'] },
  { id: 4, name: 'البريد', icon: '📮', services: ['طرود', 'حوالات', 'صندوق بريد', 'تأمينات'] },
  { id: 5, name: 'التأمينات الاجتماعية', icon: '🏥', services: ['تأمين صحي', 'تعديل بيانات', 'معاش', 'إعادة صرف'] },
  { id: 6, name: 'الزكاة والدخل', icon: '💵', services: ['زكاة', 'صدقات', 'ضريبة القيمة المضافة', 'تعديل بيانات'] },
  { id: 7, name: 'التعليم', icon: '📚', services: ['سجلات', 'شهادات', 'نقل طالب', 'التسجيل'] },
  { id: 8, name: 'الخدمات العامة', icon: '🏢', services: ['رخص', 'تصاريح', 'بلاغات', 'استعلامات'] },
];

// Service Item Component
function ServiceItem({ name, center, onPress }: {
  name: string;
  center: { name: string; icon: string };
  onPress: () => void;
}) {
  return (
    <Pressable style={styles.serviceItem} onPress={onPress}>
      <View style={styles.serviceIcon}>
        <Text style={{ fontSize: 24 }}>{center.icon}</Text>
      </View>
      <View style={styles.serviceContent}>
        <Text style={styles.serviceName}>{name}</Text>
        <Text style={styles.serviceCenter}>{center.name}</Text>
      </View>
      <Feather name="chevron-left" size={20} color={TEXT_SECONDARY} />
    </Pressable>
  );
}

// Center Card Component
function CenterCard({ name, icon, services, onPress }: {
  name: string;
  icon: string;
  services: string[];
  onPress: () => void;
}) {
  return (
    <Pressable style={styles.centerCard} onPress={onPress}>
      <View style={styles.centerIcon}>
        <Text style={{ fontSize: 32 }}>{icon}</Text>
      </View>
      <Text style={styles.centerName}>{name}</Text>
      <Text style={styles.centerServices}>{services.length} خدمة</Text>
    </Pressable>
  );
}

export default function ServicesScreen() {
  const [searchQuery, setSearchQuery] = useState('');
  const [selectedCenter, setSelectedCenter] = useState<typeof SERVICE_CENTERS[0] | null>(null);

  const filteredCenters = searchQuery
    ? SERVICE_CENTERS.filter(c => c.name.includes(searchQuery) || c.services.some(s => s.includes(searchQuery)))
    : SERVICE_CENTERS;

  const handleCenterPress = (center: typeof SERVICE_CENTERS[0]) => {
    setSelectedCenter(center);
  };

  const handleServicePress = (service: string) => {
    Alert.alert(
      service,
      `هل تريد حجز موعد لـ ${service} في ${selectedCenter?.name || 'المركز'}؟`,
      [
        { text: 'إلغاء', style: 'cancel' },
        { text: 'حجز موعد', onPress: () => Alert.alert('تم', 'سيتم توجيهك لتطبيق المواعيد') },
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
          <Text style={styles.headerTitle}>مراكز الخدمات</Text>
          <Text style={styles.headerSubtitle}>8 مراكز متاحة</Text>
        </View>

        {/* Search Bar */}
        <View style={styles.searchContainer}>
          <Feather name="search" size={20} color={TEXT_SECONDARY} />
          <TextInput
            style={styles.searchInput}
            value={searchQuery}
            onChangeText={setSearchQuery}
            placeholder="ابحث عن خدمة أو مركز..."
            placeholderTextColor={TEXT_SECONDARY}
          />
          {searchQuery.length > 0 && (
            <Pressable onPress={() => setSearchQuery('')}>
              <Feather name="x" size={20} color={TEXT_SECONDARY} />
            </Pressable>
          )}
        </View>

        {/* Center Detail View */}
        {selectedCenter ? (
          <View style={styles.centerDetail}>
            <Pressable style={styles.backButton} onPress={() => setSelectedCenter(null)}>
              <Feather name="arrow-right" size={20} color={INK} />
              <Text style={styles.backText}>رجوع</Text>
            </Pressable>
            
            <View style={styles.centerHeader}>
              <View style={styles.centerIconLarge}>
                <Text style={{ fontSize: 48 }}>{selectedCenter.icon}</Text>
              </View>
              <Text style={styles.centerNameLarge}>{selectedCenter.name}</Text>
              <Text style={styles.centerServicesCount}>{selectedCenter.services.length} خدمات متاحة</Text>
            </View>

            <View style={styles.servicesList}>
              <Text style={styles.servicesTitle}>الخدمات المتاحة</Text>
              {selectedCenter.services.map((service, index) => (
                <Pressable
                  key={index}
                  style={styles.serviceCard}
                  onPress={() => handleServicePress(service)}
                >
                  <View style={styles.serviceCardContent}>
                    <Text style={styles.serviceCardName}>{service}</Text>
                    <Feather name="chevron-left" size={20} color={BROWN} />
                  </View>
                </Pressable>
              ))}
            </View>
          </View>
        ) : (
          /* Centers Grid */
          <View style={styles.centersGrid}>
            {filteredCenters.map((center) => (
              <CenterCard
                key={center.id}
                name={center.name}
                icon={center.icon}
                services={center.services}
                onPress={() => handleCenterPress(center)}
              />
            ))}
          </View>
        )}

        {/* Bottom padding */}
        <View style={{ height: 100 }} />
      </ScrollView>
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
    marginBottom: 20,
  },
  headerTitle: {
    fontSize: 28,
    fontWeight: '800',
    color: INK,
  },
  headerSubtitle: {
    fontSize: 14,
    color: TEXT_SECONDARY,
    marginTop: 4,
  },
  searchContainer: {
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: CREAM,
    borderRadius: 14,
    paddingHorizontal: 16,
    paddingVertical: 12,
    marginBottom: 20,
    borderWidth: 1,
    borderColor: 'rgba(201,160,99,0.15)',
  },
  searchInput: {
    flex: 1,
    fontSize: 16,
    color: INK,
    marginRight: 12,
    marginLeft: 12,
  },
  centersGrid: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    gap: 12,
  },
  centerCard: {
    width: '47%',
    backgroundColor: CREAM,
    borderRadius: 18,
    padding: 20,
    alignItems: 'center',
    borderWidth: 1,
    borderColor: 'rgba(201,160,99,0.15)',
  },
  centerIcon: {
    width: 72,
    height: 72,
    borderRadius: 20,
    backgroundColor: PAPER,
    justifyContent: 'center',
    alignItems: 'center',
    marginBottom: 12,
  },
  centerName: {
    fontSize: 15,
    fontWeight: '700',
    color: INK,
    textAlign: 'center',
    marginBottom: 4,
  },
  centerServices: {
    fontSize: 12,
    color: TEXT_SECONDARY,
  },
  centerDetail: {
    marginTop: 8,
  },
  backButton: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 20,
    gap: 8,
  },
  backText: {
    fontSize: 16,
    color: INK,
    fontWeight: '600',
  },
  centerHeader: {
    alignItems: 'center',
    marginBottom: 24,
  },
  centerIconLarge: {
    width: 100,
    height: 100,
    borderRadius: 28,
    backgroundColor: CREAM,
    justifyContent: 'center',
    alignItems: 'center',
    marginBottom: 16,
  },
  centerNameLarge: {
    fontSize: 24,
    fontWeight: '800',
    color: INK,
    marginBottom: 4,
  },
  centerServicesCount: {
    fontSize: 14,
    color: TEXT_SECONDARY,
  },
  servicesList: {
    marginTop: 8,
  },
  servicesTitle: {
    fontSize: 18,
    fontWeight: '700',
    color: INK,
    marginBottom: 16,
  },
  serviceCard: {
    backgroundColor: CREAM,
    borderRadius: 14,
    marginBottom: 10,
    overflow: 'hidden',
  },
  serviceCardContent: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
    padding: 16,
  },
  serviceCardName: {
    fontSize: 16,
    fontWeight: '600',
    color: INK,
  },
  serviceItem: {
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: CREAM,
    borderRadius: 14,
    padding: 14,
    marginBottom: 10,
    borderWidth: 1,
    borderColor: 'rgba(201,160,99,0.10)',
  },
  serviceIcon: {
    width: 48,
    height: 48,
    borderRadius: 14,
    backgroundColor: PAPER,
    justifyContent: 'center',
    alignItems: 'center',
    marginRight: 14,
  },
  serviceContent: {
    flex: 1,
  },
  serviceName: {
    fontSize: 16,
    fontWeight: '600',
    color: INK,
  },
  serviceCenter: {
    fontSize: 13,
    color: TEXT_SECONDARY,
    marginTop: 2,
  },
});