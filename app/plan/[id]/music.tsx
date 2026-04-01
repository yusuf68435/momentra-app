import React, { useState, useCallback, useMemo, useEffect } from "react";
import {
  View,
  Text,
  FlatList,
  StyleSheet,
  TouchableOpacity,
  TextInput,
  Modal,
  Alert,
  KeyboardAvoidingView,
  Platform,
  ScrollView,
  Image,
} from "react-native";
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
import { usePlanStore } from "../../../src/stores/planStore";
import { useMusicStore } from "../../../src/stores/musicStore";
import type {
  Song as StoreSong,
  AddSongData,
} from "../../../src/stores/musicStore";
import { supabase } from "../../../src/services/supabase";
import {
  searchSpotifyTracks,
  openInSpotify,
} from "../../../src/services/music";
import { ScreenErrorBoundary } from "../../../src/components/common/ScreenErrorBoundary";
import { EmptyState } from "../../../src/components/common/EmptyState";

type Mood = "romantic" | "fun" | "energetic" | "chill" | "emotional";

// Screen-level view model — derived from store Song, never stored in local state
interface SongView {
  id: string;
  title: string;
  artist: string;
  duration: string; // "3:45" format
  durationSeconds: number;
  spotifyUri?: string;
  imageUrl?: string;
}

const getMoodConfig = (
  colors: ThemeColors,
): Record<Mood, { icon: string; color: string }> => ({
  romantic: { icon: "heart", color: colors.moodRomantic },
  fun: { icon: "party-popper", color: colors.moodFun },
  energetic: { icon: "flash", color: colors.moodEnergetic },
  chill: { icon: "weather-sunset", color: colors.moodChill },
  emotional: { icon: "music-note", color: colors.moodEmotional },
});

const DEFAULT_DURATION_SECONDS = 210;
const DEFAULT_DURATION_STRING = "3:30";

function parseDuration(dur: string): number {
  const parts = dur.split(":");
  if (parts.length === 2) {
    return parseInt(parts[0], 10) * 60 + parseInt(parts[1], 10);
  }
  return 0;
}

function formatDurationSeconds(seconds: number): string {
  const mins = Math.floor(seconds / 60);
  const secs = seconds % 60;
  return `${mins}:${secs.toString().padStart(2, "0")}`;
}

function formatTotalDuration(seconds: number): string {
  const hrs = Math.floor(seconds / 3600);
  const mins = Math.floor((seconds % 3600) / 60);
  if (hrs > 0) return `${hrs}h ${mins}m`;
  return `${mins}m`;
}

function storeSongToView(song: StoreSong): SongView {
  const durationSeconds = song.duration_seconds ?? DEFAULT_DURATION_SECONDS;
  const spotifyUri =
    song.external_source === "spotify" && song.external_id
      ? song.external_id
      : undefined;
  return {
    id: song.id,
    title: song.title,
    artist: song.artist,
    duration: formatDurationSeconds(durationSeconds),
    durationSeconds,
    spotifyUri,
    imageUrl: song.cover_url ?? undefined,
  };
}

