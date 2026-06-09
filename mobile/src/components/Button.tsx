/**
 * Button Component — Mawaeedak Mobile
 */

import React from 'react';
import {
  TouchableOpacity,
  Text,
  StyleSheet,
  ActivityIndicator,
  ViewStyle,
  TextStyle,
} from 'react-native';
import { THEME } from '../constants/theme';

interface ButtonProps {
  title: string;
  onPress: () => void;
  variant?: 'primary' | 'secondary' | 'outline' | 'ghost' | 'danger';
  size?: 'sm' | 'md' | 'lg';
  disabled?: boolean;
  loading?: boolean;
  icon?: string;
  fullWidth?: boolean;
}

export const Button: React.FC<ButtonProps> = ({
  title,
  onPress,
  variant = 'primary',
  size = 'md',
  disabled = false,
  loading = false,
  icon,
  fullWidth = false,
}) => {
  const isDisabled = disabled || loading;

  const containerStyle = [
    styles.container,
    styles[`container_${variant}`],
    styles[`container_${size}`],
    fullWidth ? styles.fullWidth : undefined,
    isDisabled ? styles.disabled : undefined,
  ].filter(Boolean) as ViewStyle[];

  const textStyle = [
    styles.text,
    styles[`text_${variant}`],
    styles[`text_${size}`],
    isDisabled ? styles.textDisabled : undefined,
  ].filter(Boolean) as TextStyle[];

  return (
    <TouchableOpacity
      style={containerStyle}
      onPress={onPress}
      disabled={isDisabled}
      activeOpacity={0.7}
    >
      {loading ? (
        <ActivityIndicator color={variant === 'outline' || variant === 'ghost' ? THEME.primary : '#FFF'} />
      ) : (
        <>
          {icon && <Text style={styles.icon}>{icon}</Text>}
          <Text style={textStyle}>{title}</Text>
        </>
      )}
    </TouchableOpacity>
  );
};

const styles = StyleSheet.create({
  container: {
    flexDirection: 'row-reverse',
    alignItems: 'center',
    justifyContent: 'center',
    borderRadius: THEME.radius.md,
    gap: 8,
  },
  
  // Variants
  container_primary: {
    backgroundColor: THEME.primary,
  },
  container_secondary: {
    backgroundColor: THEME.secondary,
  },
  container_outline: {
    backgroundColor: 'transparent',
    borderWidth: 1.5,
    borderColor: THEME.primary,
  },
  container_ghost: {
    backgroundColor: 'transparent',
  },
  container_danger: {
    backgroundColor: THEME.error,
  },
  
  // Sizes
  container_sm: {
    paddingVertical: 8,
    paddingHorizontal: 16,
  },
  container_md: {
    paddingVertical: 12,
    paddingHorizontal: 20,
  },
  container_lg: {
    paddingVertical: 16,
    paddingHorizontal: 24,
  },
  
  // Disabled
  disabled: {
    opacity: 0.5,
  },
  
  // Full width
  fullWidth: {
    width: '100%',
  },
  
  // Text
  text: {
    fontWeight: THEME.fontWeight.semibold,
  },
  text_primary: {
    color: '#FFFFFF',
  },
  text_secondary: {
    color: '#FFFFFF',
  },
  text_outline: {
    color: THEME.primary,
  },
  text_ghost: {
    color: THEME.primary,
  },
  text_danger: {
    color: '#FFFFFF',
  },
  
  // Text sizes
  text_sm: {
    fontSize: THEME.fontSize.sm,
  },
  text_md: {
    fontSize: THEME.fontSize.md,
  },
  text_lg: {
    fontSize: THEME.fontSize.lg,
  },
  
  // Text disabled
  textDisabled: {
    opacity: 0.7,
  },
  
  // Icon
  icon: {
    fontSize: 18,
  },
});

export default Button;