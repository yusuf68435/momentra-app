import React, { useState } from "react";
import {
  View,
  Text,
  TextInput,
  TouchableOpacity,
  StyleSheet,
} from "react-native";
import { useTranslation } from "react-i18next";
import { Icon } from "../ui/Icon";
import type { IconName } from "../../constants/icons";
import { useTheme } from "../../contexts/ThemeContext";
import { Spacing, Typography, BorderRadius } from "../../constants/theme";
import { Button } from "../ui/Button";
import { Modal } from "../ui/Modal";
import { hapticSelection, hapticSuccess } from "../../utils/haptics";

type InviteRole = "editor" | "viewer";

interface InviteModalProps {
  visible: boolean;
  onClose: () => void;
  onSend: (data: { email: string; role: InviteRole }) => void;
}

const EMAIL_REGEX = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

interface RoleOption {
  value: InviteRole;
  icon: IconName;
  labelKey: string;
  descKey: string;
  colorToken: "info" | "textSecondary";
}

const ROLE_OPTIONS: RoleOption[] = [
  {
    value: "editor",
    icon: "pencil",
    labelKey: "coOrganizers.roleEditor",
    descKey: "coOrganizers.roleEditorDesc",
    colorToken: "info",
  },
  {
    value: "viewer",
    icon: "eye",
    labelKey: "coOrganizers.roleViewer",
    descKey: "coOrganizers.roleViewerDesc",
    colorToken: "textSecondary",
  },
];

export function InviteModal({ visible, onClose, onSend }: InviteModalProps) {
  const { colors } = useTheme();
  const { t } = useTranslation();
  const [email, setEmail] = useState("");
  const [role, setRole] = useState<InviteRole>("editor");
  const [emailError, setEmailError] = useState("");

  const validateEmail = (value: string) => {
    setEmail(value);
    if (value.trim() && !EMAIL_REGEX.test(value.trim())) {
      setEmailError(t("coOrganizers.invalidEmail"));
    } else {
      setEmailError("");
    }
  };

  const handleSend = () => {
    const trimmedEmail = email.trim().toLowerCase();
    if (!EMAIL_REGEX.test(trimmedEmail)) {
      setEmailError(t("coOrganizers.invalidEmail"));
      return;
    }

    hapticSuccess();
    onSend({ email: trimmedEmail, role });

    setEmail("");
    setRole("editor");
    setEmailError("");
  };

  const isValid = EMAIL_REGEX.test(email.trim());

  return (
    <Modal
      visible={visible}
      onClose={onClose}
      title={t("coOrganizers.inviteModalTitle")}
    >
      <Text style={[styles.label, { color: colors.textSecondary }]}>
        {t("coOrganizers.emailLabel")}
      </Text>
      <TextInput
        style={[
          styles.input,
          { backgroundColor: colors.surfaceVariant, color: colors.text },
          emailError ? { borderWidth: 1, borderColor: colors.error } : null,
        ]}
        value={email}
        onChangeText={validateEmail}
        placeholder={t("coOrganizers.emailPlaceholder")}
        placeholderTextColor={colors.textTertiary}
        keyboardType="email-address"
        autoCapitalize="none"
        autoCorrect={false}
      />
      {emailError ? (
        <Text style={[styles.errorText, { color: colors.error }]}>
          {emailError}
        </Text>
      ) : null}

      <Text style={[styles.label, { color: colors.textSecondary }]}>
        {t("coOrganizers.roleLabel")}
      </Text>
      <View style={styles.roleGrid}>
        {ROLE_OPTIONS.map((option) => {
          const optionColor = colors[option.colorToken];
          const isSelected = role === option.value;
          return (
            <TouchableOpacity
              key={option.value}
              style={[
                styles.roleCard,
                {
                  borderColor: isSelected ? optionColor : colors.border,
                },
                isSelected && {
                  backgroundColor: optionColor + "10",
                },
              ]}
              onPress={() => {
                hapticSelection();
                setRole(option.value);
              }}
            >
              <Icon name={option.icon} size={24} color={optionColor} />
              <Text
                style={[
                  styles.roleLabel,
                  {
                    color: isSelected ? optionColor : colors.text,
                  },
                ]}
              >
                {t(option.labelKey)}
              </Text>
              <Text style={[styles.roleDesc, { color: colors.textSecondary }]}>
                {t(option.descKey)}
              </Text>
            </TouchableOpacity>
          );
        })}
      </View>

      <Button
        title={t("coOrganizers.sendInvite")}
        onPress={handleSend}
        disabled={!isValid}
        style={{ marginTop: Spacing.lg }}
      />
    </Modal>
  );
}

const styles = StyleSheet.create({
  label: {
    ...Typography.caption,
    fontWeight: "600",
    marginBottom: Spacing.xs,
    marginTop: Spacing.md,
  },
  input: {
    borderRadius: BorderRadius.md,
    padding: Spacing.md,
    ...Typography.body,
  },
  errorText: {
    ...Typography.caption,
    marginTop: Spacing.xs,
  },
  roleGrid: {
    flexDirection: "row",
    gap: Spacing.sm,
  },
  roleCard: {
    flex: 1,
    alignItems: "center",
    padding: Spacing.md,
    borderRadius: BorderRadius.md,
    borderWidth: 1.5,
    gap: Spacing.xs,
  },
  roleLabel: {
    ...Typography.bodySmall,
    fontWeight: "600",
  },
  roleDesc: {
    ...Typography.caption,
    textAlign: "center",
  },
});