const FALLBACK_SONGS: Record<Mood, SongView[]> = {
  romantic: [
    {
      id: "r1",
      title: "Perfect",
      artist: "Ed Sheeran",
      duration: "4:23",
      durationSeconds: 263,
    },
    {
      id: "r2",
      title: "All of Me",
      artist: "John Legend",
      duration: "4:29",
      durationSeconds: 269,
    },
    {
      id: "r3",
      title: "Thinking Out Loud",
      artist: "Ed Sheeran",
      duration: "4:41",
      durationSeconds: 281,
    },
  ],
  fun: [
    {
      id: "f1",
      title: "Happy",
      artist: "Pharrell Williams",
      duration: "3:53",
      durationSeconds: 233,
    },
    {
      id: "f2",
      title: "Uptown Funk",
      artist: "Bruno Mars",
      duration: "4:30",
      durationSeconds: 270,
    },
    {
      id: "f3",
      title: "Shake It Off",
      artist: "Taylor Swift",
      duration: "3:39",
      durationSeconds: 219,
    },
  ],
  energetic: [
    {
      id: "e1",
      title: "Don't Stop Me Now",
      artist: "Queen",
      duration: "3:29",
      durationSeconds: 209,
    },
    {
      id: "e2",
      title: "Eye of the Tiger",
      artist: "Survivor",
      duration: "4:05",
      durationSeconds: 245,
    },
    {
      id: "e3",
      title: "Stronger",
      artist: "Kanye West",
      duration: "5:12",
      durationSeconds: 312,
    },
  ],
  chill: [
    {
      id: "c1",
      title: "Weightless",
      artist: "Marconi Union",
      duration: "8:09",
      durationSeconds: 489,
    },
    {
      id: "c2",
      title: "Sunset Lover",
      artist: "Petit Biscuit",
      duration: "3:30",
      durationSeconds: 210,
    },
    {
      id: "c3",
      title: "Electric Feel",
      artist: "MGMT",
      duration: "3:49",
      durationSeconds: 229,
    },
  ],
  emotional: [
    {
      id: "em1",
      title: "Fix You",
      artist: "Coldplay",
      duration: "4:55",
      durationSeconds: 295,
    },
    {
      id: "em2",
      title: "Someone Like You",
      artist: "Adele",
      duration: "4:45",
      durationSeconds: 285,
    },
    {
      id: "em3",
      title: "Hallelujah",
      artist: "Jeff Buckley",
      duration: "6:53",
      durationSeconds: 413,
    },
  ],
};

