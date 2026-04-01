import React from "react";
import {
  View,
  TextInput,
  TouchableOpacity,
  StyleSheet,
  Platform,
} from "react-native";
import { useTheme } from "../../contexts/ThemeContext";
import { Icon } from "./Icon";
import { Spacing, BorderRadius, Typography } from "../../constants/theme";

interface SearchBarProps {
  value: string;
  onChangeText: (text: string) => void;
  placeholder?: string;
  onClear?: () => void;
  autoFocus?: boolean;
}

export function SearchBar({
  value,
  onChangeText,
  placeholder,
  onClear,
  autoFocus,
}: SearchBarProps) {
  const { colors } = useTheme();

  const handleClear = () => {
    onChangeText("");
    onClear?.();
  };

  return (
    <View
      style={[
        styles.container,
        { backgroundColor: colors.backgroundSecondary },
      ]}
    >
      <Icon name="magnify" size={18} color={colors.textTertiary} />
      <TextInput
        style={[styles.input, { color: colors.text }]}
        placeholder={placeholder}
        placeholderTextColor={colors.textTertiary}
        value={value}
        onChangeText={onChangeText}
        returnKeyType="search"
        autoFocus={autoFocus}
        maxFontSizeMultiplier={1.2}
        clearButtonMode={Platform.OS === "ios" ? "while-editing" : "never"}
      />
      {value.length > 0 && Platform.OS !== "ios" && (
        <TouchableOpacity
          onPress={handleClear}
          hitSlop={{ top: 8, bottom: 8, left: 8, right: 8 }}
        >
          <Icon name="close-circle" size={18} color={colors.textTertiary} />
        </TouchableOpacity>
      )}
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flexDirection: "row",
    alignItems: "center",
    borderRadius: BorderRadius.md,
    height: 36,
    paddingHorizontal: Spacing.md - 4,
    gap: 8,
  },
  input: {
    flex: 1,
    ...Typography.body,
    fontSize: 15,
    paddingVertical: 0,
  },
});
