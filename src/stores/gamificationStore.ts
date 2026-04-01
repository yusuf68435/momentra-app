import { create } from "zustand";
import { persist, createJSONStorage } from "zustand/middleware";
import AsyncStorage from "@react-native-async-storage/async-storage";
import {
  fetchGamification,
  fetchBadges,
  addXpRemote,
  awardBadge,
  syncStats,
} from "../services/gamification";

// ── Badge Definition ──────────────────────────────────────────────────

export interface Badge {
  id: string;
  slug: string;
  title_tr: string;
  title_en: string;
  description_tr: string;
  description_en: string;
  emoji: string;
  unlockedAt: string | null;
}

export interface BadgeDefinition {
  slug: string;
  title_tr: string;
  title_en: string;
  description_tr: string;
  description_en: string;
  emoji: string;
}

export const BADGE_DEFINITIONS: BadgeDefinition[] = [
  {
    slug: "first-plan",
    title_tr: "İlk Plan",
    title_en: "First Plan",
    description_tr: "İlk planını oluştur",
    description_en: "Create your first plan",
    emoji: "📝",
  },
  {
    slug: "first-surprise",
    title_tr: "İlk Sürpriz",
    title_en: "First Surprise",
    description_tr: "İlk sürprizini tamamla",
    description_en: "Complete your first surprise",
    emoji: "🎉",
  },
  {
    slug: "romantic-genius",
    title_tr: "Romantik Dahi",
    title_en: "Romantic Genius",
    description_tr: "5 romantik sürpriz planla",
    description_en: "Plan 5 romantic surprises",
    emoji: "💕",
  },
  {
    slug: "budget-hero",
    title_tr: "Bütçe Kahramanı",
    title_en: "Budget Hero",
    description_tr: "Bütçe dahilinde 3 sürpriz tamamla",
    description_en: "Complete 3 surprises within budget",
    emoji: "💰",
  },
  {
    slug: "social-butterfly",
    title_tr: "Sosyal Kelebek",
    title_en: "Social Butterfly",
    description_tr: "3 farklı kişi için sürpriz planla",
    description_en: "Plan surprises for 3 different people",
    emoji: "🦋",
  },
  {
    slug: "happy-3",
    title_tr: "3 Kişi Mutlu",
    title_en: "3 People Happy",
    description_tr: "3 farklı kişiyi sürprizle mutlu et",
    description_en: "Make 3 different people happy with surprises",
    emoji: "❤️",
  },
  {
    slug: "happy-10",
    title_tr: "10 Kişi Mutlu",
    title_en: "10 People Happy",
    description_tr: "10 farklı kişiyi sürprizle mutlu et",
    description_en: "Make 10 different people happy with surprises",
    emoji: "💖",
  },
  {
    slug: "ai-explorer",
    title_tr: "AI Kaşifi",
    title_en: "AI Explorer",
    description_tr: "AI önerilerini 5 kez kullan",
    description_en: "Use AI recommendations 5 times",
    emoji: "🤖",
  },
  {
    slug: "master-planner",
    title_tr: "Usta Plancı",
    title_en: "Master Planner",
    description_tr: "10 planı başarıyla tamamla",
    description_en: "Successfully complete 10 plans",
    emoji: "🎯",
  },
  {
    slug: "category-explorer",
    title_tr: "Kategori Kaşifi",
    title_en: "Category Explorer",
    description_tr: "5 farklı kategoride plan oluştur",
    description_en: "Create plans in 5 different categories",
    emoji: "🗺️",
  },
  {
    slug: "review-writer",
    title_tr: "Yorum Yazarı",
    title_en: "Review Writer",
    description_tr: "İlk değerlendirmeni yaz",
    description_en: "Write your first review",
    emoji: "✍️",
  },
  {
    slug: "surprise-10",
    title_tr: "10 Sürpriz",
    title_en: "10 Surprises",
    description_tr: "10 sürpriz tamamla",
    description_en: "Complete 10 surprises",
    emoji: "🏆",
  },
  {
    slug: "early-bird",
    title_tr: "Erken Kuş",
    title_en: "Early Bird",
    description_tr: "Sabah 6-9 arası plan oluştur",
    description_en: "Create a plan between 6-9 AM",
    emoji: "🐦",
  },
  {
    slug: "night-owl",
    title_tr: "Gece Kuşu",
    title_en: "Night Owl",
    description_tr: "Gece 23-03 arası plan oluştur",
    description_en: "Create a plan between 11 PM - 3 AM",
    emoji: "🦉",
  },
  {
    slug: "perfectionist",
    title_tr: "Mükemmeliyetçi",
    title_en: "Perfectionist",
    description_tr: "Bir plandaki tüm maddeleri tamamla",
    description_en: "Complete all items in a plan",
    emoji: "⭐",
  },
];

