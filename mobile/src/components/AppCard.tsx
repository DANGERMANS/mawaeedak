import { createElement, type PropsWithChildren } from 'react';
import { StyleSheet, View } from 'react-native';
import { colors, radius, spacing } from '../theme';

export function AppCard({ children }: PropsWithChildren) {
  return createElement(View, { style: styles.card }, children);
}

const styles = StyleSheet.create({
  card: {
    backgroundColor: colors.surface,
    borderColor: colors.border,
    borderWidth: 1,
    borderRadius: radius.lg,
    padding: spacing.lg,
    gap: spacing.sm,
  },
});
