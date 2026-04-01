export interface CategoryDef {
  slug: string;
  icon: string;
  color: string;
  nameKey: string;
}

// Harmonious Apple-inspired color palette
// Each color is carefully balanced for visual cohesion
export const CATEGORIES: CategoryDef[] = [
  {
    slug: "proposal",
    icon: "diamond-stone",
    color: "#FF6B8A",
    nameKey: "categories.proposal",
  },
  {
    slug: "birthday",
    icon: "cake-variant",
    color: "#FFAA5C",
    nameKey: "categories.birthday",
  },
  {
    slug: "anniversary",
    icon: "heart",
    color: "#FF8A80",
    nameKey: "categories.anniversary",
  },
  {
    slug: "graduation",
    icon: "party-popper",
    color: "#A78BFA",
    nameKey: "categories.graduation",
  },
  {
    slug: "baby",
    icon: "heart-outline",
    color: "#6DD5A0",
    nameKey: "categories.baby",
  },
  {
    slug: "romantic",
    icon: "flower",
    color: "#F472B6",
    nameKey: "categories.romantic",
  },
  {
    slug: "friendship",
    icon: "account-group",
    color: "#60A5FA",
    nameKey: "categories.friendship",
  },
  {
    slug: "apology",
    icon: "account-heart",
    color: "#94A3B8",
    nameKey: "categories.apology",
  },
  {
    slug: "achievement",
    icon: "crown",
    color: "#FBBF24",
    nameKey: "categories.achievement",
  },
  {
    slug: "holiday",
    icon: "calendar-star",
    color: "#5EEAD4",
    nameKey: "categories.holiday",
  },
];

// Helper: look up a category color by slug
const categoryColorMap: Record<string, string> = Object.fromEntries(
  CATEGORIES.map((c) => [c.slug, c.color]),
);

/** Get category color by slug. Returns fallback for unknown slugs. */
export function getCategoryColor(slug: string, fallback = "#94A3B8"): string {
  return categoryColorMap[slug] || fallback;
}

/** Get gradient pair for a category (base color + darkened variant). */
export function getCategoryGradient(slug: string): [string, string] {
  const base = getCategoryColor(slug);
  // Darken by blending toward black at 30%
  const darken = (hex: string): string => {
    const r = parseInt(hex.slice(1, 3), 16);
    const g = parseInt(hex.slice(3, 5), 16);
    const b = parseInt(hex.slice(5, 7), 16);
    const f = 0.7;
    return `#${Math.round(r * f)
      .toString(16)
      .padStart(2, "0")}${Math.round(g * f)
      .toString(16)
      .padStart(2, "0")}${Math.round(b * f)
      .toString(16)
      .padStart(2, "0")}`;
  };
  return [base, darken(base)];
}

export const FREE_PLAN_LIMITS = {
  maxActivePlans: 3,
  aiRecommendationsPerMonth: 3,
};

export const PREMIUM_PRICES = {
  monthly: { TRY: 79.99, USD: 4.99 },
  yearly: { TRY: 599.99, USD: 39.99 },
};
