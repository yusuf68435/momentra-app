import React, { useState } from 'react';
import {
  View,
  Text,
  StyleSheet,
  TouchableOpacity,
  FlatList,
  ScrollView,
} from 'react-native';
import { Icon } from '../ui/Icon';
import type { IconName } from '../../constants/icons';
import { useTranslation } from 'react-i18next';
import { type ThemeColors, Spacing, Typography, BorderRadius, Shadows } from '../../constants/theme';
import { useTheme } from '../../contexts/ThemeContext';
import { Card } from '../ui/Card';
import { openInSpotify } from '../../services/music';

export interface Song {
  id: string;
  title: string;
  artist: string;
  duration: number; // seconds
}

type MoodType = 'romantic' | 'fun' | 'energetic' | 'chill' | 'emotional';

interface MusicPlaylistProps {
  planId: string;
  songs: Song[];
  onGetSuggestions?: (mood: MoodType) => void;
  onReorder?: (songs: Song[]) => void;
  onRemoveSong?: (id: string) => void;
}

const moodConfig: Record<MoodType, { icon: IconName; color: string }> = {
  romantic: { icon: 'heart', color: '#E91E63' },
  fun: { icon: 'emoticon-happy', color: '#FF9800' },
  energetic: { icon: 'lightning-bolt', color: '#F44336' },
  chill: { icon: 'weather-sunset', color: '#42A5F5' },
  emotional: { icon: 'music-note-eighth', color: '#AB47BC' },
};

function formatDuration(seconds: number): string {
  const mins = Math.floor(seconds / 60);
  const secs = seconds % 60;
  return `${mins}:${secs.toString().padStart(2, '0')}`;
}

function formatTotalDuration(seconds: number): string {
  const hours = Math.floor(seconds / 3600);
  const mins = Math.floor((seconds % 3600) / 60);
  if (hours > 0) {
    return `${hours}h ${mins}m`;
  }
  return `${mins} min`;
}

export function MusicPlaylist({
  planId,
  songs,
  onGetSuggestions,
  onReorder,
  onRemoveSong,
}: MusicPlaylistProps) {
  const { colors } = useTheme();
  const { t } = useTranslation();
  const [selectedMood, setSelectedMood] = useState<MoodType | null>(null);
  const styles = createStyles(colors);

  const totalDuration = songs.reduce((sum, s) => sum + s.duration, 0);

  const handleMoodSelect = (mood: MoodType) => {
    setSelectedMood(mood);
  };

  const handleGetSuggestions = () => {
    if (selectedMood) {
      onGetSuggestions?.(selectedMood);
    }
  };

  const renderSongItem = ({ item, index }: { item: Song; index: number }) => (
    <View style={styles.songRow}>
      <View style={styles.dragHandle}>
        <Icon name="drag" size={20} color={colors.textTertiary} />
      </View>

      <View style={styles.songIndex}>
        <Text style={styles.songIndexText}>{index + 1}</Text>
      </View>

      <View style={styles.songInfo}>
        <Text style={styles.songTitle} numberOfLines={1}>
          {item.title}
        </Text>
        <Text style={styles.songArtist} numberOfLines={1}>
          {item.artist}
        </Text>
      </View>

      <Text style={styles.songDuration}>{formatDuration(item.duration)}</Text>

      <TouchableOpacity
        style={styles.playButton}
        activeOpacity={0.7}
      >
        <Icon name="play-circle-outline" size={28} color={colors.primary} />
      </TouchableOpacity>

      <TouchableOpacity
        style={styles.spotifyButton}
        activeOpacity={0.7}
        onPress={() => openInSpotify(item.title, item.artist)}
      >
        <Icon name="spotify" size={24} color="#1DB954" />
      </TouchableOpacity>
    </View>
  );

  if (songs.length === 0) {
    return (
      <Card style={styles.emptyContainer}>
        <Icon name="music-note-plus" size={64} color={colors.textTertiary} />
        <Text style={styles.emptyTitle}>{t('playlist.emptyTitle')}</Text>
        <Text style={styles.emptySubtitle}>{t('playlist.emptySubtitle')}</Text>

        {/* Mood selector */}
        <Text style={styles.moodLabel}>{t('playlist.selectMood')}</Text>
        <ScrollView
          horizontal
          showsHorizontalScrollIndicator={false}
          contentContainerStyle={styles.moodRow}
        >
          {(Object.keys(moodConfig) as MoodType[]).map((mood) => {
            const config = moodConfig[mood];
            const isSelected = selectedMood === mood;
            return (
              <TouchableOpacity
                key={mood}
                style={[
                  styles.moodChip,
                  isSelected && { backgroundColor: config.color, borderColor: config.color },
                ]}
                onPress={() => handleMoodSelect(mood)}
                activeOpacity={0.7}
              >
                <Icon
                  name={config.icon}
                  size={16}
                  color={isSelected ? '#FFFFFF' : config.color}
                />
                <Text
                  style={[
                    styles.moodChipText,
                    isSelected && { color: '#FFFFFF' },
                  ]}
                >
                  {t(`playlist.mood.${mood}`)}
                </Text>
              </TouchableOpacity>
            );
          })}
        </ScrollView>

        <TouchableOpacity
          style={[styles.suggestButton, !selectedMood && styles.suggestButtonDisabled]}
          onPress={handleGetSuggestions}
          activeOpacity={selectedMood ? 0.8 : 1}
          disabled={!selectedMood}
        >
          <Icon name="creation" size={20} color="#FFFFFF" />
          <Text style={styles.suggestButtonText}>{t('playlist.getSuggestions')}</Text>
        </TouchableOpacity>
      </Card>
    );
  }

  return (
    <View style={styles.container}>
      <View style={styles.header}>
        <Text style={styles.sectionTitle}>{t('playlist.title')}</Text>
        <View style={styles.durationBadge}>
          <Icon name="clock-outline" size={14} color={colors.textSecondary} />
          <Text style={styles.durationText}>
            {formatTotalDuration(totalDuration)} ({songs.length} {t('playlist.songs')})
          </Text>
        </View>
      </View>

      {/* Mood selector */}
      <ScrollView
        horizontal
        showsHorizontalScrollIndicator={false}
        contentContainerStyle={styles.moodRow}
        style={styles.moodScroll}
      >
        {(Object.keys(moodConfig) as MoodType[]).map((mood) => {
          const config = moodConfig[mood];
          const isSelected = selectedMood === mood;
          return (
            <TouchableOpacity
              key={mood}
              style={[
                styles.moodChip,
                isSelected && { backgroundColor: config.color, borderColor: config.color },
              ]}
              onPress={() => handleMoodSelect(mood)}
              activeOpacity={0.7}
            >
              <Icon
                name={config.icon}
                size={16}
                color={isSelected ? '#FFFFFF' : config.color}
              />
              <Text
                style={[
                  styles.moodChipText,
                  isSelected && { color: '#FFFFFF' },
                ]}
              >
                {t(`playlist.mood.${mood}`)}
              </Text>
            </TouchableOpacity>
          );
        })}
      </ScrollView>

      <TouchableOpacity
        style={[styles.suggestButton, !selectedMood && styles.suggestButtonDisabled]}
        onPress={handleGetSuggestions}
        activeOpacity={selectedMood ? 0.8 : 1}
        disabled={!selectedMood}
      >
        <Icon name="creation" size={20} color="#FFFFFF" />
        <Text style={styles.suggestButtonText}>{t('playlist.getSuggestions')}</Text>
      </TouchableOpacity>

      <FlatList
        data={songs}
        keyExtractor={(item) => item.id}
        scrollEnabled={false}
        renderItem={renderSongItem}
        ItemSeparatorComponent={() => <View style={styles.separator} />}
      />
    </View>
  );
}

