/**
 * Tab Layout — Bottom Tab Navigation for Mawaeedak Mobile
 * 
 * 5 Tabs: الرئيسية, الرواتب, الخدمات, التقويم, المزيد
 */

import { Tabs } from 'expo-router';
import { Text, View, StyleSheet } from 'react-native';
import { I18nManager } from 'react-native';

// Theme colors
const THEME = {
  primary: '#C9A063',
  secondary: '#8A6B3D',
  background: '#FAF7F2',
  surface: '#FFFFFF',
  text: '#2F2B25',
  textSecondary: '#6F6557',
  border: '#DCD7CF',
};

// Tab icons
const TabIcon = ({ icon, label, focused }: { icon: string; label: string; focused: boolean }) => (
  <View style={styles.tabItem}>
    <Text style={[styles.tabIcon, focused && styles.tabIconFocused]}>{icon}</Text>
    <Text style={[styles.tabLabel, focused && styles.tabLabelFocused]}>{label}</Text>
  </View>
);

export default function TabLayout() {
  return (
    <Tabs
      screenOptions={{
        headerShown: false,
        tabBarStyle: styles.tabBar,
        tabBarShowLabel: false,
        tabBarActiveTintColor: THEME.primary,
        tabBarInactiveTintColor: THEME.textSecondary,
      }}
    >
      {/* 1. الرئيسية */}
      <Tabs.Screen
        name="home"
        options={{
          title: 'الرئيسية',
          tabBarIcon: ({ focused }) => (
            <TabIcon icon="🏠" label="الرئيسية" focused={focused} />
          ),
        }}
      />
      {/* 2. الرواتب */}
      <Tabs.Screen
        name="salary"
        options={{
          title: 'الرواتب',
          tabBarIcon: ({ focused }) => (
            <TabIcon icon="💰" label="الرواتب" focused={focused} />
          ),
        }}
      />
      {/* 3. الخدمات */}
      <Tabs.Screen
        name="services"
        options={{
          title: 'الخدمات',
          tabBarIcon: ({ focused }) => (
            <TabIcon icon="🏢" label="الخدمات" focused={focused} />
          ),
        }}
      />
      {/* 4. التقويم */}
      <Tabs.Screen
        name="calendar"
        options={{
          title: 'التقويم',
          tabBarIcon: ({ focused }) => (
            <TabIcon icon="📅" label="التقويم" focused={focused} />
          ),
        }}
      />
      {/* 5. المزيد */}
      <Tabs.Screen
        name="more"
        options={{
          title: 'المزيد',
          tabBarIcon: ({ focused }) => (
            <TabIcon icon="☰" label="المزيد" focused={focused} />
          ),
        }}
      />
    </Tabs>
  );
}

const styles = StyleSheet.create({
  tabBar: {
    backgroundColor: THEME.surface,
    borderTopWidth: 1,
    borderTopColor: THEME.border,
    height: 80,
    paddingTop: 8,
    paddingBottom: 20,
    direction: I18nManager.isRTL ? 'rtl' : 'ltr',
  },
  tabItem: {
    alignItems: 'center',
    justifyContent: 'center',
  },
  tabIcon: {
    fontSize: 22,
    marginBottom: 4,
  },
  tabIconFocused: {
    transform: [{ scale: 1.1 }],
  },
  tabLabel: {
    fontSize: 10,
    color: THEME.textSecondary,
    fontWeight: '500',
  },
  tabLabelFocused: {
    color: THEME.primary,
    fontWeight: 'bold',
  },
});