export default function MusicScreen() {
  const { id } = useLocalSearchParams<{ id: string }>();
  const { t, i18n } = useTranslation();
  const lang = i18n.language as "tr" | "en";
  const { colors } = useTheme();
  const MOOD_CONFIG = getMoodConfig(colors);
  const { plans } = usePlanStore();
  const plan = plans.find((p) => p.id === id);

  const {
    playlists,
    isLoading,
    fetchPlaylist,
    addSong: storeAddSong,
    removeSong: storeRemoveSong,
    reorder: storeReorder,
  } = useMusicStore();

  const [selectedMood, setSelectedMood] = useState<Mood | null>(null);
  const [showAddModal, setShowAddModal] = useState(false);
  const [isSuggesting, setIsSuggesting] = useState(false);
  const [newTitle, setNewTitle] = useState("");
  const [newArtist, setNewArtist] = useState("");
  const [newDuration, setNewDuration] = useState("");

  // Load persisted playlist on mount
  useEffect(() => {
    if (id) {
      fetchPlaylist(id).catch(() => {
        // Silent — store already captures error in state
      });
    }
  }, [id, fetchPlaylist]);

  // Derive view models from store; fall back to empty array
  const storeSongs = id ? (playlists[id] ?? []) : [];
  const songs: SongView[] = useMemo(
    () => storeSongs.map(storeSongToView),
    // eslint-disable-next-line react-hooks/exhaustive-deps
    [storeSongs],
  );

  const totalDuration = useMemo(
    () => songs.reduce((sum, s) => sum + s.durationSeconds, 0),
    [songs],
  );

  const handleAddSong = useCallback(async () => {
    if (!newTitle.trim() || !newArtist.trim() || !id) return;
    const durationStr = newDuration.trim() || DEFAULT_DURATION_STRING;
    const songData: AddSongData = {
      title: newTitle.trim(),
      artist: newArtist.trim(),
      duration_seconds: parseDuration(durationStr),
    };
    try {
      await storeAddSong(id, songData);
      setShowAddModal(false);
      setNewTitle("");
      setNewArtist("");
      setNewDuration("");
    } catch {
      Alert.alert(t("common.error"), t("music.addSongError"));
    }
  }, [id, newTitle, newArtist, newDuration, storeAddSong, t]);

  const handleDeleteSong = useCallback(
    (songId: string, songTitle: string) => {
      Alert.alert(
        t("music.deleteSongTitle"),
        t("music.deleteSongConfirm", { title: songTitle }),
        [
          { text: t("common.cancel"), style: "cancel" },
          {
            text: t("common.delete"),
            style: "destructive",
            onPress: () => {
              storeRemoveSong(songId).catch(() => {
                Alert.alert(t("common.error"), t("music.deleteSongError"));
              });
            },
          },
        ],
      );
    },
    [t, storeRemoveSong],
  );

  const handleSuggestSongs = useCallback(async () => {
    if (!selectedMood || !id) {
      Alert.alert(t("music.selectMoodTitle"), t("music.selectMoodDesc"));
      return;
    }
    setIsSuggesting(true);

    // Helper: persist a list of view songs to the store and then
    // fire-and-forget Spotify enrichment which updates the already-persisted rows
    // by re-adding them with enriched data. Since the store does upsert-by-insert
    // we simply add new enriched versions if Spotify lookup succeeds.
    const persistAndEnrich = async (
      rawViews: SongView[],
      mood: Mood,
    ): Promise<void> => {
      // Persist all raw songs first
      const persistedIds: string[] = [];
      for (const view of rawViews) {
        try {
          const added = await storeAddSong(id, {
            title: view.title,
            artist: view.artist,
            duration_seconds: view.durationSeconds,
          });
          persistedIds.push(added.id);
        } catch {
          // Continue persisting remaining songs even if one fails
        }
      }

      // Enrich with Spotify metadata in the background
      searchSpotifyTracks(
        rawViews.map((v) => ({ title: v.title, artist: v.artist })),
      )
        .then(async (spotifyResults) => {
          const currentStoreSongs =
            useMusicStore.getState().playlists[id] ?? [];
          for (let i = 0; i < rawViews.length; i++) {
            const spotify = spotifyResults[i];
            if (!spotify) continue;
            // Find the persisted song for this index by matching title+artist
            const persistedSong = currentStoreSongs.find(
              (s) =>
                s.title === rawViews[i].title &&
                s.artist === rawViews[i].artist,
            );
            if (!persistedSong) continue;
            const durSec = Math.round(spotify.durationMs / 1000);
            // Remove the un-enriched version and add the enriched one
            try {
              await storeRemoveSong(persistedSong.id);
              await storeAddSong(id, {
                title: persistedSong.title,
                artist: persistedSong.artist,
                album: spotify.album ?? undefined,
                duration_seconds: durSec,
                preview_url: spotify.previewUrl ?? undefined,
                cover_url: spotify.imageUrl ?? undefined,
                external_id: spotify.spotifyUri,
                external_source: "spotify",
              });
            } catch {
              // Enrichment is best-effort; ignore individual failures
            }
          }
        })
        .catch(() => {
          // Enrichment is best-effort
        });

      void mood; // mood kept in scope to avoid lint warning
    };

    try {
      const { data, error } = await supabase.functions.invoke("ai-music", {
        body: {
          mood: selectedMood,
          plan_title: plan?.title ?? "",
          occasion:
            lang === "tr"
              ? (plan?.scenario?.category?.name_tr ?? "")
              : (plan?.scenario?.category?.name_en ?? ""),
          language: lang,
        },
      });
      if (error) throw error;
      const rawSongs = (data?.songs ?? data?.playlist ?? []) as Array<{
        id?: string | number;
        title?: string;
        name?: string;
        artist?: string;
        duration?: string;
      }>;
      if (rawSongs.length > 0) {
        const mapped: SongView[] = rawSongs.map((s, idx) => {
          const dur = s.duration ?? DEFAULT_DURATION_STRING;
          return {
            id: s.id?.toString() ?? `ai-${selectedMood}-${idx}`,
            title: s.title ?? s.name ?? "",
            artist: s.artist ?? "",
            duration: dur,
            durationSeconds: parseDuration(dur),
          };
        });
        setIsSuggesting(false);
        await persistAndEnrich(mapped, selectedMood);
        return;
      }
    } catch {
      // Fall through to hardcoded fallback
    }

    // Fallback to local suggestions when edge function is unavailable
    const fallback = FALLBACK_SONGS[selectedMood];
    setIsSuggesting(false);
    await persistAndEnrich(fallback, selectedMood);
  }, [selectedMood, id, lang, plan, storeAddSong, storeRemoveSong, t]);

  const handleMoveSong = useCallback(
    (songId: string, direction: "up" | "down") => {
      if (!id) return;
      const currentStoreSongs = useMusicStore.getState().playlists[id] ?? [];
      const index = currentStoreSongs.findIndex((s) => s.id === songId);
      if (index < 0) return;
      if (direction === "up" && index === 0) return;
      if (direction === "down" && index === currentStoreSongs.length - 1)
        return;
      const reordered = [...currentStoreSongs];
      const swapIndex = direction === "up" ? index - 1 : index + 1;
      [reordered[index], reordered[swapIndex]] = [
        reordered[swapIndex],
        reordered[index],
      ];
      storeReorder(id, reordered).catch(() => {
        // Store reverts optimistic update on failure — no extra handling needed
      });
    },
    [id, storeReorder],
  );

  const styles = useMemo(() => createStyles(colors), [colors]);

  const renderSong = useCallback(
    ({ item, index }: { item: SongView; index: number }) => (
      <View style={styles.songCard}>
        {/* Album art or index number */}
        {item.imageUrl ? (
          <Image source={{ uri: item.imageUrl }} style={styles.albumArt} />
        ) : (
          <View
            style={[
              styles.songIndex,
              { backgroundColor: colors.primary + "15" },
            ]}
          >
            <Text style={[styles.songIndexText, { color: colors.primary }]}>
              {index + 1}
            </Text>
          </View>
        )}
        <View style={styles.songInfo}>
          <Text
            style={[styles.songTitle, { color: colors.text }]}
            numberOfLines={1}
          >
            {item.title}
          </Text>
          <Text
            style={[styles.songArtist, { color: colors.textSecondary }]}
            numberOfLines={1}
          >
            {item.artist}
          </Text>
        </View>
        <Text style={[styles.songDuration, { color: colors.textTertiary }]}>
          {item.duration}
        </Text>
        <View style={styles.songActions}>
          {item.spotifyUri ? (
            <TouchableOpacity
              onPress={() =>
                openInSpotify(item.title, item.artist, item.spotifyUri)
              }
              style={styles.moveBtn}
              accessibilityLabel="Open in Spotify"
            >
              <Icon name="spotify" size={18} color="#1DB954" />
            </TouchableOpacity>
          ) : null}
          <TouchableOpacity
            onPress={() => handleMoveSong(item.id, "up")}
            style={styles.moveBtn}
          >
            <Icon name="chevron-up" size={20} color={colors.textTertiary} />
          </TouchableOpacity>
          <TouchableOpacity
            onPress={() => handleMoveSong(item.id, "down")}
            style={styles.moveBtn}
          >
            <Icon name="chevron-down" size={20} color={colors.textTertiary} />
          </TouchableOpacity>
          <TouchableOpacity
            onPress={() => handleDeleteSong(item.id, item.title)}
            style={styles.moveBtn}
          >
            <Icon name="close" size={18} color={colors.error} />
          </TouchableOpacity>
        </View>
      </View>
    ),
    [styles, colors, handleMoveSong, handleDeleteSong],
  );

  return (
    <ScreenErrorBoundary>
      <View style={styles.container}>
        {/* Header */}
        <View style={styles.header}>
          <View>
            <Text style={[styles.headerTitle, { color: colors.text }]}>
              {t("music.title")}
            </Text>
            <Text style={[styles.headerSub, { color: colors.textSecondary }]}>
              {t("music.songsCount", { count: songs.length })} -{" "}
              {formatTotalDuration(totalDuration)}
            </Text>
          </View>
        </View>

        {/* Mood Selector */}
        <View style={styles.moodSection}>
          <Text style={[styles.moodLabel, { color: colors.text }]}>
            {t("music.selectMoodLabel")}
          </Text>
          <ScrollView
            horizontal
            showsHorizontalScrollIndicator={false}
            contentContainerStyle={styles.moodChips}
          >
            {(Object.keys(MOOD_CONFIG) as Mood[]).map((mood) => {
              const cfg = MOOD_CONFIG[mood];
              const isSelected = selectedMood === mood;
              return (
                <TouchableOpacity
                  key={mood}
                  style={[
                    styles.moodChip,
                    {
                      backgroundColor: isSelected
                        ? cfg.color + "20"
                        : colors.surfaceVariant,
                      borderColor: isSelected ? cfg.color : "transparent",
                    },
                  ]}
                  onPress={() => setSelectedMood(isSelected ? null : mood)}
                >
                  <Icon
                    name={cfg.icon as IconName}
                    size={16}
                    color={isSelected ? cfg.color : colors.textSecondary}
                  />
                  <Text
                    style={[
                      styles.moodChipText,
                      { color: isSelected ? cfg.color : colors.textSecondary },
                    ]}
                  >
                    {t(`music.moods.${mood}`)}
                  </Text>
                </TouchableOpacity>
              );
            })}
          </ScrollView>
        </View>

        {/* Suggest Button */}
        <TouchableOpacity
          style={[
            styles.suggestButton,
            {
              backgroundColor: colors.accent + "15",
              borderColor: colors.accent,
            },
          ]}
          onPress={handleSuggestSongs}
          disabled={isSuggesting || isLoading}
          activeOpacity={0.7}
        >
          <Icon
            name={
              isSuggesting || isLoading
                ? ("loading" as IconName)
                : ("music-note-plus" as IconName)
            }
            size={20}
            color={colors.accent}
          />
          <Text style={[styles.suggestButtonText, { color: colors.accent }]}>
            {isSuggesting ? t("music.suggesting") : t("music.suggest")}
          </Text>
        </TouchableOpacity>

        {/* Song List */}
        <FlatList
          data={songs}
          keyExtractor={(item) => item.id}
          renderItem={renderSong}
          contentContainerStyle={styles.list}
          showsVerticalScrollIndicator={false}
          ListEmptyComponent={
            <EmptyState
              emoji="🎵"
              title={t("music.emptyTitle")}
              description={t("music.emptyDesc")}
              compact
            />
          }
        />

        {/* FAB */}
        <TouchableOpacity
          style={[styles.fab, { backgroundColor: colors.primary }]}
          onPress={() => setShowAddModal(true)}
          activeOpacity={0.8}
        >
          <Icon name="plus" size={26} color={colors.textOnPrimary} />
        </TouchableOpacity>

        {/* Add Song Modal */}
        <Modal visible={showAddModal} animationType="slide" transparent>
          <View style={styles.modalOverlay}>
            <KeyboardAvoidingView
              behavior={Platform.OS === "ios" ? "padding" : undefined}
              style={styles.modalWrapper}
            >
              <View
                style={[
                  styles.modalContent,
                  { backgroundColor: colors.surface },
                ]}
              >
                <View style={styles.modalHeader}>
                  <Text style={[styles.modalTitle, { color: colors.text }]}>
                    {t("music.add_song")}
                  </Text>
                  <TouchableOpacity onPress={() => setShowAddModal(false)}>
                    <Icon name="close" size={24} color={colors.text} />
                  </TouchableOpacity>
                </View>

                <View style={styles.inputGroup}>
                  <Text
                    style={[styles.inputLabel, { color: colors.textSecondary }]}
                  >
                    {t("music.songTitleLabel")}
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
                    value={newTitle}
                    onChangeText={setNewTitle}
                    placeholder={t("music.songTitlePlaceholder")}
                    placeholderTextColor={colors.textTertiary}
                  />
                </View>

                <View style={styles.inputGroup}>
                  <Text
                    style={[styles.inputLabel, { color: colors.textSecondary }]}
                  >
                    {t("music.artistLabel")}
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
                    value={newArtist}
                    onChangeText={setNewArtist}
                    placeholder={t("music.artistPlaceholder")}
                    placeholderTextColor={colors.textTertiary}
                  />
                </View>

                <View style={styles.inputGroup}>
                  <Text
                    style={[styles.inputLabel, { color: colors.textSecondary }]}
                  >
                    {t("music.durationLabel")}
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
                    value={newDuration}
                    onChangeText={setNewDuration}
                    placeholder="3:45"
                    placeholderTextColor={colors.textTertiary}
                  />
                </View>

                <TouchableOpacity
                  style={[
                    styles.saveButton,
                    {
                      backgroundColor:
                        newTitle.trim() && newArtist.trim()
                          ? colors.primary
                          : colors.borderLight,
                    },
                  ]}
                  onPress={handleAddSong}
                  disabled={!newTitle.trim() || !newArtist.trim() || isLoading}
                >
                  <Text
                    style={[
                      styles.saveButtonText,
                      { color: colors.textOnPrimary },
                    ]}
                  >
                    {t("music.addButton")}
                  </Text>
                </TouchableOpacity>
              </View>
            </KeyboardAvoidingView>
          </View>
        </Modal>
      </View>
    </ScreenErrorBoundary>
  );
}

