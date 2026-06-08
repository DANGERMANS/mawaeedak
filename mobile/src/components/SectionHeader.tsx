import { createElement } from 'react';
import { StyleSheet, View } from 'react-native';
import { spacing } from '../theme';
import { AppText } from './AppText';

type SectionHeaderProps = {
  title: string;
  description?: string;
};

export function SectionHeader({ title, description }: SectionHeaderProps) {
  return createElement(
    View,
    { style: styles.container },
    createElement(AppText, { variant: 'title' }, title),
    description ? createElement(AppText, { variant: 'caption', muted: true }, description) : null,
  );
}

const styles = StyleSheet.create({
  container: {
    gap: spacing.xs,
  },
});