// ── Level Definitions ─────────────────────────────────────────────────

export interface LevelDef {
  level: number;
  title_tr: string;
  title_en: string;
  minXp: number;
  maxXp: number;
}

export const LEVELS: LevelDef[] = [
  { level: 1, title_tr: "Çaylak", title_en: "Novice", minXp: 0, maxXp: 100 },
  {
    level: 2,
    title_tr: "Başlangıç",
    title_en: "Beginner",
    minXp: 100,
    maxXp: 300,
  },
  {
    level: 3,
    title_tr: "Deneyimli",
    title_en: "Experienced",
    minXp: 300,
    maxXp: 600,
  },
  {
    level: 4,
    title_tr: "Yetenekli",
    title_en: "Talented",
    minXp: 600,
    maxXp: 1000,
  },
  { level: 5, title_tr: "Uzman", title_en: "Expert", minXp: 1000, maxXp: 1500 },
  { level: 6, title_tr: "Usta", title_en: "Master", minXp: 1500, maxXp: 2500 },
  {
    level: 7,
    title_tr: "Efsane",
    title_en: "Legend",
    minXp: 2500,
    maxXp: 4000,
  },
  {
    level: 8,
    title_tr: "Şampiyon",
    title_en: "Champion",
    minXp: 4000,
    maxXp: 6000,
  },
  { level: 9, title_tr: "Dahi", title_en: "Genius", minXp: 6000, maxXp: 9000 },
  {
    level: 10,
    title_tr: "Sürpriz Tanrısı",
    title_en: "Surprise God",
    minXp: 9000,
    maxXp: Infinity,
  },
];

// ── Store ─────────────────────────────────────────────────────────────

interface GamificationStats {
  totalPlans: number;
  completedPlans: number;
  totalSurprises: number;
  aiUsed: number;
  uniqueRecipients: number;
}

interface GamificationState {
  level: number;
  xp: number;
  totalXp: number;
  badges: Badge[];
  stats: GamificationStats;

  addXp: (amount: number, reason: string) => void;
  checkAndAwardBadge: (badgeSlug: string) => boolean;
  getLevelProgress: () => {
    current: LevelDef;
    next: LevelDef | null;
    percentage: number;
  };
  getLevel: (xp: number) => LevelDef;
  incrementStat: (key: keyof GamificationStats, amount?: number) => void;
  loadFromDB: () => Promise<void>;
  syncToDB: () => Promise<void>;
}

function getLevelForXp(xp: number): LevelDef {
  for (let i = LEVELS.length - 1; i >= 0; i--) {
    if (xp >= LEVELS[i].minXp) {
      return LEVELS[i];
    }
  }
  return LEVELS[0];
}

