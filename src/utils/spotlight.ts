import { Platform } from 'react-native';

/**
 * Spotlight search indexing for iOS.
 * This provides the interface - native module integration would be needed for production.
 * For now, we store searchable items that can be indexed when native module is available.
 */

export interface SpotlightItem {
  uniqueIdentifier: string;
  title: string;
  contentDescription: string;
  keywords: string[];
  thumbnailUri?: string;
  domain: 'scenario' | 'plan';
}

// In-memory store for items to be indexed
const indexedItems: Map<string, SpotlightItem> = new Map();

/**
 * Index a scenario for Spotlight search
 */
export function indexScenario(scenario: {
  id: string;
  title: string;
  description: string;
  tags: string[];
  emoji: string;
}) {
  if (Platform.OS !== 'ios') return;

  const item: SpotlightItem = {
    uniqueIdentifier: `scenario-${scenario.id}`,
    title: scenario.title,
    contentDescription: scenario.description,
    keywords: [...scenario.tags, 'surprise', 'surpriz', scenario.emoji],
    domain: 'scenario',
  };

  indexedItems.set(item.uniqueIdentifier, item);

  // TODO: When native module is available, call:
  // NativeSpotlight.indexItem(item);
}

/**
 * Index a plan for Spotlight search
 */
export function indexPlan(plan: {
  id: string;
  title: string;
  recipientName?: string;
  eventDate?: string;
}) {
  if (Platform.OS !== 'ios') return;

  const keywords = ['plan', 'surprise', 'surpriz'];
  if (plan.recipientName) keywords.push(plan.recipientName);

  const item: SpotlightItem = {
    uniqueIdentifier: `plan-${plan.id}`,
    title: plan.title,
    contentDescription: plan.recipientName
      ? `Surprise for ${plan.recipientName}`
      : plan.title,
    keywords,
    domain: 'plan',
  };

  indexedItems.set(item.uniqueIdentifier, item);
}

/**
 * Remove an item from Spotlight index
 */
export function deindexItem(identifier: string) {
  indexedItems.delete(identifier);
}

/**
 * Remove all items from Spotlight index
 */
export function deindexAll() {
  indexedItems.clear();
}

/**
 * Get all indexed items (for debugging)
 */
export function getIndexedItems(): SpotlightItem[] {
  return Array.from(indexedItems.values());
}
