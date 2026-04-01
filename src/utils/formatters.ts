export function formatCurrency(
  amount: number,
  currency: 'TRY' | 'USD' | 'EUR' = 'TRY'
): string {
  const symbols: Record<string, string> = {
    TRY: '₺',
    USD: '$',
    EUR: '€',
  };
  return `${symbols[currency]}${amount.toLocaleString()}`;
}

export function formatBudgetRange(
  min: number | null,
  max: number | null,
  currency: 'TRY' | 'USD' | 'EUR' = 'TRY'
): string {
  if (min == null && max == null) return '-';
  if (min != null && max != null) return `${formatCurrency(min, currency)} - ${formatCurrency(max, currency)}`;
  if (min != null) return `${formatCurrency(min, currency)}+`;
  return formatCurrency(max!, currency);
}

export function formatDate(dateString: string, language: 'tr' | 'en' = 'tr'): string {
  const date = new Date(dateString);
  return date.toLocaleDateString(language === 'tr' ? 'tr-TR' : 'en-US', {
    day: 'numeric',
    month: 'long',
    year: 'numeric',
  });
}

export function formatRelativeDate(dateString: string, language: 'tr' | 'en' = 'tr'): string {
  const date = new Date(dateString);
  const now = new Date();
  const diffDays = Math.ceil((date.getTime() - now.getTime()) / (1000 * 60 * 60 * 24));

  if (diffDays === 0) return language === 'tr' ? 'Bugün' : 'Today';
  if (diffDays === 1) return language === 'tr' ? 'Yarın' : 'Tomorrow';
  if (diffDays < 0) return language === 'tr' ? 'Geçmiş' : 'Past';
  if (diffDays <= 7) return language === 'tr' ? `${diffDays} gün sonra` : `In ${diffDays} days`;
  return formatDate(dateString, language);
}

export function getDifficultyLabel(difficulty: number, language: 'tr' | 'en' = 'tr'): string {
  const labels = {
    tr: ['Çok Kolay', 'Kolay', 'Orta', 'Zor', 'Çok Zor'],
    en: ['Very Easy', 'Easy', 'Medium', 'Hard', 'Very Hard'],
  };
  return labels[language][Math.max(0, Math.min(difficulty - 1, 4))] || '';
}
