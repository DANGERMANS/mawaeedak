/**
 * Input Component — Mawaeedak Mobile
 */

import React, { useState } from 'react';
import {
  View,
  TextInput,
  Text,
  StyleSheet,
  TouchableOpacity,
  TextInputProps,
} from 'react-native';
import { THEME } from '../constants/theme';

interface InputProps extends TextInputProps {
  label?: string;
  error?: string;
  hint?: string;
  leftIcon?: string;
  rightIcon?: string;
  onRightIconPress?: () => void;
}

export const Input: React.FC<InputProps> = ({
  label,
  error,
  hint,
  leftIcon,
  rightIcon,
  onRightIconPress,
  style,
  ...props
}) => {
  const [isFocused, setIsFocused] = useState(false);

  return (
    <View style={styles.container}>
      {label && <Text style={styles.label}>{label}</Text>}
      
      <View style={[
        styles.inputContainer,
        isFocused && styles.inputContainerFocused,
        error && styles.inputContainerError,
      ]}>
        {leftIcon && <Text style={styles.leftIcon}>{leftIcon}</Text>}
        
        <TextInput
          style={[styles.input, style]}
          placeholderTextColor={THEME.textMuted}
          onFocus={() => setIsFocused(true)}
          onBlur={() => setIsFocused(false)}
          {...props}
        />
        
        {rightIcon && (
          <TouchableOpacity onPress={onRightIconPress} disabled={!onRightIconPress}>
            <Text style={styles.rightIcon}>{rightIcon}</Text>
          </TouchableOpacity>
        )}
      </View>
      
      {error && <Text style={styles.error}>{error}</Text>}
      {hint && !error && <Text style={styles.hint}>{hint}</Text>}
    </View>
  );
};

// Select Component
interface SelectOption {
  label: string;
  value: string;
}

interface SelectProps {
  label?: string;
  options: SelectOption[];
  value?: string;
  onChange: (value: string) => void;
  placeholder?: string;
  error?: string;
}

export const Select: React.FC<SelectProps> = ({
  label,
  options,
  value,
  onChange,
  placeholder = 'اختر...',
  error,
}) => {
  const [isOpen, setIsOpen] = useState(false);
  const selected = options.find(o => o.value === value);

  return (
    <View style={styles.container}>
      {label && <Text style={styles.label}>{label}</Text>}
      
      <TouchableOpacity
        style={[styles.selectContainer, error && styles.inputContainerError]}
        onPress={() => setIsOpen(!isOpen)}
      >
        <Text style={[styles.selectText, !selected && styles.selectPlaceholder]}>
          {selected?.label || placeholder}
        </Text>
        <Text style={styles.selectArrow}>{isOpen ? '▲' : '▼'}</Text>
      </TouchableOpacity>
      
      {isOpen && (
        <View style={styles.selectOptions}>
          {options.map((option) => (
            <TouchableOpacity
              key={option.value}
              style={styles.selectOption}
              onPress={() => {
                onChange(option.value);
                setIsOpen(false);
              }}
            >
              <Text style={[
                styles.selectOptionText,
                value === option.value && styles.selectOptionTextActive
              ]}>
                {option.label}
              </Text>
            </TouchableOpacity>
          ))}
        </View>
      )}
      
      {error && <Text style={styles.error}>{error}</Text>}
    </View>
  );
};

// TextArea Component
interface TextAreaProps extends TextInputProps {
  label?: string;
  error?: string;
  hint?: string;
}

export const TextArea: React.FC<TextAreaProps> = ({
  label,
  error,
  hint,
  style,
  ...props
}) => {
  return (
    <View style={styles.container}>
      {label && <Text style={styles.label}>{label}</Text>}
      
      <View style={[
        styles.inputContainer,
        error && styles.inputContainerError,
      ]}>
        <TextInput
          style={[styles.input, styles.textArea, style]}
          placeholderTextColor={THEME.textMuted}
          multiline
          numberOfLines={4}
          textAlignVertical="top"
          {...props}
        />
      </View>
      
      {error && <Text style={styles.error}>{error}</Text>}
      {hint && !error && <Text style={styles.hint}>{hint}</Text>}
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    marginBottom: THEME.spacing.md,
  },
  
  label: {
    fontSize: THEME.fontSize.sm,
    fontWeight: THEME.fontWeight.medium,
    color: THEME.text,
    marginBottom: THEME.spacing.xs,
  },
  
  inputContainer: {
    flexDirection: 'row-reverse',
    alignItems: 'center',
    backgroundColor: THEME.surface,
    borderWidth: 1,
    borderColor: THEME.border,
    borderRadius: THEME.radius.md,
    paddingHorizontal: THEME.spacing.md,
  },
  inputContainerFocused: {
    borderColor: THEME.primary,
    borderWidth: 2,
  },
  inputContainerError: {
    borderColor: THEME.error,
  },
  
  input: {
    flex: 1,
    fontSize: THEME.fontSize.md,
    color: THEME.text,
    paddingVertical: THEME.spacing.sm + 4,
    textAlign: 'right',
  },
  
  textArea: {
    minHeight: 100,
    paddingTop: THEME.spacing.sm,
  },
  
  leftIcon: {
    fontSize: 18,
    marginLeft: THEME.spacing.sm,
    color: THEME.textSecondary,
  },
  
  rightIcon: {
    fontSize: 18,
    marginRight: THEME.spacing.sm,
    color: THEME.textSecondary,
  },
  
  error: {
    fontSize: THEME.fontSize.sm,
    color: THEME.error,
    marginTop: THEME.spacing.xs,
  },
  
  hint: {
    fontSize: THEME.fontSize.sm,
    color: THEME.textSecondary,
    marginTop: THEME.spacing.xs,
  },
  
  // Select
  selectContainer: {
    flexDirection: 'row-reverse',
    alignItems: 'center',
    justifyContent: 'space-between',
    backgroundColor: THEME.surface,
    borderWidth: 1,
    borderColor: THEME.border,
    borderRadius: THEME.radius.md,
    paddingHorizontal: THEME.spacing.md,
    paddingVertical: THEME.spacing.sm + 4,
  },
  selectText: {
    fontSize: THEME.fontSize.md,
    color: THEME.text,
    flex: 1,
    textAlign: 'right',
  },
  selectPlaceholder: {
    color: THEME.textMuted,
  },
  selectArrow: {
    fontSize: 12,
    color: THEME.textSecondary,
    marginRight: THEME.spacing.sm,
  },
  selectOptions: {
    backgroundColor: THEME.surface,
    borderWidth: 1,
    borderColor: THEME.border,
    borderRadius: THEME.radius.md,
    marginTop: THEME.spacing.xs,
    overflow: 'hidden',
  },
  selectOption: {
    paddingVertical: THEME.spacing.sm + 2,
    paddingHorizontal: THEME.spacing.md,
    borderBottomWidth: 1,
    borderBottomColor: THEME.borderLight,
  },
  selectOptionText: {
    fontSize: THEME.fontSize.md,
    color: THEME.text,
    textAlign: 'right',
  },
  selectOptionTextActive: {
    color: THEME.primary,
    fontWeight: THEME.fontWeight.semibold,
  },
});

export default Input;