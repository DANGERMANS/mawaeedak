import type { PropsWithChildren } from 'react';
import { StyleSheet, Text, type TextStyle } from 'react-native';
import { colors, typography } from '../theme';

type AppTextProps = PropsWithChildren<{
  variant?: 'hero' | 'title' | 'body' | 'caption' | 'tiny';
  muted?: boolean;
  center?: boolean;
  style?: TextStyle | TextStyle[];
}>;

export function AppText({ children, variant = 'body', muted = false, center = false, style }: AppTextProps) {
  return (
    <Text style={[styles.base, styles[variant], muted && styles.muted, center && styles.center, style]}>
      {children}
    </Text>
  );
}

const styles = StyleSheet.create({
  base: {
    writingDirection: 'rtl',
    textAlign: 'right',
    color: colors.text,
    lineHeight: 24,
  },
  hero: {
    fontSize: typography.hero,
    lineHeight: 40,
    fontWeight: '900',
    color: colors.primary,
  },
  title: {
    fontSize: typography.title,
    lineHeight: 30,
    fontWeight: '800',
    color: colors.primary,
  },
  body: {
    fontSize: typography.body,
    fontWeight: '600',
  },
  caption: {
    fontSize: typography.caption,
    lineHeight: 20,
    fontWeight: '600',
  },
  tiny: {
    fontSize: typography.tiny,
    lineHeight: 18,
    fontWeight: '600',
  },
  muted: {
    color: colors.muted,
  },
  center: {
    textAlign: 'center',
  },
});
