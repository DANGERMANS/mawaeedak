/**
 * MobileApp — Main Application Component for Mawaeedak Mobile
 * 
 * PHASE 0-7: Full Mobile Conversion
 * 
 * Features:
 * - 5-tab bottom navigation (الرئيسية, الرواتب, الخدمات, التقويم, المزيد)
 * - RTL support
 * - Local storage for all local features
 * - No real Supabase/API linking yet (pending Phase 11)
 */

import React, { useEffect, useState } from 'react';
import { View, Text, StyleSheet, ActivityIndicator, SafeAreaView } from 'react-native';
import { I18nManager } from 'react-native';

// =============================================================================
// IMPORTS - Screens
// =============================================================================

import { HomeScreen } from './screens/HomeScreen';
import { SalariesScreen } from './screens/SalariesScreen';
import { ServicesScreen } from './screens/ServicesScreen';
import { CalendarScreen } from './screens/CalendarScreen';
import { MoreScreen } from './screens/MoreScreen';

// =============================================================================
// IMPORTS - Navigation
// =============================================================================

import { TabNavigator } from './navigation/TabNavigator';

// =============================================================================
// IMPORTS - Theme
// =============================================================================

import { THEME } from './constants/theme';

// =============================================================================
// TYPES
// =============================================================================

import type { TabName } from './types/app';

// =============================================================================
// CONFIGURATION & SETUP
// =============================================================================

// Force RTL for Arabic
I18nManager.allowRTL(true);
I18nManager.forceRTL(true);

// =============================================================================
// MAIN MOBILE APP COMPONENT
// =============================================================================

interface MobileAppProps {
  onReady?: () => void;
}

const MobileApp: React.FC<MobileAppProps> = ({ onReady }) => {
  const [activeTab, setActiveTab] = useState<TabName>('home');
  const [isLoading, setIsLoading] = useState(true);

  useEffect(() => {
    // Simulate startup initialization
    const timer = setTimeout(() => {
      setIsLoading(false);
      onReady?.();
    }, 500);
    
    return () => clearTimeout(timer);
  }, [onReady]);

  // Loading State
  if (isLoading) {
    return (
      <SafeAreaView style={styles.container}>
        <View style={styles.loadingContainer}>
          <Text style={styles.loadingLogo}>🕌</Text>
          <Text style={styles.loadingText}>جاري تحميل مواعيدك...</Text>
          <ActivityIndicator size="large" color={THEME.primary} />
        </View>
      </SafeAreaView>
    );
  }

  // Screen Content - Render based on active tab
  const renderScreen = () => {
    switch (activeTab) {
      case 'home':
        return <HomeScreen />;
      case 'salaries':
        return <SalariesScreen />;
      case 'services':
        return <ServicesScreen />;
      case 'calendar':
        return <CalendarScreen />;
      case 'more':
        return <MoreScreen />;
      default:
        return <HomeScreen />;
    }
  };

  return (
    <SafeAreaView style={styles.container}>
      {/* Main Content - ScrollView for non-calendar screens */}
      <View style={styles.content}>
        {renderScreen()}
      </View>

      {/* Bottom Tab Navigator - 5 tabs */}
      <TabNavigator activeTab={activeTab} onTabPress={setActiveTab} />
    </SafeAreaView>
  );
};

// =============================================================================
// STYLES
// =============================================================================

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: THEME.background,
  },
  
  // Loading
  loadingContainer: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: THEME.background,
  },
  loadingLogo: {
    fontSize: 64,
    marginBottom: 20,
  },
  loadingText: {
    fontSize: 18,
    color: THEME.textSecondary,
    marginBottom: 20,
  },
  
  // Content
  content: {
    flex: 1,
  },
});

export default MobileApp;