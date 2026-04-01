import { useGamificationStore, LEVELS, BADGE_DEFINITIONS } from '../../src/stores/gamificationStore';

/**
 * Reset the gamification store to its initial state between tests.
 */
function resetStore() {
  useGamificationStore.setState({
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
  });
}

beforeEach(() => {
  resetStore();
  jest.restoreAllMocks();
});

// ── addXp and level calculation ──────────────────────────────────────

describe('gamificationStore – addXp', () => {
  it('adds XP to current xp and totalXp', () => {
    useGamificationStore.getState().addXp(50, 'test');
    const state = useGamificationStore.getState();

    expect(state.xp).toBe(50);
    expect(state.totalXp).toBe(50);
  });

  it('accumulates XP across multiple calls', () => {
    useGamificationStore.getState().addXp(30, 'first');
    useGamificationStore.getState().addXp(70, 'second');
    const state = useGamificationStore.getState();

    expect(state.xp).toBe(100);
    expect(state.totalXp).toBe(100);
  });

  it('levels up when XP reaches level threshold', () => {
    // Level 1: 0-99, Level 2: 100-299
    useGamificationStore.getState().addXp(100, 'level-up');
    expect(useGamificationStore.getState().level).toBe(2);
  });

  it('stays at level 1 when XP is below 100', () => {
    useGamificationStore.getState().addXp(99, 'almost');
    expect(useGamificationStore.getState().level).toBe(1);
  });

  it('jumps multiple levels when receiving large XP', () => {
    // Level 3 starts at 300 XP
    useGamificationStore.getState().addXp(300, 'big-boost');
    expect(useGamificationStore.getState().level).toBe(3);
  });

  it('caps at the highest level', () => {
    useGamificationStore.getState().addXp(10000, 'max-out');
    const maxLevel = LEVELS[LEVELS.length - 1].level;
    expect(useGamificationStore.getState().level).toBe(maxLevel);
  });
});

// ── checkAndAwardBadge ───────────────────────────────────────────────

describe('gamificationStore – checkAndAwardBadge', () => {
  it('awards a badge that the user does not already have', () => {
    const result = useGamificationStore.getState().checkAndAwardBadge('first-plan');
    expect(result).toBe(true);

    const badges = useGamificationStore.getState().badges;
    expect(badges).toHaveLength(1);
    expect(badges[0].slug).toBe('first-plan');
    expect(badges[0].unlockedAt).toBeTruthy();
  });

  it('returns false when the badge is already earned', () => {
    useGamificationStore.getState().checkAndAwardBadge('first-plan');
    const result = useGamificationStore.getState().checkAndAwardBadge('first-plan');

    expect(result).toBe(false);
    expect(useGamificationStore.getState().badges).toHaveLength(1);
  });

  it('returns false for an unknown badge slug', () => {
    const result = useGamificationStore.getState().checkAndAwardBadge('nonexistent-badge');
    expect(result).toBe(false);
    expect(useGamificationStore.getState().badges).toHaveLength(0);
  });

  it('populates badge fields from BADGE_DEFINITIONS', () => {
    useGamificationStore.getState().checkAndAwardBadge('first-surprise');
    const badge = useGamificationStore.getState().badges[0];
    const definition = BADGE_DEFINITIONS.find((d) => d.slug === 'first-surprise')!;

    expect(badge.title_tr).toBe(definition.title_tr);
    expect(badge.title_en).toBe(definition.title_en);
    expect(badge.description_tr).toBe(definition.description_tr);
    expect(badge.description_en).toBe(definition.description_en);
    expect(badge.emoji).toBe(definition.emoji);
  });

  it('can award multiple different badges', () => {
    useGamificationStore.getState().checkAndAwardBadge('first-plan');
    useGamificationStore.getState().checkAndAwardBadge('first-surprise');
    useGamificationStore.getState().checkAndAwardBadge('budget-hero');

    expect(useGamificationStore.getState().badges).toHaveLength(3);
    const slugs = useGamificationStore.getState().badges.map((b) => b.slug);
    expect(slugs).toContain('first-plan');
    expect(slugs).toContain('first-surprise');
    expect(slugs).toContain('budget-hero');
  });

  it('awards milestone badges (happy-3, happy-10)', () => {
    const result3 = useGamificationStore.getState().checkAndAwardBadge('happy-3');
    expect(result3).toBe(true);

    const result10 = useGamificationStore.getState().checkAndAwardBadge('happy-10');
    expect(result10).toBe(true);

    const badges = useGamificationStore.getState().badges;
    expect(badges).toHaveLength(2);
    expect(badges[0].slug).toBe('happy-3');
    expect(badges[0].emoji).toBe('❤️');
    expect(badges[1].slug).toBe('happy-10');
    expect(badges[1].emoji).toBe('💖');
  });
});

