/**
 * Card Component — Mawaeedak Mobile
 */

import React from 'react';
import { View, Text, StyleSheet, ViewStyle, TouchableOpacity } from 'react-native';
import { THEME } from '../constants/theme';

interface CardProps {
  children: React.ReactNode;
  title?: string;
  subtitle?: string;
  icon?: string;
  onPress?: () => void;
  style?: ViewStyle;
  variant?: 'default' | 'elevated' | 'outlined';
}

export const Card: React.FC<CardProps> = ({
  children,
  title,
  subtitle,
  icon,
  onPress,
  style,
  variant = 'default',
}) => {
  const Container = onPress ? TouchableOpacity : View;

  return (
    <Container 
      style={[styles.container, styles[`container_${variant}`], style]} 
      onPress={onPress}
      activeOpacity={onPress ? 0.7 : 1}
    >
      {(title || subtitle || icon) && (
        <View style={styles.header}>
          {icon && <Text style={styles.icon}>{icon}</Text>}
          <View style={styles.titles}>
            {title && <Text style={styles.title}>{title}</Text>}
            {subtitle && <Text style={styles.subtitle}>{subtitle}</Text>}
          </View>
        </View>
      )}
      <View style={styles.content}>{children}</View>
    </Container>
  );
};

// Status Badge Component
interface StatusBadgeProps {
  status: 'pending' | 'approved' | 'official' | 'active' | 'completed' | 'paid';
  label?: string;
}

export const StatusBadge: React.FC<StatusBadgeProps> = ({ status, label }) => {
  const getColors = () => {
    switch (status) {
      case 'approved':
      case 'official':
      case 'completed':
      case 'paid':
        return { bg: THEME.success + '20', text: THEME.success };
      case 'active':
        return { bg: THEME.primary + '20', text: THEME.primary };
      case 'pending':
      default:
        return { bg: THEME.warning + '20', text: THEME.warning };
    }
  };

  const colors = getColors();

  return (
    <View style={[styles.badge, { backgroundColor: colors.bg }]}>
      <Text style={[styles.badgeText, { color: colors.text }]}>
        {label || status === 'official' ? 'رسمي' : status === 'pending' ? 'بانتظار' : status}
      </Text>
    </View>
  );
};

// Pending Status Banner
interface PendingBannerProps {
  message?: string;
}

export const PendingBanner: React.FC<PendingBannerProps> = ({ 
  message = 'بانتظار الربط بمصادر البيانات الرسمية' 
}) => (
  <View style={styles.pendingBanner}>
    <Text style={styles.pendingBannerIcon}>⏳</Text>
    <Text style={styles.pendingBannerText}>{message}</Text>
  </View>
);

// Empty State Component
interface EmptyStateProps {
  icon?: string;
  title: string;
  description?: string;
  action?: {
    label: string;
    onPress: () => void;
  };
}

export const EmptyState: React.FC<EmptyStateProps> = ({
  icon = '📋',
  title,
  description,
  action,
}) => (
  <View style={styles.emptyState}>
    <Text style={styles.emptyStateIcon}>{icon}</Text>
    <Text style={styles.emptyStateTitle}>{title}</Text>
    {description && <Text style={styles.emptyStateDesc}>{description}</Text>}
    {action && (
      <TouchableOpacity style={styles.emptyStateButton} onPress={action.onPress}>
        <Text style={styles.emptyStateButtonText}>{action.label}</Text>
      </TouchableOpacity>
    )}
  </View>
);

// Loading State Component
interface LoadingStateProps {
  message?: string;
}

export const LoadingState: React.FC<LoadingStateProps> = ({ 
  message = 'جاري التحميل...' 
}) => (
  <View style={styles.loadingState}>
    <Text style={styles.loadingIcon}>⏳</Text>
    <Text style={styles.loadingText}>{message}</Text>
  </View>
);

// Section Header Component
interface SectionHeaderProps {
  title: string;
  icon?: string;
  action?: {
    label: string;
    onPress: () => void;
  };
}

export const SectionHeader: React.FC<SectionHeaderProps> = ({ title, icon, action }) => (
  <View style={styles.sectionHeader}>
    <View style={styles.sectionHeaderTitle}>
      {icon && <Text style={styles.sectionHeaderIcon}>{icon}</Text>}
      <Text style={styles.sectionHeaderText}>{title}</Text>
    </View>
    {action && (
      <TouchableOpacity onPress={action.onPress}>
        <Text style={styles.sectionHeaderAction}>{action.label}</Text>
      </TouchableOpacity>
    )}
  </View>
);

