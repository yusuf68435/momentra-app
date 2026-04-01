import React from "react";
import { View } from "react-native";
import Svg, {
  Defs,
  LinearGradient,
  Stop,
  Rect,
  Ellipse,
  Line,
  Circle,
  G,
  Path,
  Filter,
  FeDropShadow,
  FeGaussianBlur,
  FeMerge,
  FeMergeNode,
} from "react-native-svg";
import { useTheme } from "../../contexts/ThemeContext";

interface MomentraLogoProps {
  size?: number;
}

export function MomentraLogo({ size = 80 }: MomentraLogoProps) {
  const { isDark } = useTheme();

  if (isDark) {
    return (
      <View style={{ width: size, height: size }}>
        <Svg viewBox="0 0 512 512" width={size} height={size}>
          <Defs>
            <LinearGradient id="bgDark" x1="0%" y1="0%" x2="100%" y2="100%">
              <Stop offset="0%" stopColor="#0d0d1a" />
              <Stop offset="100%" stopColor="#17172a" />
            </LinearGradient>
            <LinearGradient id="mDark" x1="0%" y1="0%" x2="100%" y2="100%">
              <Stop offset="0%" stopColor="#d4af60" />
              <Stop offset="50%" stopColor="#e8c97a" />
              <Stop offset="100%" stopColor="#9A7420" />
            </LinearGradient>
            <LinearGradient id="sparkDark" x1="0%" y1="0%" x2="100%" y2="100%">
              <Stop offset="0%" stopColor="#FFE08A" />
              <Stop offset="100%" stopColor="#d4af60" />
            </LinearGradient>
          </Defs>

          {/* Outer ring */}
          <Rect
            x="14"
            y="14"
            width="484"
            height="484"
            rx="110"
            ry="110"
            fill="none"
            stroke="#d4af60"
            strokeWidth="1.5"
            opacity={0.25}
          />
          {/* Background */}
          <Rect
            x="16"
            y="16"
            width="480"
            height="480"
            rx="108"
            ry="108"
            fill="url(#bgDark)"
          />
          {/* Inner glow */}
          <Ellipse
            cx="256"
            cy="140"
            rx="200"
            ry="90"
            fill="rgba(212,175,96,0.05)"
          />

          {/* M glow */}
          <G
            stroke="#d4af60"
            strokeLinecap="round"
            strokeLinejoin="round"
            fill="none"
            opacity={0.18}
          >
            <Line x1="146" y1="340" x2="146" y2="190" strokeWidth="48" />
            <Line x1="146" y1="190" x2="256" y2="295" strokeWidth="46" />
            <Line x1="256" y1="295" x2="366" y2="190" strokeWidth="46" />
            <Line x1="366" y1="190" x2="366" y2="340" strokeWidth="48" />
          </G>

          {/* M main */}
          <G
            stroke="url(#mDark)"
            strokeLinecap="round"
            strokeLinejoin="round"
            fill="none"
          >
            <Line
              x1="146"
              y1="340"
              x2="146"
              y2="190"
              strokeWidth="30"
              opacity={0.97}
            />
            <Line
              x1="146"
              y1="190"
              x2="256"
              y2="295"
              strokeWidth="28"
              opacity={0.97}
            />
            <Line
              x1="256"
              y1="295"
              x2="366"
              y2="190"
              strokeWidth="28"
              opacity={0.97}
            />
            <Line
              x1="366"
              y1="190"
              x2="366"
              y2="340"
              strokeWidth="30"
              opacity={0.97}
            />
          </G>

          {/* Sparkle top center */}
          <G transform="translate(256, 128)">
            <Path
              d="M0,-28 L5,-8 L24,-12 L10,2 L18,22 L0,12 L-18,22 L-10,2 L-24,-12 L-5,-8 Z"
              fill="url(#sparkDark)"
            />
          </G>
          {/* Sparkle top-right */}
          <G transform="translate(380, 115) scale(0.6)">
            <Path
              d="M0,-28 L5,-8 L24,-12 L10,2 L18,22 L0,12 L-18,22 L-10,2 L-24,-12 L-5,-8 Z"
              fill="url(#sparkDark)"
              opacity={0.9}
            />
          </G>
          {/* Sparkle top-left */}
          <G transform="translate(155, 135) scale(0.45)">
            <Path
              d="M0,-28 L5,-8 L24,-12 L10,2 L18,22 L0,12 L-18,22 L-10,2 L-24,-12 L-5,-8 Z"
              fill="url(#sparkDark)"
              opacity={0.85}
            />
          </G>
          <Circle cx="118" cy="160" r="4" fill="#d4af60" opacity={0.6} />
          <Circle cx="420" cy="135" r="3" fill="#d4af60" opacity={0.5} />
        </Svg>
      </View>
    );
  }

  // Light mode
  return (
    <View style={{ width: size, height: size }}>
      <Svg viewBox="0 0 512 512" width={size} height={size}>
        <Defs>
          <LinearGradient id="bgLight" x1="0%" y1="0%" x2="100%" y2="100%">
            <Stop offset="0%" stopColor="#F9F6F0" />
            <Stop offset="100%" stopColor="#EDE7DA" />
          </LinearGradient>
          <LinearGradient id="mLight" x1="0%" y1="0%" x2="100%" y2="100%">
            <Stop offset="0%" stopColor="#7A5C11" />
            <Stop offset="50%" stopColor="#9A7420" />
            <Stop offset="100%" stopColor="#5C4409" />
          </LinearGradient>
          <LinearGradient id="sparkLight" x1="0%" y1="0%" x2="100%" y2="100%">
            <Stop offset="0%" stopColor="#d4af60" />
            <Stop offset="100%" stopColor="#B8942E" />
          </LinearGradient>
        </Defs>

        {/* Border ring */}
        <Rect
          x="14"
          y="14"
          width="484"
          height="484"
          rx="110"
          ry="110"
          fill="none"
          stroke="#B8942E"
          strokeWidth="2"
          opacity={0.35}
        />
        {/* Background */}
        <Rect
          x="16"
          y="16"
          width="480"
          height="480"
          rx="108"
          ry="108"
          fill="url(#bgLight)"
        />
        {/* Inner warm glow */}
        <Ellipse
          cx="256"
          cy="140"
          rx="180"
          ry="80"
          fill="rgba(212,175,96,0.06)"
        />

        {/* M depth glow */}
        <G
          stroke="#d4af60"
          strokeLinecap="round"
          strokeLinejoin="round"
          fill="none"
          opacity={0.12}
        >
          <Line x1="146" y1="340" x2="146" y2="190" strokeWidth="42" />
          <Line x1="146" y1="190" x2="256" y2="295" strokeWidth="40" />
          <Line x1="256" y1="295" x2="366" y2="190" strokeWidth="40" />
          <Line x1="366" y1="190" x2="366" y2="340" strokeWidth="42" />
        </G>

        {/* M main */}
        <G
          stroke="url(#mLight)"
          strokeLinecap="round"
          strokeLinejoin="round"
          fill="none"
        >
          <Line
            x1="146"
            y1="340"
            x2="146"
            y2="190"
            strokeWidth="30"
            opacity={0.95}
          />
          <Line
            x1="146"
            y1="190"
            x2="256"
            y2="295"
            strokeWidth="28"
            opacity={0.95}
          />
          <Line
            x1="256"
            y1="295"
            x2="366"
            y2="190"
            strokeWidth="28"
            opacity={0.95}
          />
          <Line
            x1="366"
            y1="190"
            x2="366"
            y2="340"
            strokeWidth="30"
            opacity={0.95}
          />
        </G>

        {/* Sparkle top center */}
        <G transform="translate(256, 128)">
          <Path
            d="M0,-28 L5,-8 L24,-12 L10,2 L18,22 L0,12 L-18,22 L-10,2 L-24,-12 L-5,-8 Z"
            fill="url(#sparkLight)"
          />
        </G>
        {/* Sparkle top-right */}
        <G transform="translate(380, 115) scale(0.6)">
          <Path
            d="M0,-28 L5,-8 L24,-12 L10,2 L18,22 L0,12 L-18,22 L-10,2 L-24,-12 L-5,-8 Z"
            fill="url(#sparkLight)"
            opacity={0.85}
          />
        </G>
        {/* Sparkle top-left */}
        <G transform="translate(155, 135) scale(0.45)">
          <Path
            d="M0,-28 L5,-8 L24,-12 L10,2 L18,22 L0,12 L-18,22 L-10,2 L-24,-12 L-5,-8 Z"
            fill="url(#sparkLight)"
            opacity={0.8}
          />
        </G>
        <Circle cx="118" cy="160" r="4" fill="#B8942E" opacity={0.55} />
        <Circle cx="420" cy="135" r="3" fill="#B8942E" opacity={0.45} />
      </Svg>
    </View>
  );
}
