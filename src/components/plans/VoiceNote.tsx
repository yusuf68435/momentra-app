import React, { useState, useEffect, useRef } from "react";
import {
  View,
  Text,
  StyleSheet,
  TouchableOpacity,
  FlatList,
} from "react-native";
import Animated, {
  useSharedValue,
  useAnimatedStyle,
  withRepeat,
  withTiming,
  withSequence,
  cancelAnimation,
  Easing,
} from "react-native-reanimated";
import { Icon } from "../ui/Icon";
import { useTranslation } from "react-i18next";
import {
  type ThemeColors,
  Spacing,
  Typography,
  BorderRadius,
  Shadows,
} from "../../constants/theme";
import { useTheme } from "../../contexts/ThemeContext";
import { Card } from "../ui/Card";

export interface VoiceNoteItem {
  id: string;
  duration: number; // seconds
  createdAt: string;
  title?: string;
}

interface VoiceNoteProps {
  planId: string;
  notes: VoiceNoteItem[];
  onStartRecording?: () => void;
  onStopRecording?: () => void;
  onPlayNote?: (id: string) => void;
  onPauseNote?: (id: string) => void;
  onDeleteNote?: (id: string) => void;
}

function formatTime(seconds: number): string {
  const mins = Math.floor(seconds / 60);
  const secs = seconds % 60;
  return `${mins.toString().padStart(2, "0")}:${secs.toString().padStart(2, "0")}`;
}

function WaveformBars({ isPlaying }: { isPlaying: boolean }) {
  const { colors } = useTheme();
  const styles = createStyles(colors);
  const BAR_COUNT = 20;
  const bars = Array.from({ length: BAR_COUNT }, (_, i) => {
    // Generate varied heights for visual interest
    const baseHeight = 8 + Math.sin(i * 0.8) * 12 + Math.cos(i * 1.3) * 8;
    return Math.max(4, Math.min(28, baseHeight));
  });

  return (
    <View style={styles.waveformContainer}>
      {bars.map((height, index) => (
        <View
          key={index}
          style={[
            styles.waveformBar,
            {
              height,
              backgroundColor: isPlaying ? colors.primary : colors.textTertiary,
              opacity: isPlaying ? 0.8 + Math.random() * 0.2 : 0.4,
            },
          ]}
        />
      ))}
    </View>
  );
}

export function VoiceNote({
  planId,
  notes,
  onStartRecording,
  onStopRecording,
  onPlayNote,
  onPauseNote,
  onDeleteNote,
}: VoiceNoteProps) {
  const { colors } = useTheme();
  const { t } = useTranslation();
  const styles = createStyles(colors);
  const [isRecording, setIsRecording] = useState(false);
  const [recordingTime, setRecordingTime] = useState(0);
  const [playingId, setPlayingId] = useState<string | null>(null);
  const timerRef = useRef<ReturnType<typeof setInterval> | null>(null);

  // Pulse animation for recording button
  const pulseScale = useSharedValue(1);
  const pulseOpacity = useSharedValue(0.6);

  useEffect(() => {
    if (isRecording) {
      pulseScale.value = withRepeat(
        withSequence(
          withTiming(1.3, { duration: 600, easing: Easing.inOut(Easing.ease) }),
          withTiming(1, { duration: 600, easing: Easing.inOut(Easing.ease) }),
        ),
        -1,
        false,
      );
      pulseOpacity.value = withRepeat(
        withSequence(
          withTiming(0, { duration: 600 }),
          withTiming(0.6, { duration: 600 }),
        ),
        -1,
        false,
      );
    } else {
      cancelAnimation(pulseScale);
      cancelAnimation(pulseOpacity);
      pulseScale.value = withTiming(1, { duration: 200 });
      pulseOpacity.value = withTiming(0.6, { duration: 200 });
    }
  }, [isRecording, pulseScale, pulseOpacity]);

  const pulseAnimatedStyle = useAnimatedStyle(() => ({
    transform: [{ scale: pulseScale.value }],
    opacity: pulseOpacity.value,
  }));

  const handleRecordToggle = () => {
    if (isRecording) {
      setIsRecording(false);
      setRecordingTime(0);
      if (timerRef.current) clearInterval(timerRef.current);
      onStopRecording?.();
    } else {
      setIsRecording(true);
      setRecordingTime(0);
      timerRef.current = setInterval(() => {
        setRecordingTime((prev) => prev + 1);
      }, 1000);
      onStartRecording?.();
    }
  };

  const handlePlayPause = (id: string) => {
    if (playingId === id) {
      setPlayingId(null);
      onPauseNote?.(id);
    } else {
      setPlayingId(id);
      onPlayNote?.(id);
    }
  };

  useEffect(() => {
    return () => {
      if (timerRef.current) clearInterval(timerRef.current);
    };
  }, []);

  const renderNoteItem = ({ item }: { item: VoiceNoteItem }) => {
    const isPlaying = playingId === item.id;

    return (
      <Card style={styles.noteCard}>
        <View style={styles.noteRow}>
          <TouchableOpacity
            style={[
              styles.playPauseBtn,
              isPlaying && styles.playPauseBtnActive,
            ]}
            onPress={() => handlePlayPause(item.id)}
            activeOpacity={0.7}
          >
            <Icon
              name={isPlaying ? "pause" : "play"}
              size={22}
              color={isPlaying ? colors.textOnPrimary : colors.primary}
            />
          </TouchableOpacity>

          <View style={styles.noteContent}>
            <Text style={styles.noteTitle} numberOfLines={1}>
              {item.title || t("voiceNote.recording")}
            </Text>
            <WaveformBars isPlaying={isPlaying} />
            <View style={styles.noteMeta}>
              <Text style={styles.noteDuration}>
                {formatTime(item.duration)}
              </Text>
              <Text style={styles.noteDate}>{item.createdAt}</Text>
            </View>
          </View>

          <TouchableOpacity
            style={styles.deleteBtn}
            onPress={() => onDeleteNote?.(item.id)}
            activeOpacity={0.7}
          >
            <Icon name="trash-can-outline" size={20} color={colors.error} />
          </TouchableOpacity>
        </View>
      </Card>
    );
  };

  return (
    <View style={styles.container}>
      <Text style={styles.sectionTitle}>{t("voiceNote.title")}</Text>

      {/* Recording Section */}
      <View style={styles.recordSection}>
        <View style={styles.recordButtonOuter}>
          <Animated.View style={[styles.pulseRing, pulseAnimatedStyle]} />
          <TouchableOpacity
            style={[
              styles.recordButton,
              isRecording && styles.recordButtonActive,
            ]}
            onPress={handleRecordToggle}
            activeOpacity={0.8}
          >
            <Icon
              name={isRecording ? "stop" : "microphone"}
              size={32}
              color={colors.textOnPrimary}
            />
          </TouchableOpacity>
        </View>

        {isRecording && (
          <View style={styles.recordingInfo}>
            <View style={styles.recordingDot} />
            <Text style={styles.recordingText}>{t("voiceNote.recording")}</Text>
            <Text style={styles.recordingTimer}>
              {formatTime(recordingTime)}
            </Text>
          </View>
        )}

        {!isRecording && (
          <Text style={styles.tapToRecord}>{t("voiceNote.tapToRecord")}</Text>
        )}
      </View>

      {/* Notes List */}
      {notes.length === 0 ? (
        <View style={styles.emptyState}>
          <Icon name="microphone-off" size={40} color={colors.textTertiary} />
          <Text style={styles.emptyText}>{t("voiceNote.noNotes")}</Text>
        </View>
      ) : (
        <FlatList
          data={notes}
          keyExtractor={(item) => item.id}
          scrollEnabled={false}
          renderItem={renderNoteItem}
          ItemSeparatorComponent={() => <View style={{ height: Spacing.sm }} />}
        />
      )}
    </View>
  );
}