const createStyles = (colors: ThemeColors) => StyleSheet.create({
  container: {
    marginBottom: Spacing.md,
  },
  header: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginBottom: Spacing.sm,
  },
  sectionTitle: {
    ...Typography.h3,
    color: colors.text,
  },
  durationBadge: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 4,
  },
  durationText: {
    ...Typography.caption,
    color: colors.textSecondary,
  },
  moodScroll: {
    marginBottom: Spacing.sm,
  },
  moodRow: {
    flexDirection: 'row',
    gap: Spacing.sm,
    paddingVertical: Spacing.xs,
  },
  moodChip: {
    flexDirection: 'row',
    alignItems: 'center',
    paddingHorizontal: Spacing.md,
    paddingVertical: Spacing.sm,
    borderRadius: BorderRadius.full,
    borderWidth: 1.5,
    borderColor: colors.border,
    gap: Spacing.xs,
  },
  moodChipText: {
    ...Typography.bodySmall,
    fontWeight: '600',
    color: colors.text,
  },
  moodLabel: {
    ...Typography.bodySmall,
    color: colors.textSecondary,
    marginBottom: Spacing.sm,
    marginTop: Spacing.md,
  },
  suggestButton: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'center',
    backgroundColor: colors.accent,
    borderRadius: BorderRadius.md,
    paddingVertical: Spacing.sm + 2,
    paddingHorizontal: Spacing.lg,
    gap: Spacing.sm,
    marginBottom: Spacing.md,
    ...Shadows.md,
  },
  suggestButtonDisabled: {
    opacity: 0.5,
  },
  suggestButtonText: {
    ...Typography.button,
    color: '#FFFFFF',
  },
  songRow: {
    flexDirection: 'row',
    alignItems: 'center',
    paddingVertical: Spacing.sm,
    paddingHorizontal: Spacing.xs,
  },
  dragHandle: {
    padding: Spacing.xs,
    marginRight: Spacing.xs,
  },
  songIndex: {
    width: 24,
    alignItems: 'center',
    marginRight: Spacing.sm,
  },
  songIndexText: {
    ...Typography.bodySmall,
    color: colors.textTertiary,
    fontWeight: '600',
  },
  songInfo: {
    flex: 1,
    marginRight: Spacing.sm,
  },
  songTitle: {
    ...Typography.body,
    color: colors.text,
    fontWeight: '500',
  },
  songArtist: {
    ...Typography.caption,
    color: colors.textSecondary,
  },
  songDuration: {
    ...Typography.caption,
    color: colors.textTertiary,
    marginRight: Spacing.sm,
  },
  playButton: {
    padding: 2,
  },
  spotifyButton: {
    padding: 2,
    marginLeft: Spacing.xs,
  },
  separator: {
    height: 1,
    backgroundColor: colors.borderLight,
    marginLeft: 56,
  },
  emptyContainer: {
    alignItems: 'center',
    paddingVertical: Spacing.xxl,
    paddingHorizontal: Spacing.lg,
  },
  emptyTitle: {
    ...Typography.h3,
    color: colors.text,
    marginTop: Spacing.md,
  },
  emptySubtitle: {
    ...Typography.body,
    color: colors.textSecondary,
    textAlign: 'center',
    marginTop: Spacing.xs,
  },
});

