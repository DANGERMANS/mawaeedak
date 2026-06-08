import { createElement, type PropsWithChildren } from 'react';
import { SafeAreaView, ScrollView, StyleSheet, View } from 'react-native';
import { colors, spacing } from '../theme';

type AppScreenProps = PropsWithChildren<{
  scroll?: boolean;
}>;

export function AppScreen({ children, scroll = true }: AppScreenProps) {
  if (!scroll) {
    return createElement(SafeAreaView, { style: styles.safe }, children);
  }

  return createElement(
    SafeAreaView,
    { style: styles.safe },
    createElement(ScrollView, { contentContainerStyle: styles.content, showsVerticalScrollIndicator: false }, children),
  );
}

export function AppScreenBody({ children }: PropsWithChildren) {
  return createElement(View, { style: styles.body }, children);
}

const styles = StyleSheet.create({
  safe: {
    flex: 1,
    backgroundColor: colors.background,
  },
  content: {
    padding: spacing.lg,
    paddingBottom: 110,
    gap: spacing.md,
  },
  body: {
    gap: spacing.md,
  },
});
