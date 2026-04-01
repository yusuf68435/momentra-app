import type { IconName } from "./icons";

export interface DateTypeConfig {
  icon: IconName;
  color: string;
  labelKey: string;
}

/**
 * Shared date type configuration.
 * Used by ImportantDateCard, AddDateModal.
 */
export const DATE_TYPE_CONFIG: Record<string, DateTypeConfig> = {
  birthday: {
    icon: "cake-variant",
    color: "#FF9800",
    labelKey: "dates.type_birthday",
  },
  anniversary: {
    icon: "heart",
    color: "#E91E63",
    labelKey: "dates.type_anniversary",
  },
  graduation: {
    icon: "school",
    color: "#9C27B0",
    labelKey: "dates.type_graduation",
  },
  other: {
    icon: "calendar-star",
    color: "#2196F3",
    labelKey: "dates.type_other",
  },
};

/** Array form for list rendering (AddDateModal). */
export const DATE_TYPE_OPTIONS = Object.entries(DATE_TYPE_CONFIG).map(
  ([key, config]) => ({
    key,
    ...config,
  }),
);
