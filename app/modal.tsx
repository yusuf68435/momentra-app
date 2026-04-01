import { StatusBar } from 'expo-status-bar';
import { Platform, View, Text, StyleSheet } from 'react-native';
import { useTheme } from '../src/contexts/ThemeContext';
import { Spacing, Typography } from '../src/constants/theme';

export default function ModalScreen() {
  const { colors, isDark } = useTheme();

  return (
    <View style={[styles.container, { backgroundColor: colors.background }]}>
      <Text style={[styles.title, { color: colors.text }]}>Modal</Text>
      <View
        style={[
          styles.separator,
          { backgroundColor: colors.border },
        ]}
      />
      <StatusBar style={Platform.OS === 'ios' ? 'light' : 'auto'} />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
  title: {
    ...Typography.h3,
  },
  separator: {
    marginVertical: Spacing.xl,
    height: StyleSheet.hairlineWidth,
    width: '80%',
  },
});
