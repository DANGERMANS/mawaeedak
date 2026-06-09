/**
 * Tab Navigator — Mawaeedak Mobile
 * 
 * 5-tab bottom navigation as specified:
 * 1. الرئيسية (Home)
 * 2. الرواتب (Salaries)
 * 3. الخدمات (Services)
 * 4. التقويم (Calendar)
 * 5. المزيد (More)
 */

import React from 'react';
import { View, Text, TouchableOpacity, StyleSheet } from 'react-native';
import { THEME } from '../constants/theme';
import type { TabName } from '../types/app';

interface TabItemConfig {
  name: TabName;
  icon: string;
  activeIcon: string;
  label: string;
}

const TABS: TabItemConfig[] = [
  { name: 'home', icon: '🏠', activeIcon: '🏠', label: 'الرئيسية' },
  { name: 'salaries', icon: '💰', activeIcon: '💰', label: 'الرواتب' },
  { name: 'services', icon: '🏢', activeIcon: '🏢', label: 'الخدمات' },
  { name: 'calendar', icon: '📅', activeIcon: '📅', label: 'التقويم' },
  { name: 'more', icon: '☰', activeIcon: '☰', label: 'المزيد' },
];

interface TabNavigatorProps {
  activeTab: TabName;
  onTabPress: (tab: TabName) => void;
}

export const TabNavigator: React.FC<TabNavigatorProps> = ({ activeTab, onTabPress }) => {
  return (
    <View style={styles.container}>
      {TABS.map((tab) => {
        const isActive = activeTab === tab.name;
        return (
          <TouchableOpacity
            key={tab.name}
            style={styles.tab}
            onPress={() => onTabPress(tab.name)}
            activeOpacity={0.7}
          >
            <Text style={[styles.icon, isActive && styles.iconActive]}>
              {isActive ? tab.activeIcon : tab.icon}
            </Text>
            <Text style={[styles.label, isActive && styles.labelActive]}>
              {tab.label}
            </Text>
            {isActive && <View style={styles.activeIndicator} />}
          </TouchableOpacity>
        );
      })}
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flexDirection: 'row-reverse',
    backgroundColor: THEME.surface,
    borderTopWidth: 1,
    borderTopColor: THEME.border,
    paddingBottom: 20, // Safe area for bottom
    paddingTop: 8,
  },
  
  tab: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
    paddingVertical: 8,
    position: 'relative',
  },
  
  icon: {
    fontSize: 22,
    marginBottom: 4,
    opacity: 0.6,
  },
  iconActive: {
    opacity: 1,
  },
  
  label: {
    fontSize: 10,
    color: THEME.textSecondary,
    fontWeight: THEME.fontWeight.medium,
  },
  labelActive: {
    color: THEME.primary,
    fontWeight: THEME.fontWeight.bold,
  },
  
  activeIndicator: {
    position: 'absolute',
    top: 0,
    width: 24,
    height: 3,
    backgroundColor: THEME.primary,
    borderRadius: 2,
  },
});

export default TabNavigator;