import React from "react";
import {
  View,
  Text,
  TouchableOpacity,
  StyleSheet,
  Dimensions,
} from "react-native";
import Animated, { FadeInUp } from "react-native-reanimated";
import { LinearGradient } from "expo-linear-gradient";
import { useTheme } from "../../contexts/ThemeContext";
import { Icon } from "../ui/Icon";
import {
  Spacing,
  Typography,
  BorderRadius,
  Gradients,
} from "../../constants/theme";

interface ChatBubbleProps {
  role: "user" | "assistant";
  content: string;
  timestamp?: string;
  actions?: Array<{ label: string; onPress: () => void }>;
}

const SCREEN_WIDTH = Dimensions.get("window").width;
const MAX_BUBBLE_WIDTH = SCREEN_WIDTH * 0.8;

export function ChatBubble({
  role,
  content,
  timestamp,
  actions,
}: ChatBubbleProps) {
  const { colors } = useTheme();
  const isUser = role === "user";

  return (
    <Animated.View
      entering={FadeInUp.duration(300)}
      style={[
        styles.wrapper,
        isUser ? styles.wrapperUser : styles.wrapperAssistant,
      ]}
    >
      {!isUser && (
        <View
          style={[styles.avatar, { backgroundColor: colors.primary + "15" }]}
        >
          <Icon name="robot-happy" size={14} color={colors.primary} />
        </View>
      )}

      <View style={{ maxWidth: MAX_BUBBLE_WIDTH }}>
        {isUser ? (
          <LinearGradient
            colors={Gradients.joy}
            start={{ x: 0, y: 0 }}
            end={{ x: 1, y: 1 }}
            style={styles.userBubble}
          >
            <Text style={[styles.contentText, { color: colors.textOnPrimary }]}>
              {content}
            </Text>
          </LinearGradient>
        ) : (
          <View
            style={[
              styles.assistantBubble,
              {
                backgroundColor: colors.surfaceVariant,
                borderLeftColor: colors.primary,
              },
            ]}
          >
            <Text style={[styles.contentText, { color: colors.text }]}>
              {content}
            </Text>
          </View>
        )}

        {actions && actions.length > 0 && (
          <View style={styles.actionsRow}>
            {actions.map((action, i) => (
              <TouchableOpacity
                key={i}
                style={[
                  styles.actionPill,
                  {
                    borderColor: colors.primary + "40",
                    backgroundColor: colors.primary + "08",
                  },
                ]}
                onPress={action.onPress}
                activeOpacity={0.7}
              >
                <Text style={[styles.actionText, { color: colors.primary }]}>
                  {action.label}
                </Text>
              </TouchableOpacity>
            ))}
          </View>
        )}

        {timestamp && (
          <Text
            style={[
              styles.timestamp,
              {
                color: colors.textTertiary,
                textAlign: isUser ? "right" : "left",
              },
            ]}
          >
            {timestamp}
          </Text>
        )}
      </View>
    </Animated.View>
  );
}

const styles = StyleSheet.create({
  wrapper: {
    flexDirection: "row",
    marginBottom: Spacing.md,
    alignItems: "flex-end",
  },
  wrapperUser: {
    justifyContent: "flex-end",
  },
  wrapperAssistant: {
    justifyContent: "flex-start",
  },
  avatar: {
    width: 24,
    height: 24,
    borderRadius: 12,
    alignItems: "center",
    justifyContent: "center",
    marginRight: Spacing.sm,
    marginBottom: 2,
  },
  userBubble: {
    padding: Spacing.md,
    borderTopLeftRadius: 16,
    borderTopRightRadius: 16,
    borderBottomLeftRadius: 16,
    borderBottomRightRadius: 4,
  },
  assistantBubble: {
    padding: Spacing.md,
    borderTopLeftRadius: 16,
    borderTopRightRadius: 16,
    borderBottomLeftRadius: 4,
    borderBottomRightRadius: 16,
    borderLeftWidth: 3,
  },
  contentText: {
    ...Typography.body,
  },
  actionsRow: {
    flexDirection: "row",
    flexWrap: "wrap",
    gap: Spacing.xs,
    marginTop: Spacing.sm,
  },
  actionPill: {
    paddingHorizontal: Spacing.smd,
    paddingVertical: Spacing.xs + 2,
    borderRadius: BorderRadius.full,
    borderWidth: 1,
  },
  actionText: {
    ...Typography.caption,
    fontWeight: "600",
  },
  timestamp: {
    ...Typography.label,
    marginTop: Spacing.xs,
  },
});
