import { useState, useEffect, useRef } from 'react';

interface CountdownResult {
  days: number;
  hours: number;
  minutes: number;
  seconds: number;
  isExpired: boolean;
  totalSeconds: number;
}

export function useCountdown(targetDate: string, targetTime?: string | null): CountdownResult {
  const [timeLeft, setTimeLeft] = useState<CountdownResult>(() => calculate(targetDate, targetTime));
  const intervalRef = useRef<ReturnType<typeof setInterval> | null>(null);

  useEffect(() => {
    const initial = calculate(targetDate, targetTime);
    setTimeLeft(initial);

    if (initial.isExpired) return;

    intervalRef.current = setInterval(() => {
      const result = calculate(targetDate, targetTime);
      setTimeLeft(result);
      if (result.isExpired && intervalRef.current) {
        clearInterval(intervalRef.current);
        intervalRef.current = null;
      }
    }, 1000);

    return () => {
      if (intervalRef.current) {
        clearInterval(intervalRef.current);
        intervalRef.current = null;
      }
    };
  }, [targetDate, targetTime]);

  return timeLeft;
}

function calculate(targetDate: string, targetTime?: string | null): CountdownResult {
  const target = targetTime
    ? new Date(`${targetDate}T${targetTime}`)
    : new Date(`${targetDate}T00:00:00`);
  const now = new Date();
  const diff = target.getTime() - now.getTime();

  if (diff <= 0) {
    return { days: 0, hours: 0, minutes: 0, seconds: 0, isExpired: true, totalSeconds: 0 };
  }

  return {
    days: Math.floor(diff / (1000 * 60 * 60 * 24)),
    hours: Math.floor((diff / (1000 * 60 * 60)) % 24),
    minutes: Math.floor((diff / (1000 * 60)) % 60),
    seconds: Math.floor((diff / 1000) % 60),
    isExpired: false,
    totalSeconds: Math.floor(diff / 1000),
  };
}
