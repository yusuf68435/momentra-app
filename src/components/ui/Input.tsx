import React, { useState } from 'react';
import { View, TextInput, Text, StyleSheet, ViewStyle } from 'react-native';
import { BorderRadius, Spacing, Typography } from '../../constants/theme';
import { useTheme } from '../../contexts/ThemeContext';

interface InputProps {
  label?: string;
  placeholder?: string;
  value: string;
  onChangeText: (text: string) => void;
  error?: string;
  secureTextEntry?: boolean;
  keyboardType?: 'default' | 'email-address' | 'numeric' | 'phone-pad';
  multiline?: boolean;
  numberOfLines?: number;
  style?: ViewStyle;
  editable?: boolean;
  autoCapitalize?: 'none' | 'sentences' | 'words' | 'characters';
}

export function Input({
  label,
  placeholder,
  value,
  onChangeText,
  error,
  secureTextEntry,
  keyboardType = 'default',
  multiline = false,
  numberOfLines = 1,
  style,
  editable = true,
  autoCapitalize = 'sentences',
}: InputProps) {
  const [isFocused, setIsFocused] = useState(false);
  const { colors } = useTheme();

  return (
    <View style={[styles.container, style]}>
      {label && <Text style={[styles.label, { color: colors.text }]}>{label}</Text>}
      <TextInput
        style={[
          styles.input,
          {
            backgroundColor: colors.surfaceVariant,
            borderColor: colors.border,
            color: colors.text,
          },
          isFocused && { borderColor: colors.primary, backgroundColor: colors.surface },
          error && { borderColor: colors.error },
          multiline && styles.multiline,
          !editable && styles.disabled,
        ]}
        placeholder={placeholder}
        placeholderTextColor={colors.textTertiary}
        value={value}
        onChangeText={onChangeText}
        secureTextEntry={secureTextEntry}
        keyboardType={keyboardType}
        multiline={multiline}
        numberOfLines={numberOfLines}
        editable={editable}
        autoCapitalize={autoCapitalize}
        onFocus={() => setIsFocused(true)}
        onBlur={() => setIsFocused(false)}
      />
      {error && <Text style={[styles.error, { color: colors.error }]} accessibilityRole="alert" accessibilityLiveRegion="assertive">{error}</Text>}
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    marginBottom: Spacing.md,
  },
  label: {
    ...Typography.bodySmall,
    fontWeight: '600',
    marginBottom: Spacing.xs,
  },
  input: {
    ...Typography.body,
    borderRadius: BorderRadius.md,
    borderWidth: 1.5,
    paddingHorizontal: Spacing.md,
    paddingVertical: Spacing.md - 4,
  },
  multiline: {
    textAlignVertical: 'top',
    minHeight: 100,
  },
  disabled: {
    opacity: 0.6,
  },
  error: {
    ...Typography.caption,
    marginTop: Spacing.xs,
  },
});
