import React, {
  useState,
  useCallback,
  useMemo,
  useRef,
  useEffect,
} from "react";
import * as ImagePicker from "expo-image-picker";
import { Audio } from "expo-av";
import {
  View,
  Text,
  ScrollView,
  StyleSheet,
  TouchableOpacity,
  TextInput,
  Modal,
  Alert,
  Image,
  Dimensions,
} from "react-native";
import { LoadingScreen } from "../../../src/components/common/LoadingScreen";
import { useLocalSearchParams } from "expo-router";
import { useTranslation } from "react-i18next";
import { Icon } from "../../../src/components/ui/Icon";
import type { IconName } from "../../../src/constants/icons";
import {
  Spacing,
  Typography,
  BorderRadius,
  Shadows,
  type ThemeColors,
} from "../../../src/constants/theme";
import { useTheme } from "../../../src/contexts/ThemeContext";
import {
  getCapsule,
  createCapsule,
  addMemory,
  removeMemory,
  sealCapsule,
  openCapsule,
} from "../../../src/services/timeCapsule";
import type { CapsuleState } from "../../../src/services/timeCapsule";
import { usePlanStore } from "../../../src/stores/planStore";
import { ScreenErrorBoundary } from "../../../src/components/common/ScreenErrorBoundary";
import { EmptyState } from "../../../src/components/common/EmptyState";

type MemoryType = "photo" | "text" | "voice";

interface Memory {
  id: string;
  type: MemoryType;
  content: string; // text content or URI
  addedAt: string;
}

const SCREEN_WIDTH = Dimensions.get("window").width;

function VoiceMemoryCard({
  memory,
  colors,
  voiceLabel,
  canDelete,
  onDelete,
  styles,
}: {
  memory: Memory;
  colors: ReturnType<typeof import("../../../src/constants/theme").getColors>;
  voiceLabel: string;
  canDelete: boolean;
  onDelete: (id: string) => void;
  styles: ReturnType<typeof createStyles>;
}) {
  const [isPlaying, setIsPlaying] = useState(false);
  const soundRef = useRef<import("expo-av").Audio.Sound | null>(null);

  const handlePlay = useCallback(async () => {
    if (isPlaying) {
      await soundRef.current?.pauseAsync();
      setIsPlaying(false);
      return;
    }
    try {
      if (soundRef.current) {
        await soundRef.current.playAsync();
      } else {
        const { sound } = await Audio.Sound.createAsync({
          uri: memory.content,
        });
        soundRef.current = sound;
        sound.setOnPlaybackStatusUpdate((s) => {
          if (s.isLoaded && s.didJustFinish) {
            setIsPlaying(false);
          }
        });
        await sound.playAsync();
      }
      setIsPlaying(true);
    } catch {
      setIsPlaying(false);
    }
  }, [isPlaying, memory.content]);

  return (
    <View
      style={[
        styles.memoryCard,
        styles.voiceMemoryCard,
        { backgroundColor: colors.accent + "10" },
      ]}
    >
      <TouchableOpacity onPress={handlePlay}>
        <Icon
          name={isPlaying ? "pause" : "play"}
          size={28}
          color={colors.accent}
        />
      </TouchableOpacity>
      <Text style={[styles.voiceLabel, { color: colors.accent }]}>
        {voiceLabel}
      </Text>
      {canDelete && (
        <TouchableOpacity
          style={[styles.memoryDelete, { backgroundColor: colors.error }]}
          onPress={() => onDelete(memory.id)}
        >
          <Icon name="close" size={12} color="#FFF" />
        </TouchableOpacity>
      )}
    </View>
  );
}

