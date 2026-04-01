import type { IconName } from "./icons";

export interface ExpenseCategoryConfig {
  icon: IconName;
  color: string;
  labelKey: string;
}

/**
 * Shared expense category configuration.
 * Used by BudgetTracker, ExpenseItem, BudgetAnalytics.
 * Colors are semantic — they distinguish categories, not driven by theme.
 */
export const EXPENSE_CATEGORIES: Record<string, ExpenseCategoryConfig> = {
  gift: { icon: "gift", color: "#E91E63", labelKey: "expenses.cat_gift" },
  food: { icon: "food", color: "#FF9800", labelKey: "expenses.cat_food" },
  decoration: {
    icon: "party-popper",
    color: "#9C27B0",
    labelKey: "expenses.cat_decoration",
  },
  venue: {
    icon: "map-marker",
    color: "#2196F3",
    labelKey: "expenses.cat_venue",
  },
  entertainment: {
    icon: "music",
    color: "#4CAF50",
    labelKey: "expenses.cat_entertainment",
  },
  transport: {
    icon: "car",
    color: "#607D8B",
    labelKey: "expenses.cat_transport",
  },
  other: {
    icon: "dots-horizontal",
    color: "#795548",
    labelKey: "expenses.cat_other",
  },
};
