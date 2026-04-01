import React from 'react';
import { View, ActivityIndicator, Text, StyleSheet } from 'react-native';
import { Spacing, Typography } from '../../constants/theme';
import { useTheme } from '../../contexts/ThemeContext';

interface LoadingScreenProps {
  message?: string;
}

export function LoadingScreen({ message }: LoadingScreenProps) {
  const { colors } = useTheme();

  return (
    <View style={[styles.container, { backgroundColor: colors.background }]}>
      <ActivityIndicator size="large" color={colors.primary} />
      {message && <Text style={[styles.message, { color: colors.textSecondary }]}>{message}</Text>}
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
  message: {
    ...Typography.body,
    marginTop: Spacing.md,
  },
});