export const useGamificationStore = create<GamificationState>()(
  persist(
    (set, get) => ({
      level: 1,
      xp: 0,
      totalXp: 0,
      badges: [],
      stats: {
        totalPlans: 0,
        completedPlans: 0,
        totalSurprises: 0,
        aiUsed: 0,
        uniqueRecipients: 0,
      },

      addXp: (amount: number, reason: string) => {
        set((state) => {
          const newXp = state.xp + amount;
          const newTotalXp = state.totalXp + amount;
          const newLevel = getLevelForXp(newTotalXp);
          return {
            xp: newXp,
            totalXp: newTotalXp,
            level: newLevel.level,
          };
        });

        // Fire-and-forget: sync XP to DB via RPC
        addXpRemote(amount, reason).catch(() => {});
      },

      checkAndAwardBadge: (badgeSlug: string): boolean => {
        const state = get();
        const alreadyEarned = state.badges.some((b) => b.slug === badgeSlug);
        if (alreadyEarned) return false;

        const definition = BADGE_DEFINITIONS.find((d) => d.slug === badgeSlug);
        if (!definition) return false;

        const newBadge: Badge = {
          id: `badge-${Date.now()}`,
          slug: definition.slug,
          title_tr: definition.title_tr,
          title_en: definition.title_en,
          description_tr: definition.description_tr,
          description_en: definition.description_en,
          emoji: definition.emoji,
          unlockedAt: new Date().toISOString(),
        };

        set((state) => ({
          badges: [...state.badges, newBadge],
        }));

        // Fire-and-forget: sync badge to DB
        awardBadge(badgeSlug).catch(() => {});

        return true;
      },

      getLevelProgress: () => {
        const { totalXp } = get();
        const current = getLevelForXp(totalXp);
        const nextIndex =
          LEVELS.findIndex((l) => l.level === current.level) + 1;
        const next = nextIndex < LEVELS.length ? LEVELS[nextIndex] : null;

        if (!next) {
          return { current, next: null, percentage: 100 };
        }

        const progressInLevel = totalXp - current.minXp;
        const levelRange = next.minXp - current.minXp;
        const percentage = Math.min(
          100,
          Math.round((progressInLevel / levelRange) * 100),
        );

        return { current, next, percentage };
      },

      getLevel: (xp: number) => {
        return getLevelForXp(xp);
      },

      incrementStat: (key: keyof GamificationStats, amount = 1) => {
        set((state) => ({
          stats: {
            ...state.stats,
            [key]: state.stats[key] + amount,
          },
        }));
      },

      loadFromDB: async () => {
        try {
          const [gamData, badgeData] = await Promise.all([
            fetchGamification(),
            fetchBadges(),
          ]);

          if (gamData) {
            // Map DB badge slugs to full Badge objects
            const badges: Badge[] = badgeData.map((b) => {
              const def = BADGE_DEFINITIONS.find(
                (d) => d.slug === b.badge_slug,
              );
              return {
                id: `badge-${b.badge_slug}`,
                slug: b.badge_slug,
                title_tr: def?.title_tr ?? b.badge_slug,
                title_en: def?.title_en ?? b.badge_slug,
                description_tr: def?.description_tr ?? "",
                description_en: def?.description_en ?? "",
                emoji: def?.emoji ?? "",
                unlockedAt: b.unlocked_at,
              };
            });

            set({
              level: gamData.level,
              xp: gamData.xp,
              totalXp: gamData.total_xp,
              badges,
              stats: {
                totalPlans: gamData.total_plans,
                completedPlans: gamData.completed_plans,
                totalSurprises: gamData.total_surprises,
                aiUsed: gamData.ai_used,
                uniqueRecipients: gamData.unique_recipients ?? 0,
              },
            });
          }
        } catch (err) {
          if (__DEV__) {
            console.warn("loadFromDB failed:", err);
          }
        }
      },

      syncToDB: async () => {
        try {
          const { stats } = get();
          await syncStats({
            total_plans: stats.totalPlans,
            completed_plans: stats.completedPlans,
            total_surprises: stats.totalSurprises,
            ai_used: stats.aiUsed,
            unique_recipients: stats.uniqueRecipients,
          });
        } catch (err) {
          if (__DEV__) {
            console.warn("syncToDB failed:", err);
          }
        }
      },
    }),
    {
      name: "momentra-gamification",
      storage: createJSONStorage(() => AsyncStorage),
      partialize: (state) => ({
        level: state.level,
        xp: state.xp,
        totalXp: state.totalXp,
        badges: state.badges,
        stats: state.stats,
      }),
    },
  ),
);
