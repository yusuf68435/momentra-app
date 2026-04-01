import React from 'react';
import { View, Text, TouchableOpacity, StyleSheet } from 'react-native';
import { Icon } from '../ui/Icon';
import { Spacing, Typography, BorderRadius } from '../../constants/theme';
import { useTheme } from '../../contexts/ThemeContext';
import type { ChecklistItem as ChecklistItemType } from '../../types/database';

interface ChecklistItemProps {
  item: ChecklistItemType;
  onToggle: () => void;
}

export function ChecklistItem({ item, onToggle }: ChecklistItemProps) {
  const { colors } = useTheme();

  return (
    <TouchableOpacity
      style={[
        styles.container,
        { backgroundColor: colors.surface, borderColor: colors.borderLight },
      ]}
      onPress={onToggle}
      activeOpacity={0.7}
    >
      <Icon
        name={item.is_completed ? 'checkbox-marked-circle' : 'checkbox-blank-circle-outline'}
        size={24}
        color={item.is_completed ? colors.success : colors.textTertiary}
      />
      <View style={styles.content}>
        <Text
          style={[
            styles.title,
            { color: colors.text },
            item.is_completed && { textDecorationLine: 'line-through', color: colors.textTertiary },
          ]}
          numberOfLines={2}
        >
          {item.title}
        </Text>
        {item.due_date && (
          <Text style={[styles.dueDate, { color: colors.textTertiary }]}>
            {new Date(item.due_date).toLocaleDateString()}
          </Text>
        )}
      </View>
    </TouchableOpacity>
  );
}

const styles = StyleSheet.create({
  container: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: Spacing.md,
    paddingVertical: Spacing.md,
    paddingHorizontal: Spacing.md,
    borderRadius: BorderRadius.md,
    marginBottom: Spacing.sm,
    borderWidth: 1,
  },
  content: {
    flex: 1,
  },
  title: {
    ...Typography.body,
  },
  dueDate: {
    ...Typography.caption,
    marginTop: 2,
  },
});
