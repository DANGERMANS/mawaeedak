import { createElement, type PropsWithChildren } from 'react';
import { Pressable, StyleSheet } from 'react-native';
import { colors, radius, spacing } from '../theme';
import { AppText } from './AppText';

type AppButtonProps = PropsWithChildren<{
  onPress: () => void;
  variant?: 'primary' | 'secondary' | 'ghost';
}>;

export function AppButton({ children, onPress, variant = 'primary' }: AppButtonProps) {
  return createElement(
    Pressable,
    { onPress, style: [styles.base, styles[variant]] },
    createElement(AppText, { variant: 'caption', center: true, style: variant === 'primary' ? styles.primaryText : undefined }, children),
  );
}

const styles = StyleSheet.create({
  base: {
    minHeight: 44,
    borderRadius: radius.md,
    paddingVertical: spacing.sm,
    paddingHorizontal: spacing.md,
    alignItems: 'center',
    justifyContent: 'center',
  },
  primary: {
    backgroundColor: colors.primary,
  },
  secondary: {
    backgroundColor: colors.surfaceStrong,
    borderColor: colors.border,
    borderWidth: 1,
  },
  ghost: {
    backgroundColor: 'transparent',
    borderColor: colors.border,
    borderWidth: 1,
  },
  primaryText: {
    color: colors.white,
  },
});
