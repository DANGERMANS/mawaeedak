/**
 * Root Layout — Global layout for Mawaeedak Mobile App
 * 
 * Provides:
 * - RTL support for Arabic
 * - Tab navigation with (tabs) group
 * - Stack navigation for modals/screens
 * - Safe area handling
 */

import { Stack } from 'expo-router';
import { StatusBar } from 'expo-status-bar';
import { I18nManager } from 'react-native';
import { SafeAreaProvider } from 'react-native-safe-area-context';

// Force RTL for Arabic language
I18nManager.allowRTL(true);
I18nManager.forceRTL(true);

export default function RootLayout() {
  return (
    <SafeAreaProvider>
      <StatusBar style="dark" />
      <Stack
        screenOptions={{
          headerShown: false,
          contentStyle: { backgroundColor: '#FAF7F2' },
          animation: 'slide_from_right',
        }}
      >
        {/* Tabs Group - Main Navigation */}
        <Stack.Screen name="(tabs)" options={{ headerShown: false }} />
        
        {/* Daily Card Screen */}
        <Stack.Screen 
          name="daily-card" 
          options={{ 
            title: 'البطاقة اليومية',
            headerShown: true,
            headerStyle: { backgroundColor: '#FAF7F2' },
            headerTintColor: '#2F2B25',
            headerTitleStyle: { fontWeight: '700', fontSize: 18 },
          }} 
        />
        
        {/* Settings Screen */}
        <Stack.Screen 
          name="settings" 
          options={{ 
            title: 'الإعدادات',
            headerShown: true,
            headerStyle: { backgroundColor: '#FAF7F2' },
            headerTintColor: '#2F2B25',
            headerTitleStyle: { fontWeight: '700', fontSize: 18 },
          }} 
        />
        
        {/* Account Screen */}
        <Stack.Screen 
          name="account" 
          options={{ 
            title: 'حسابي',
            headerShown: true,
            headerStyle: { backgroundColor: '#FAF7F2' },
            headerTintColor: '#2F2B25',
            headerTitleStyle: { fontWeight: '700', fontSize: 18 },
          }} 
        />
      </Stack>
    </SafeAreaProvider>
  );
}