// ── getLevelProgress ─────────────────────────────────────────────────

describe('gamificationStore – getLevelProgress', () => {
  it('returns 0% progress at the start of level 1', () => {
    const progress = useGamificationStore.getState().getLevelProgress();

    expect(progress.current.level).toBe(1);
    expect(progress.next).not.toBeNull();
    expect(progress.next!.level).toBe(2);
    expect(progress.percentage).toBe(0);
  });

  it('returns 50% progress halfway through level 1 (50/100 XP)', () => {
    useGamificationStore.getState().addXp(50, 'half');
    const progress = useGamificationStore.getState().getLevelProgress();

    expect(progress.current.level).toBe(1);
    expect(progress.percentage).toBe(50);
  });

  it('returns correct progress at start of level 2', () => {
    useGamificationStore.getState().addXp(100, 'level-up');
    const progress = useGamificationStore.getState().getLevelProgress();

    expect(progress.current.level).toBe(2);
    expect(progress.next!.level).toBe(3);
    // At 100 XP, level 2 range is 100-300, so 0/200 = 0%
    expect(progress.percentage).toBe(0);
  });

  it('returns 100% at max level', () => {
    useGamificationStore.getState().addXp(10000, 'max');
    const progress = useGamificationStore.getState().getLevelProgress();

    const maxLevel = LEVELS[LEVELS.length - 1].level;
    expect(progress.current.level).toBe(maxLevel);
    expect(progress.next).toBeNull();
    expect(progress.percentage).toBe(100);
  });

  it('returns a percentage between 0 and 100 for mid-level XP', () => {
    // Level 2: 100-300, midpoint ~200 => 50%
    useGamificationStore.getState().addXp(200, 'mid');
    const progress = useGamificationStore.getState().getLevelProgress();

    expect(progress.current.level).toBe(2);
    expect(progress.percentage).toBe(50);
  });
});

// ── getLevel ─────────────────────────────────────────────────────────

describe('gamificationStore – getLevel', () => {
  it('returns level 1 for 0 XP', () => {
    const level = useGamificationStore.getState().getLevel(0);
    expect(level.level).toBe(1);
  });

  it('returns level 2 for 100 XP', () => {
    const level = useGamificationStore.getState().getLevel(100);
    expect(level.level).toBe(2);
  });

  it('returns the max level for very high XP', () => {
    const level = useGamificationStore.getState().getLevel(100000);
    expect(level.level).toBe(LEVELS[LEVELS.length - 1].level);
  });
});

// ── incrementStat ────────────────────────────────────────────────────

describe('gamificationStore – incrementStat', () => {
  it('increments totalPlans by 1', () => {
    useGamificationStore.getState().incrementStat('totalPlans');
    expect(useGamificationStore.getState().stats.totalPlans).toBe(1);
  });

  it('increments by a custom amount', () => {
    useGamificationStore.getState().incrementStat('aiUsed', 5);
    expect(useGamificationStore.getState().stats.aiUsed).toBe(5);
  });

  it('accumulates increments', () => {
    useGamificationStore.getState().incrementStat('completedPlans');
    useGamificationStore.getState().incrementStat('completedPlans');
    useGamificationStore.getState().incrementStat('completedPlans');
    expect(useGamificationStore.getState().stats.completedPlans).toBe(3);
  });

  it('increments uniqueRecipients', () => {
    useGamificationStore.getState().incrementStat('uniqueRecipients');
    useGamificationStore.getState().incrementStat('uniqueRecipients');
    expect(useGamificationStore.getState().stats.uniqueRecipients).toBe(2);
  });
});