function getCountdown(targetDate: Date): string {
  const now = new Date();
  const diff = targetDate.getTime() - now.getTime();
  if (diff <= 0) return "0";
  const days = Math.floor(diff / (1000 * 60 * 60 * 24));
  const hours = Math.floor((diff % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
  return `${days}d ${hours}h`;
}

export default function CapsuleScreen() {
  const { id } = useLocalSearchParams<{ id: string }>();
  const { t } = useTranslation();
  const { colors } = useTheme();
  const activePlan = usePlanStore((s) => s.activePlan);

  const [isLoading, setIsLoading] = useState(true);
  const [capsuleId, setCapsuleId] = useState<string | null>(null);
  const [status, setStatus] = useState<CapsuleState>("collecting");
  const [memories, setMemories] = useState<Memory[]>([]);
  const [showAddTextModal, setShowAddTextModal] = useState(false);
  const [showSealModal, setShowSealModal] = useState(false);
  const [textInput, setTextInput] = useState("");
  const [sealDate, setSealDate] = useState("");
  const [unlockDate, setUnlockDate] = useState<Date | null>(null);
  const [isRecording, setIsRecording] = useState(false);
  const [recordingSeconds, setRecordingSeconds] = useState(0);
  const recordingRef = useRef<Audio.Recording | null>(null);
  const recordingTimerRef = useRef<ReturnType<typeof setInterval> | null>(null);

  useEffect(() => {
    if (!id) return;
    setIsLoading(true);
    getCapsule(id)
      .then((capsule) => {
        if (capsule) {
          setCapsuleId(capsule.id);
          setStatus(capsule.state);
          setUnlockDate(capsule.open_date ? new Date(capsule.open_date) : null);
          setMemories(
            (capsule.memories ?? [])
              .filter(
                (m): m is typeof m & { type: MemoryType } =>
                  m.type === "photo" || m.type === "text" || m.type === "voice",
              )
              .map((m) => ({
                id: m.id,
                type: m.type,
                content:
                  m.type === "text" ? (m.content ?? "") : (m.media_url ?? ""),
                addedAt: m.created_at,
              })),
          );
        }
      })
      .catch(() => {})
      .finally(() => setIsLoading(false));
  }, [id]);

  const ensureCapsule = useCallback(async (): Promise<string | null> => {
    if (capsuleId) return capsuleId;
    try {
      const capsule = await createCapsule(id, {
        title: activePlan?.title ?? "Time Capsule",
      });
      setCapsuleId(capsule.id);
      return capsule.id;
    } catch {
      return null;
    }
  }, [capsuleId, id, activePlan]);

  const statusConfig: Record<CapsuleState, { color: string; icon: string }> = {
    collecting: { color: colors.info, icon: "inbox-arrow-down" },
    sealed: { color: colors.warning, icon: "lock" },
    opened: { color: colors.success, icon: "lock-open-variant" },
  };

  const handleAddPhoto = useCallback(async () => {
    const permission = await ImagePicker.requestMediaLibraryPermissionsAsync();
    if (!permission.granted) {
      Alert.alert(
        t("capsule.permissionRequired"),
        t("capsule.galleryPermission"),
      );
      return;
    }
    const result = await ImagePicker.launchImageLibraryAsync({
      allowsEditing: true,
      quality: 0.8,
    });
    if (!result.canceled && result.assets[0]?.uri) {
      const uri = result.assets[0].uri;
      try {
        const cid = await ensureCapsule();
        if (!cid) {
          Alert.alert(t("capsule.errorTitle"), t("capsule.saveFailed"));
          return;
        }
        const saved = await addMemory(cid, { type: "photo", media_uri: uri });
        if (saved) {
          const memory: Memory = {
            id: saved.id,
            type: "photo",
            content: saved.media_url ?? uri,
            addedAt: saved.created_at,
          };
          setMemories((prev) => [...prev, memory]);
        } else {
          Alert.alert(t("capsule.errorTitle"), t("capsule.saveFailed"));
        }
      } catch {
        Alert.alert(t("capsule.errorTitle"), t("capsule.saveFailed"));
      }
    }
  }, [t, ensureCapsule]);

  const handleAddText = useCallback(async () => {
    if (!textInput.trim()) return;
    const text = textInput.trim();
    try {
      const cid = await ensureCapsule();
      if (!cid) {
        Alert.alert(t("capsule.errorTitle"), t("capsule.saveFailed"));
        return;
      }
      const saved = await addMemory(cid, { type: "text", content: text });
      if (saved) {
        const memory: Memory = {
          id: saved.id,
          type: "text",
          content: saved.content ?? text,
          addedAt: saved.created_at,
        };
        setMemories((prev) => [...prev, memory]);
        setShowAddTextModal(false);
        setTextInput("");
      } else {
        Alert.alert(t("capsule.errorTitle"), t("capsule.saveFailed"));
      }
    } catch {
      Alert.alert(t("capsule.errorTitle"), t("capsule.saveFailed"));
    }
  }, [textInput, t, ensureCapsule]);

  const handleStartRecording = useCallback(async () => {
    try {
      const { granted } = await Audio.requestPermissionsAsync();
      if (!granted) {
        Alert.alert(
          t("capsule.permissionRequired"),
          t("capsule.microphonePermission"),
        );
        return;
      }
      await Audio.setAudioModeAsync({
        allowsRecordingIOS: true,
        playsInSilentModeIOS: true,
      });
      const { recording } = await Audio.Recording.createAsync(
        Audio.RecordingOptionsPresets.HIGH_QUALITY,
      );
      recordingRef.current = recording;
      setIsRecording(true);
      setRecordingSeconds(0);
      recordingTimerRef.current = setInterval(() => {
        setRecordingSeconds((s) => s + 1);
      }, 1000);
    } catch {
      Alert.alert(t("capsule.errorTitle"), t("capsule.recordingFailed"));
    }
  }, [t]);

  const handleStopRecording = useCallback(async () => {
    if (!recordingRef.current) return;
    let uri: string | null = null;
    try {
      if (recordingTimerRef.current) {
        clearInterval(recordingTimerRef.current);
        recordingTimerRef.current = null;
      }
      await recordingRef.current.stopAndUnloadAsync();
      uri = recordingRef.current.getURI() ?? null;
      recordingRef.current = null;
      setIsRecording(false);
    } catch {
      setIsRecording(false);
      recordingRef.current = null;
    }
    await Audio.setAudioModeAsync({ allowsRecordingIOS: false });

    if (!uri) return;
    const localUri = uri;
    try {
      const cid = await ensureCapsule();
      if (!cid) {
        Alert.alert(t("capsule.errorTitle"), t("capsule.saveFailed"));
        return;
      }
      const saved = await addMemory(cid, {
        type: "voice",
        media_uri: localUri,
      });
      if (saved) {
        const memory: Memory = {
          id: saved.id,
          type: "voice",
          content: saved.media_url ?? localUri,
          addedAt: saved.created_at,
        };
        setMemories((prev) => [...prev, memory]);
      } else {
        Alert.alert(t("capsule.errorTitle"), t("capsule.saveFailed"));
      }
    } catch {
      Alert.alert(t("capsule.errorTitle"), t("capsule.saveFailed"));
    }
  }, [t, ensureCapsule]);

  const handleSealCapsule = useCallback(async () => {
    if (!sealDate.trim()) {
      Alert.alert(t("capsule.dateRequired"), t("capsule.enterDate"));
      return;
    }
    try {
      const cid = await ensureCapsule();
      if (!cid) {
        Alert.alert(t("capsule.errorTitle"), t("capsule.saveFailed"));
        return;
      }
      await sealCapsule(cid);
      setUnlockDate(new Date(sealDate));
      setStatus("sealed");
      setShowSealModal(false);
      setSealDate("");
    } catch {
      Alert.alert(t("capsule.errorTitle"), t("capsule.saveFailed"));
    }
  }, [sealDate, t, ensureCapsule]);

  const handleOpenCapsule = useCallback(async () => {
    if (unlockDate) {
      const now = new Date();
      if (now < unlockDate) {
        Alert.alert(
          t("capsule.notYet"),
          t("capsule.willOpen", { unlockDate: unlockDate.toISOString() }),
        );
        return;
      }
    }
    try {
      const cid = capsuleId ?? (await ensureCapsule());
      if (!cid) {
        Alert.alert(t("capsule.errorTitle"), t("capsule.saveFailed"));
        return;
      }
      await openCapsule(cid);
      setStatus("opened");
    } catch {
      Alert.alert(t("capsule.errorTitle"), t("capsule.saveFailed"));
    }
  }, [unlockDate, t, capsuleId, ensureCapsule]);

  const handleDeleteMemory = useCallback(
    async (memoryId: string) => {
      try {
        await removeMemory(memoryId);
        setMemories((prev) => prev.filter((m) => m.id !== memoryId));
      } catch {
        Alert.alert(t("capsule.errorTitle"), t("capsule.saveFailed"));
      }
    },
    [t],
  );

  const cfg = statusConfig[status];
  const styles = useMemo(() => createStyles(colors), [colors]);

  const photoCount = memories.filter((m) => m.type === "photo").length;
  const textCount = memories.filter((m) => m.type === "text").length;
  const voiceCount = memories.filter((m) => m.type === "voice").length;

  const unlockDateString = unlockDate ? unlockDate.toISOString() : "";

  if (isLoading) {
    return <LoadingScreen />;
  }

  return (
    <ScreenErrorBoundary>
      <ScrollView
        style={styles.container}
        contentContainerStyle={styles.content}
        showsVerticalScrollIndicator={false}
      >
        {/* Header */}
        <View style={styles.header}>
          <View style={styles.headerRow}>
            <Text style={[styles.headerTitle, { color: colors.text }]}>
              {t("capsule.title")}
            </Text>
            <View
              style={[
                styles.statusBadge,
                { backgroundColor: cfg.color + "20" },
              ]}
            >
              <Icon name={cfg.icon as IconName} size={14} color={cfg.color} />
              <Text style={[styles.statusText, { color: cfg.color }]}>
                {t(`capsule.${status}`)}
              </Text>
            </View>
          </View>
          <Text style={[styles.memoryCount, { color: colors.textSecondary }]}>
            {memories.length} {t("capsule.memories")} ({photoCount}{" "}
            {t("capsule.photos")}, {textCount} {t("capsule.notes")},{" "}
            {voiceCount} {t("capsule.voice")})
          </Text>
        </View>

        {/* Sealed State */}
        {status === "sealed" && (
          <View
            style={[styles.sealedCard, { backgroundColor: colors.surface }]}
          >
            <Icon name="lock" size={56} color={colors.warning} />
            <Text style={[styles.sealedTitle, { color: colors.text }]}>
              {t("capsule.sealedTitle")}
            </Text>
            <Text style={[styles.sealedCountdown, { color: colors.warning }]}>
              {unlockDate ? getCountdown(unlockDate) : "0"}
            </Text>
            <Text style={[styles.sealedDate, { color: colors.textSecondary }]}>
              {t("capsule.opensOn", { unlockDate: unlockDateString })}
            </Text>
            <TouchableOpacity
              style={[styles.openButton, { backgroundColor: colors.success }]}
              onPress={handleOpenCapsule}
            >
              <Icon name="lock-open-variant" size={20} color="#FFF" />
              <Text style={styles.openButtonText}>
                {t("capsule.openCapsule")}
              </Text>
            </TouchableOpacity>
          </View>
        )}

        {/* Opened State - Reveal */}
        {status === "opened" && (
          <View
            style={[
              styles.openedBanner,
              {
                backgroundColor: colors.success + "12",
                borderColor: colors.success + "30",
              },
            ]}
          >
            <Icon name="party-popper" size={22} color={colors.success} />
            <Text style={[styles.openedText, { color: colors.success }]}>
              {t("capsule.openedMessage")}
            </Text>
          </View>
        )}

        {/* Add Memories (only in collecting state) */}
        {status === "collecting" && (
          <View style={styles.addSection}>
            <Text style={[styles.sectionTitle, { color: colors.text }]}>
              {t("capsule.addMemories")}
            </Text>
            <View style={styles.addButtons}>
              <TouchableOpacity
                style={[
                  styles.addBtn,
                  { backgroundColor: colors.primary + "12" },
                ]}
                onPress={handleAddPhoto}
              >
                <Icon name="camera" size={28} color={colors.primary} />
                <Text style={[styles.addBtnText, { color: colors.primary }]}>
                  {t("capsule.photo")}
                </Text>
              </TouchableOpacity>
              <TouchableOpacity
                style={[styles.addBtn, { backgroundColor: colors.info + "12" }]}
                onPress={() => setShowAddTextModal(true)}
              >
                <Icon name="note-text" size={28} color={colors.info} />
                <Text style={[styles.addBtnText, { color: colors.info }]}>
                  {t("capsule.note")}
                </Text>
              </TouchableOpacity>
              <TouchableOpacity
                style={[
                  styles.addBtn,
                  {
                    backgroundColor: isRecording
                      ? colors.error + "18"
                      : colors.accent + "12",
                  },
                ]}
                onPress={
                  isRecording ? handleStopRecording : handleStartRecording
                }
              >
                <Icon
                  name={isRecording ? "stop" : "microphone"}
                  size={28}
                  color={isRecording ? colors.error : colors.accent}
                />
                <Text
                  style={[
                    styles.addBtnText,
                    { color: isRecording ? colors.error : colors.accent },
                  ]}
                >
                  {isRecording ? `${recordingSeconds}s` : t("capsule.voice")}
                </Text>
              </TouchableOpacity>
            </View>
          </View>
        )}

        {/* Memory Grid */}
        {(status === "collecting" || status === "opened") &&
          memories.length > 0 && (
            <View style={styles.memorySection}>
              <Text style={[styles.sectionTitle, { color: colors.text }]}>
                {t("capsule.memories")}
              </Text>
              <View style={styles.memoryGrid}>
                {memories.map((memory) => (
                  <View key={memory.id} style={styles.memoryItem}>
                    {memory.type === "photo" && (
                      <View
                        style={[
                          styles.memoryCard,
                          { backgroundColor: colors.surface },
                        ]}
                      >
                        <Image
                          source={{ uri: memory.content }}
                          style={styles.memoryImage}
                        />
                        {status === "collecting" && (
                          <TouchableOpacity
                            style={[
                              styles.memoryDelete,
                              { backgroundColor: colors.error },
                            ]}
                            onPress={() => handleDeleteMemory(memory.id)}
                          >
                            <Icon name="close" size={12} color="#FFF" />
                          </TouchableOpacity>
                        )}
                      </View>
                    )}
                    {memory.type === "text" && (
                      <View
                        style={[
                          styles.memoryCard,
                          styles.textMemoryCard,
                          { backgroundColor: colors.info + "10" },
                        ]}
                      >
                        <Icon name="note-text" size={18} color={colors.info} />
                        <Text
                          style={[styles.textMemory, { color: colors.text }]}
                          numberOfLines={4}
                        >
                          {memory.content}
                        </Text>
                        {status === "collecting" && (
                          <TouchableOpacity
                            style={[
                              styles.memoryDelete,
                              { backgroundColor: colors.error },
                            ]}
                            onPress={() => handleDeleteMemory(memory.id)}
                          >
                            <Icon name="close" size={12} color="#FFF" />
                          </TouchableOpacity>
                        )}
                      </View>
                    )}
                    {memory.type === "voice" && (
                      <VoiceMemoryCard
                        memory={memory}
                        colors={colors}
                        voiceLabel={t("capsule.voiceNote")}
                        canDelete={status === "collecting"}
                        onDelete={handleDeleteMemory}
                        styles={styles}
                      />
                    )}
                  </View>
                ))}
              </View>
            </View>
          )}

        {/* Seal Button (only in collecting state) */}
        {status === "collecting" && memories.length > 0 && (
          <TouchableOpacity
            style={[styles.sealButton, { backgroundColor: colors.warning }]}
            onPress={() => setShowSealModal(true)}
            activeOpacity={0.8}
          >
            <Icon name="lock" size={22} color="#FFF" />
            <Text style={styles.sealButtonText}>
              {t("capsule.sealCapsule")}
            </Text>
          </TouchableOpacity>
        )}

        {/* Empty State */}
        {memories.length === 0 && status === "collecting" && (
          <EmptyState
            emoji="⏳"
            title={t("capsule.emptyTitle")}
            description={t("capsule.emptyDescription")}
            compact
          />
        )}

        {/* Add Text Modal */}
        <Modal visible={showAddTextModal} animationType="slide" transparent>
          <View style={styles.modalOverlay}>
            <View
              style={[styles.modalContent, { backgroundColor: colors.surface }]}
            >
              <View style={styles.modalHeader}>
                <Text style={[styles.modalTitle, { color: colors.text }]}>
                  {t("capsule.addNote")}
                </Text>
                <TouchableOpacity onPress={() => setShowAddTextModal(false)}>
                  <Icon name="close" size={24} color={colors.text} />
                </TouchableOpacity>
              </View>
              <TextInput
                style={[
                  styles.textArea,
                  {
                    color: colors.text,
                    backgroundColor: colors.backgroundSecondary,
                    borderColor: colors.borderLight,
                  },
                ]}
                value={textInput}
                onChangeText={setTextInput}
                placeholder={t("capsule.notePlaceholder")}
                placeholderTextColor={colors.textTertiary}
                multiline
                textAlignVertical="top"
                autoFocus
              />
              <TouchableOpacity
                style={[
                  styles.saveButton,
                  {
                    backgroundColor: textInput.trim()
                      ? colors.primary
                      : colors.borderLight,
                  },
                ]}
                onPress={handleAddText}
                disabled={!textInput.trim()}
              >
                <Text
                  style={[
                    styles.saveButtonText,
                    { color: colors.textOnPrimary },
                  ]}
                >
                  {t("capsule.add")}
                </Text>
              </TouchableOpacity>
            </View>
          </View>
        </Modal>

        {/* Seal Date Modal */}
        <Modal visible={showSealModal} animationType="slide" transparent>
          <View style={styles.modalOverlay}>
            <View
              style={[styles.modalContent, { backgroundColor: colors.surface }]}
            >
              <View style={styles.modalHeader}>
                <Text style={[styles.modalTitle, { color: colors.text }]}>
                  {t("capsule.sealCapsule")}
                </Text>
                <TouchableOpacity onPress={() => setShowSealModal(false)}>
                  <Icon name="close" size={24} color={colors.text} />
                </TouchableOpacity>
              </View>
              <Text style={[styles.sealDesc, { color: colors.textSecondary }]}>
                {t("capsule.sealQuestion")}
              </Text>
              <TextInput
                style={[
                  styles.input,
                  {
                    color: colors.text,
                    backgroundColor: colors.backgroundSecondary,
                    borderColor: colors.borderLight,
                  },
                ]}
                value={sealDate}
                onChangeText={setSealDate}
                placeholder="YYYY-MM-DD"
                placeholderTextColor={colors.textTertiary}
              />
              <TouchableOpacity
                style={[
                  styles.saveButton,
                  {
                    backgroundColor: sealDate.trim()
                      ? colors.warning
                      : colors.borderLight,
                  },
                ]}
                onPress={handleSealCapsule}
                disabled={!sealDate.trim()}
              >
                <Icon name="lock" size={20} color="#FFF" />
                <Text style={[styles.saveButtonText, { color: "#FFF" }]}>
                  {t("capsule.seal")}
                </Text>
              </TouchableOpacity>
            </View>
          </View>
        </Modal>
      </ScrollView>
    </ScreenErrorBoundary>
  );
}

const createStyles = (colors: ThemeColors) =>
  StyleSheet.create({
    container: { flex: 1, backgroundColor: colors.background },
    content: { paddingBottom: Spacing.xxl },
    header: { padding: Spacing.lg },
    headerRow: {
      flexDirection: "row",
      justifyContent: "space-between",
      alignItems: "center",
    },
    headerTitle: { ...Typography.h3 },
    statusBadge: {
      flexDirection: "row",
      alignItems: "center",
      gap: 4,
      paddingHorizontal: Spacing.sm + 2,
      paddingVertical: Spacing.xs,
      borderRadius: BorderRadius.full,
    },
    statusText: { ...Typography.caption, fontWeight: "700" },
    memoryCount: { ...Typography.caption, marginTop: Spacing.xs },
    sealedCard: {
      alignItems: "center",
      margin: Spacing.lg,
      padding: Spacing.xl,
      borderRadius: BorderRadius.xl,
      gap: Spacing.sm,
      ...Shadows.md,
    },
    sealedTitle: { ...Typography.h4, marginTop: Spacing.sm },
    sealedCountdown: { ...Typography.h1, fontWeight: "700" },
    sealedDate: { ...Typography.bodySmall },
    openButton: {
      flexDirection: "row",
      alignItems: "center",
      gap: Spacing.sm,
      paddingHorizontal: Spacing.xl,
      paddingVertical: Spacing.md,
      borderRadius: BorderRadius.md,
      marginTop: Spacing.md,
    },
    openButtonText: { ...Typography.button, color: "#FFF" },
    openedBanner: {
      flexDirection: "row",
      alignItems: "center",
      gap: Spacing.sm,
      marginHorizontal: Spacing.lg,
      padding: Spacing.md,
      borderRadius: BorderRadius.md,
      borderWidth: 1,
    },
    openedText: { ...Typography.bodySmall, fontWeight: "500", flex: 1 },
    addSection: { paddingHorizontal: Spacing.lg, marginTop: Spacing.md },
    sectionTitle: { ...Typography.h4, marginBottom: Spacing.md },
    addButtons: { flexDirection: "row", gap: Spacing.md },
    addBtn: {
      flex: 1,
      alignItems: "center",
      paddingVertical: Spacing.lg,
      borderRadius: BorderRadius.lg,
      gap: Spacing.xs,
    },
    addBtnText: { ...Typography.caption, fontWeight: "600" },
    memorySection: { paddingHorizontal: Spacing.lg, marginTop: Spacing.xl },
    memoryGrid: { flexDirection: "row", flexWrap: "wrap", gap: Spacing.sm },
    memoryItem: { width: (SCREEN_WIDTH - Spacing.lg * 2 - Spacing.sm * 2) / 3 },
    memoryCard: {
      borderRadius: BorderRadius.md,
      overflow: "hidden",
      aspectRatio: 1,
    },
    memoryImage: { width: "100%", height: "100%" },
    textMemoryCard: {
      padding: Spacing.sm,
      justifyContent: "flex-start",
      gap: 4,
    },
    textMemory: { ...Typography.caption, fontSize: 10, lineHeight: 14 },
    voiceMemoryCard: {
      alignItems: "center",
      justifyContent: "center",
      gap: Spacing.xs,
    },
    voiceLabel: { ...Typography.caption, fontWeight: "600", fontSize: 10 },
    memoryDelete: {
      position: "absolute",
      top: 4,
      right: 4,
      width: 20,
      height: 20,
      borderRadius: 10,
      alignItems: "center",
      justifyContent: "center",
    },
    sealButton: {
      flexDirection: "row",
      alignItems: "center",
      justifyContent: "center",
      gap: Spacing.sm,
      marginHorizontal: Spacing.lg,
      marginTop: Spacing.xl,
      paddingVertical: Spacing.md,
      borderRadius: BorderRadius.md,
    },
    sealButtonText: { ...Typography.button, color: "#FFF" },
    modalOverlay: {
      flex: 1,
      backgroundColor: "rgba(0,0,0,0.5)",
      justifyContent: "flex-end",
    },
    modalContent: {
      borderTopLeftRadius: BorderRadius.xl,
      borderTopRightRadius: BorderRadius.xl,
      padding: Spacing.lg,
    },
    modalHeader: {
      flexDirection: "row",
      justifyContent: "space-between",
      alignItems: "center",
      marginBottom: Spacing.lg,
    },
    modalTitle: { ...Typography.h4 },
    sealDesc: { ...Typography.bodySmall, marginBottom: Spacing.md },
    input: {
      ...Typography.body,
      paddingHorizontal: Spacing.md,
      paddingVertical: Spacing.md,
      borderRadius: BorderRadius.md,
      borderWidth: 1,
      marginBottom: Spacing.md,
    },
    textArea: {
      ...Typography.body,
      minHeight: 120,
      padding: Spacing.md,
      borderRadius: BorderRadius.md,
      borderWidth: 1,
      marginBottom: Spacing.md,
    },
    saveButton: {
      flexDirection: "row",
      alignItems: "center",
      justifyContent: "center",
      gap: Spacing.sm,
      paddingVertical: Spacing.md,
      borderRadius: BorderRadius.md,
    },
    saveButtonText: { ...Typography.button },
  });