const styles = StyleSheet.create({
  // Container
  container: {
    backgroundColor: THEME.surface,
    borderRadius: THEME.radius.lg,
    padding: THEME.spacing.md,
    marginBottom: THEME.spacing.md,
  },
  container_default: {
    borderWidth: 1,
    borderColor: THEME.border,
  },
  container_elevated: {
    shadowColor: THEME.shadow,
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 1,
    shadowRadius: 8,
    elevation: 4,
    borderWidth: 0,
  },
  container_outlined: {
    borderWidth: 2,
    borderColor: THEME.primary,
    borderStyle: 'dashed',
  },

  // Header
  header: {
    flexDirection: 'row-reverse',
    alignItems: 'center',
    marginBottom: THEME.spacing.sm,
  },
  icon: {
    fontSize: 24,
    marginLeft: THEME.spacing.sm,
  },
  titles: {
    flex: 1,
  },
  title: {
    fontSize: THEME.fontSize.lg,
    fontWeight: THEME.fontWeight.bold,
    color: THEME.text,
  },
  subtitle: {
    fontSize: THEME.fontSize.sm,
    color: THEME.textSecondary,
    marginTop: 2,
  },

  // Content
  content: {},

  // Badge
  badge: {
    alignSelf: 'flex-start',
    paddingHorizontal: THEME.spacing.sm,
    paddingVertical: 4,
    borderRadius: THEME.radius.full,
  },
  badgeText: {
    fontSize: THEME.fontSize.xs,
    fontWeight: THEME.fontWeight.medium,
  },

  // Pending Banner
  pendingBanner: {
    flexDirection: 'row-reverse',
    alignItems: 'center',
    backgroundColor: THEME.warning + '15',
    padding: THEME.spacing.md,
    borderRadius: THEME.radius.md,
    marginVertical: THEME.spacing.sm,
    gap: THEME.spacing.sm,
  },
  pendingBannerIcon: {
    fontSize: 16,
  },
  pendingBannerText: {
    fontSize: THEME.fontSize.sm,
    color: THEME.warning,
    flex: 1,
  },

  // Empty State
  emptyState: {
    alignItems: 'center',
    paddingVertical: THEME.spacing.xxl,
  },
  emptyStateIcon: {
    fontSize: 48,
    marginBottom: THEME.spacing.md,
  },
  emptyStateTitle: {
    fontSize: THEME.fontSize.lg,
    fontWeight: THEME.fontWeight.semibold,
    color: THEME.text,
    marginBottom: THEME.spacing.xs,
  },
  emptyStateDesc: {
    fontSize: THEME.fontSize.md,
    color: THEME.textSecondary,
    textAlign: 'center',
    marginBottom: THEME.spacing.md,
  },
  emptyStateButton: {
    backgroundColor: THEME.primary,
    paddingHorizontal: THEME.spacing.lg,
    paddingVertical: THEME.spacing.sm,
    borderRadius: THEME.radius.md,
  },
  emptyStateButtonText: {
    color: '#FFFFFF',
    fontSize: THEME.fontSize.md,
    fontWeight: THEME.fontWeight.medium,
  },

  // Loading State
  loadingState: {
    alignItems: 'center',
    paddingVertical: THEME.spacing.xxl,
  },
  loadingIcon: {
    fontSize: 32,
    marginBottom: THEME.spacing.md,
  },
  loadingText: {
    fontSize: THEME.fontSize.md,
    color: THEME.textSecondary,
  },

  // Section Header
  sectionHeader: {
    flexDirection: 'row-reverse',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginBottom: THEME.spacing.md,
    marginTop: THEME.spacing.lg,
  },
  sectionHeaderTitle: {
    flexDirection: 'row-reverse',
    alignItems: 'center',
    gap: THEME.spacing.xs,
  },
  sectionHeaderIcon: {
    fontSize: 18,
  },
  sectionHeaderText: {
    fontSize: THEME.fontSize.lg,
    fontWeight: THEME.fontWeight.bold,
    color: THEME.text,
  },
  sectionHeaderAction: {
    fontSize: THEME.fontSize.sm,
    color: THEME.primary,
    fontWeight: THEME.fontWeight.medium,
  },
});

export default Card;