const createStyles = (colors: ThemeColors) =>
  StyleSheet.create({
    container: {
      marginBottom: Spacing.md,
    },
    sectionTitle: {
      ...Typography.h3,
      color: colors.text,
      marginBottom: Spacing.lg,
    },
    recordSection: {
      alignItems: "center",
      marginBottom: Spacing.lg,
    },
    recordButtonOuter: {
      width: 80,
      height: 80,
      alignItems: "center",
      justifyContent: "center",
    },
    pulseRing: {
      position: "absolute",
      width: 80,
      height: 80,
      borderRadius: 40,
      backgroundColor: colors.error,
    },
    recordButton: {
      width: 64,
      height: 64,
      borderRadius: 32,
      backgroundColor: colors.error,
      alignItems: "center",
      justifyContent: "center",
      ...Shadows.lg,
      zIndex: 1,
    },
    recordButtonActive: {
      backgroundColor: colors.error,
    },
    recordingInfo: {
      flexDirection: "row",
      alignItems: "center",
      marginTop: Spacing.md,
      gap: Spacing.sm,
    },
    recordingDot: {
      width: 8,
      height: 8,
      borderRadius: 4,
      backgroundColor: colors.error,
    },
    recordingText: {
      ...Typography.body,
      color: colors.error,
      fontWeight: "600",
    },
    recordingTimer: {
      ...Typography.h4,
      color: colors.text,
      fontVariant: ["tabular-nums"],
    },
    tapToRecord: {
      ...Typography.bodySmall,
      color: colors.textSecondary,
      marginTop: Spacing.sm,
    },
    noteCard: {
      padding: Spacing.md,
    },
    noteRow: {
      flexDirection: "row",
      alignItems: "center",
    },
    playPauseBtn: {
      width: 40,
      height: 40,
      borderRadius: 20,
      backgroundColor: colors.primary + "15",
      alignItems: "center",
      justifyContent: "center",
      marginRight: Spacing.sm,
    },
    playPauseBtnActive: {
      backgroundColor: colors.primary,
    },
    noteContent: {
      flex: 1,
    },
    noteTitle: {
      ...Typography.bodySmall,
      color: colors.text,
      fontWeight: "600",
      marginBottom: 4,
    },
    waveformContainer: {
      flexDirection: "row",
      alignItems: "center",
      height: 28,
      gap: 2,
      marginBottom: 4,
    },
    waveformBar: {
      width: 3,
      borderRadius: 1.5,
    },
    noteMeta: {
      flexDirection: "row",
      gap: Spacing.md,
    },
    noteDuration: {
      ...Typography.caption,
      color: colors.textSecondary,
      fontVariant: ["tabular-nums"],
    },
    noteDate: {
      ...Typography.caption,
      color: colors.textTertiary,
    },
    deleteBtn: {
      padding: Spacing.sm,
      marginLeft: Spacing.xs,
    },
    emptyState: {
      alignItems: "center",
      paddingVertical: Spacing.xl,
    },
    emptyText: {
      ...Typography.body,
      color: colors.textSecondary,
      marginTop: Spacing.sm,
    },
  });
