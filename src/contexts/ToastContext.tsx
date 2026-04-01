import React, { createContext, useContext, useState, useCallback, useRef } from 'react';
import { StyleSheet, View } from 'react-native';
import { Toast, ToastData, ToastType } from '../components/common/Toast';

interface ToastContextValue {
  showToast: (message: string, type: ToastType, duration?: number) => void;
}

const ToastContext = createContext<ToastContextValue | undefined>(undefined);

const DEFAULT_DURATION = 3000;
const MAX_VISIBLE_TOASTS = 3;

let toastIdCounter = 0;

export function ToastProvider({ children }: { children: React.ReactNode }) {
  const [toasts, setToasts] = useState<ToastData[]>([]);
  const queueRef = useRef<ToastData[]>([]);

  const processQueue = useCallback(() => {
    setToasts((current) => {
      if (current.length < MAX_VISIBLE_TOASTS && queueRef.current.length > 0) {
        const next = queueRef.current.shift()!;
        return [...current, next];
      }
      return current;
    });
  }, []);

  const dismissToast = useCallback(
    (id: string) => {
      setToasts((current) => current.filter((t) => t.id !== id));
      // After removing, check if there are queued toasts
      setTimeout(processQueue, 100);
    },
    [processQueue]
  );

  const showToast = useCallback(
    (message: string, type: ToastType, duration: number = DEFAULT_DURATION) => {
      const newToast: ToastData = {
        id: `toast-${++toastIdCounter}`,
        message,
        type,
        duration,
      };

      setToasts((current) => {
        if (current.length >= MAX_VISIBLE_TOASTS) {
          queueRef.current.push(newToast);
          return current;
        }
        return [...current, newToast];
      });
    },
    []
  );

  return (
    <ToastContext.Provider value={{ showToast }}>
      {children}
      <View style={styles.toastContainer} pointerEvents="box-none">
        {toasts.map((toast, index) => (
          <View
            key={toast.id}
            style={{ transform: [{ translateY: index * 70 }] }}
            pointerEvents="box-none"
          >
            <Toast toast={toast} onDismiss={dismissToast} />
          </View>
        ))}
      </View>
    </ToastContext.Provider>
  );
}

export function useToastContext(): ToastContextValue {
  const context = useContext(ToastContext);
  if (!context) {
    throw new Error('useToastContext must be used within a ToastProvider');
  }
  return context;
}

const styles = StyleSheet.create({
  toastContainer: {
    ...StyleSheet.absoluteFillObject,
    zIndex: 9999,
    elevation: 9999,
  },
});
