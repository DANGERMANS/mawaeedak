/**
 * Jobs & News Screen — الوظائف والأخبار
 * Local saved items + pending official data
 */

import React, { useState, useEffect } from 'react';
import { View, Text, StyleSheet, ScrollView, TouchableOpacity, TextInput } from 'react-native';
import { THEME } from '../../constants/theme';
import { Card, SectionHeader, PendingBanner, EmptyState } from '../../components/Card';

type SavedItem = {
  id: string;
  title: string;
  type: 'job' | 'news';
  savedAt: string;
  keywords?: string[];
};

export const JobsScreen: React.FC = () => {
  const [activeTab, setActiveTab] = useState<'jobs' | 'news'>('jobs');
  const [searchQuery, setSearchQuery] = useState('');
  const [savedItems, setSavedItems] = useState<SavedItem[]>([]);

  const filteredItems = savedItems.filter(item => {
    if (item.type !== activeTab) return false;
    if (!searchQuery.trim()) return true;
    return item.title.toLowerCase().includes(searchQuery.toLowerCase());
  });

  return (
    <View style={styles.container}>
      <View style={styles.header}>
        <Text style={styles.title}>الوظائف والأخبار 💼</Text>
      </View>

      <ScrollView style={styles.content} contentContainerStyle={styles.contentInner}>
        <PendingBanner message="بانتظار ربط الوظائف والأخبار الرسمية" />

        {/* Tabs */}
        <View style={styles.tabs}>
          <TouchableOpacity 
            style={[styles.tab, activeTab === 'jobs' && styles.tabActive]}
            onPress={() => setActiveTab('jobs')}
          >
            <Text style={[styles.tabText, activeTab === 'jobs' && styles.tabTextActive]}>💼 الوظائف</Text>
          </TouchableOpacity>
          <TouchableOpacity 
            style={[styles.tab, activeTab === 'news' && styles.tabActive]}
            onPress={() => setActiveTab('news')}
          >
            <Text style={[styles.tabText, activeTab === 'news' && styles.tabTextActive]}>📰 الأخبار</Text>
          </TouchableOpacity>
        </View>

        {/* Search */}
        <View style={styles.searchContainer}>
          <Text style={styles.searchIcon}>🔍</Text>
          <TextInput
            style={styles.searchInput}
            placeholder="بحث..."
            placeholderTextColor={THEME.textMuted}
            value={searchQuery}
            onChangeText={setSearchQuery}
          />
        </View>

        {/* Local Saved Items */}
        <SectionHeader title="المحفوظات المحلية" />

        {filteredItems.length === 0 ? (
          <Card>
            <EmptyState
              icon={activeTab === 'jobs' ? '💼' : '📰'}
              title={`لا توجد ${activeTab === 'jobs' ? 'وظائف' : 'أخبار'} محفوظة`}
              description={`ابحث عن ${activeTab === 'jobs' ? 'وظيفة' : 'خبر'} واحفظه محلياً`}
            />
            <View style={styles.featureHint}>
              <Text style={styles.hintText}>💡 المميزات المحلية:</Text>
              <Text style={styles.hintItem}>• حفظ اهتمامات البحث</Text>
              <Text style={styles.hintItem}>• تتبع كلمات مفتاحية</Text>
              <Text style={styles.hintItem}>• إضافة ملاحظات</Text>
            </View>
          </Card>
        ) : (
          filteredItems.map((item) => (
            <Card key={item.id}>
              <View style={styles.itemHeader}>
                <Text style={styles.itemTitle}>{item.title}</Text>
                <Text style={styles.itemType}>{item.type === 'job' ? '💼' : '📰'}</Text>
              </View>
              <Text style={styles.itemDate}>محفوظ: {new Date(item.savedAt).toLocaleDateString('ar-SA')}</Text>
              {item.keywords && item.keywords.length > 0 && (
                <View style={styles.keywordsRow}>
                  {item.keywords.map((kw, idx) => (
                    <View key={idx} style={styles.keywordBadge}><Text style={styles.keywordText}>{kw}</Text></View>
                  ))}
                </View>
              )}
            </Card>
          ))
        )}

        {/* Info */}
        <View style={styles.infoBox}>
          <Text style={styles.infoTitle}>ℹ️ معلومات</Text>
          <Text style={styles.infoText}>
            الوظائف والأخبار الرسمية ستظهر هنا عند ربط المصادر.
            حالياً يمكنك حفظ اهتمامات البحث المحلية فقط.
          </Text>
        </View>
      </ScrollView>
    </View>
  );
};

const styles = StyleSheet.create({
  container: { flex: 1, backgroundColor: THEME.background },
  header: { padding: THEME.spacing.md, backgroundColor: THEME.surface, borderBottomWidth: 1, borderBottomColor: THEME.border },
  title: { fontSize: THEME.fontSize.xxl, fontWeight: THEME.fontWeight.bold, color: THEME.text },
  content: { flex: 1 },
  contentInner: { padding: THEME.spacing.md, paddingBottom: THEME.spacing.xxl },
  tabs: { flexDirection: 'row-reverse', marginVertical: THEME.spacing.md },
  tab: { flex: 1, paddingVertical: 12, alignItems: 'center', borderBottomWidth: 2, borderBottomColor: THEME.border },
  tabActive: { borderBottomColor: THEME.primary },
  tabText: { fontSize: THEME.fontSize.md, color: THEME.textSecondary },
  tabTextActive: { color: THEME.primary, fontWeight: THEME.fontWeight.bold },
  searchContainer: { flexDirection: 'row-reverse', alignItems: 'center', backgroundColor: THEME.surface, borderRadius: THEME.radius.md, paddingHorizontal: 12, marginBottom: THEME.spacing.md, borderWidth: 1, borderColor: THEME.border },
  searchIcon: { fontSize: 16, marginLeft: 8 },
  searchInput: { flex: 1, fontSize: THEME.fontSize.md, color: THEME.text, paddingVertical: 12, textAlign: 'right' },
  itemHeader: { flexDirection: 'row-reverse', justifyContent: 'space-between', alignItems: 'center', marginBottom: 8 },
  itemTitle: { fontSize: THEME.fontSize.md, fontWeight: THEME.fontWeight.semibold, color: THEME.text, flex: 1 },
  itemType: { fontSize: 18 },
  itemDate: { fontSize: THEME.fontSize.sm, color: THEME.textMuted },
  keywordsRow: { flexDirection: 'row-reverse', flexWrap: 'wrap', gap: 8, marginTop: 8 },
  keywordBadge: { backgroundColor: THEME.primary + '20', paddingHorizontal: 8, paddingVertical: 4, borderRadius: 4 },
  keywordText: { fontSize: THEME.fontSize.xs, color: THEME.primary },
  featureHint: { marginTop: THEME.spacing.md, padding: THEME.spacing.md, backgroundColor: THEME.surfaceAlt, borderRadius: THEME.radius.md },
  hintText: { fontSize: THEME.fontSize.sm, fontWeight: THEME.fontWeight.medium, color: THEME.text, marginBottom: 8 },
  hintItem: { fontSize: THEME.fontSize.sm, color: THEME.textSecondary, marginBottom: 4 },
  infoBox: { marginTop: THEME.spacing.lg, padding: THEME.spacing.md, backgroundColor: THEME.info + '15', borderRadius: THEME.radius.md },
  infoTitle: { fontSize: THEME.fontSize.sm, fontWeight: THEME.fontWeight.medium, color: THEME.info, marginBottom: 8 },
  infoText: { fontSize: THEME.fontSize.sm, color: THEME.info, lineHeight: 20 },
});

export default JobsScreen;