const createStyles = (colors: ThemeColors) =>
  StyleSheet.create({
    container: { flex: 1, backgroundColor: colors.background },
    header: {
      padding: Spacing.lg,
      borderBottomWidth: 1,
      borderBottomColor: colors.borderLight,
    },
    headerTitle: { ...Typography.h3 },
    headerSub: { ...Typography.caption, marginTop: 2 },
    moodSection: { paddingHorizontal: Spacing.lg, paddingTop: Spacing.lg },
    moodLabel: {
      ...Typography.bodySmall,
      fontWeight: "600",
      marginBottom: Spacing.sm,
    },
    moodChips: { gap: Spacing.sm },
    moodChip: {
      flexDirection: "row",
      alignItems: "center",
      gap: 6,
      paddingHorizontal: Spacing.md,
      paddingVertical: Spacing.sm,
      borderRadius: BorderRadius.full,
      borderWidth: 1.5,
    },
    moodChipText: { ...Typography.caption, fontWeight: "600" },
    suggestButton: {
      flexDirection: "row",
      alignItems: "center",
      justifyContent: "center",
      gap: Spacing.sm,
      marginHorizontal: Spacing.lg,
      marginTop: Spacing.md,
      paddingVertical: Spacing.sm + 2,
      borderRadius: BorderRadius.md,
      borderWidth: 1.5,
    },
    suggestButtonText: { ...Typography.buttonSmall },
    list: {
      paddingHorizontal: Spacing.lg,
      paddingTop: Spacing.md,
      paddingBottom: Spacing.xxl + 40,
    },
    songCard: {
      flexDirection: "row",
      alignItems: "center",
      backgroundColor: colors.surface,
      borderRadius: BorderRadius.md,
      padding: Spacing.sm + 2,
      marginBottom: Spacing.sm,
      borderWidth: 1,
      borderColor: colors.borderLight,
      gap: Spacing.sm,
    },
    albumArt: {
      width: 36,
      height: 36,
      borderRadius: BorderRadius.sm,
    },
    songIndex: {
      width: 36,
      height: 36,
      borderRadius: BorderRadius.sm,
      alignItems: "center",
      justifyContent: "center",
    },
    songIndexText: { ...Typography.bodySmall, fontWeight: "700" },
    songInfo: { flex: 1 },
    songTitle: { ...Typography.bodySmall, fontWeight: "600" },
    songArtist: { ...Typography.caption, marginTop: 1 },
    songDuration: {
      ...Typography.caption,
      fontWeight: "500",
      marginRight: Spacing.xs,
    },
    songActions: { flexDirection: "row", alignItems: "center" },
    moveBtn: { padding: 4 },
    fab: {
      position: "absolute",
      right: Spacing.lg,
      bottom: Spacing.lg,
      width: 56,
      height: 56,
      borderRadius: 28,
      justifyContent: "center",
      alignItems: "center",
      ...Shadows.lg,
    },
    modalOverlay: {
      flex: 1,
      backgroundColor: "rgba(0,0,0,0.5)",
      justifyContent: "flex-end",
    },
    modalWrapper: { width: "100%" },
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
    inputGroup: { marginBottom: Spacing.md },
    inputLabel: {
      ...Typography.caption,
      fontWeight: "600",
      marginBottom: Spacing.xs,
    },
    input: {
      ...Typography.body,
      paddingHorizontal: Spacing.md,
      paddingVertical: Spacing.md,
      borderRadius: BorderRadius.md,
      borderWidth: 1,
    },
    saveButton: {
      alignItems: "center",
      paddingVertical: Spacing.md,
      borderRadius: BorderRadius.md,
      marginTop: Spacing.sm,
    },
    saveButtonText: { ...Typography.button },
  });
