import React, { Component, type ReactNode } from "react";
import { View, Text, TouchableOpacity, StyleSheet } from "react-native";
import { useTranslation } from "react-i18next";
import { captureError } from "../../utils/errorTracking";
import { useTheme } from "../../contexts/ThemeContext";
import {
  BorderRadius,
  Spacing,
  Typography,
  type ThemeColors,
} from "../../constants/theme";

interface Props {
  children: ReactNode;
  fallbackTitle?: string;
  fallbackMessage?: string;
}

interface State {
  hasError: boolean;
  error: Error | null;
}

// Functional fallback UI — can use hooks
function ErrorFallback({
  error,
  onRetry,
  fallbackTitle,
  fallbackMessage,
}: {
  error: Error | null;
  onRetry: () => void;
  fallbackTitle?: string;
  fallbackMessage?: string;
}) {
  const { t } = useTranslation();
  const { colors } = useTheme();
  const styles = createStyles(colors);

  return (
    <View style={styles.container}>
      <Text style={styles.emoji}>:(</Text>
      <Text style={styles.title}>{fallbackTitle ?? t("common.error")}</Text>
      <Text style={styles.message}>
        {fallbackMessage ?? t("common.error_screen")}
      </Text>
      {__DEV__ && error && <Text style={styles.debug}>{error.message}</Text>}
      <TouchableOpacity style={styles.button} onPress={onRetry}>
        <Text style={styles.buttonText}>{t("common.retry")}</Text>
      </TouchableOpacity>
    </View>
  );
}

export class ScreenErrorBoundary extends Component<Props, State> {
  constructor(props: Props) {
    super(props);
    this.state = { hasError: false, error: null };
  }

  static getDerivedStateFromError(error: Error): State {
    return { hasError: true, error };
  }

  componentDidCatch(error: Error, errorInfo: React.ErrorInfo): void {
    captureError(error, {
      component: "ScreenErrorBoundary",
      componentStack: errorInfo.componentStack ?? undefined,
    });
  }

  handleRetry = (): void => {
    this.setState({ hasError: false, error: null });
  };

  render(): ReactNode {
    if (this.state.hasError) {
      return (
        <ErrorFallback
          error={this.state.error}
          onRetry={this.handleRetry}
          fallbackTitle={this.props.fallbackTitle}
          fallbackMessage={this.props.fallbackMessage}
        />
      );
    }
    return this.props.children;
  }
}

const createStyles = (colors: ThemeColors) =>
  StyleSheet.create({
    container: {
      flex: 1,
      alignItems: "center",
      justifyContent: "center",
      padding: Spacing.xl,
      backgroundColor: colors.background,
    },
    emoji: {
      ...Typography.h1,
      fontSize: 48,
      marginBottom: Spacing.md,
      color: colors.textSecondary,
    },
    title: {
      ...Typography.h3,
      color: colors.text,
      marginBottom: Spacing.sm,
      textAlign: "center",
    },
    message: {
      ...Typography.body,
      color: colors.textSecondary,
      textAlign: "center",
      marginBottom: Spacing.xl,
      paddingHorizontal: Spacing.xl,
    },
    debug: {
      fontSize: 11,
      color: colors.textTertiary,
      textAlign: "center",
      marginBottom: Spacing.md,
      paddingHorizontal: Spacing.md,
      fontFamily: "monospace",
    },
    button: {
      backgroundColor: colors.primary,
      paddingHorizontal: Spacing.xl,
      paddingVertical: Spacing.md,
      borderRadius: BorderRadius.lg,
    },
    buttonText: {
      ...Typography.button,
      color: colors.textOnPrimary,
    },
  });
