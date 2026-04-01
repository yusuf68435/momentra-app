import React from "react";
import { View, Text, StyleSheet } from "react-native";
import Svg, {
  Defs,
  LinearGradient,
  RadialGradient,
  Stop,
  Line,
  G,
  Path,
  Circle,
  Rect,
} from "react-native-svg";
import { useTheme } from "../../contexts/ThemeContext";

interface MomentraLogoProps {
  size?: number;
  showText?: boolean;
  showTagline?: boolean;
  variant?: "icon" | "full" | "wordmark";
}

// 4-pointed sparkle path (centered at 0,0)
const SPARKLE =
  "M0,-24 L4,-7 L20,-10 L8,2 L14,18 L0,10 L-14,18 L-8,2 L-20,-10 L-4,-7 Z";

export const MomentraLogo: React.FC<MomentraLogoProps> = ({
  size = 80,
  showText = true,
  showTagline = false,
  variant = "full",
}) => {
  const { colors, isDark } = useTheme();

  if (variant === "wordmark") {
    return (
      <View style={styles.wordmarkContainer}>
        <Text
          style={[
            styles.wordmark,
            { color: colors.primary, fontSize: size * 0.5 },
          ]}
        >
          Momentra
        </Text>
        <Text style={[styles.sparkleText, { fontSize: size * 0.2 }]}>✨</Text>
        {showTagline && (
          <Text
            style={[
              styles.tagline,
              { color: colors.textSecondary, fontSize: size * 0.15 },
            ]}
          >
            EVERY MOMENT, EXTRA
          </Text>
        )}
      </View>
    );
  }

  // #94 Evolved — Classic Diagonal Gold + double-glow M + 3 sparkles
  // Light: warm gold diagonal, white M
  // Dark:  deep gold diagonal, white M
  const bgStart = isDark ? "#c8a040" : "#b07820";
  const bgMid = isDark ? "#d4af60" : "#9A7420";
  const bgEnd = isDark ? "#8a5e18" : "#6a4c0e";
  const hlOpacity = isDark ? 0.26 : 0.4;
  const sparkleColor = "rgba(255,250,220,0.88)";

  return (
    <View
      style={[
        styles.container,
        {
          width: variant === "full" ? undefined : size,
          alignItems: variant === "full" ? "center" : undefined,
        },
      ]}
    >
      <Svg width={size} height={size} viewBox="0 0 512 512">
        <Defs>
          {/* Diagonal gold background gradient */}
          <LinearGradient id="bgGrad" x1="0%" y1="0%" x2="100%" y2="100%">
            <Stop offset="0%" stopColor={bgStart} stopOpacity={1} />
            <Stop offset="45%" stopColor={bgMid} stopOpacity={1} />
            <Stop offset="100%" stopColor={bgEnd} stopOpacity={1} />
          </LinearGradient>
          {/* Top-left radial highlight */}
          <RadialGradient
            id="hlGrad"
            cx="36%"
            cy="24%"
            r="52%"
            fx="36%"
            fy="24%"
          >
            <Stop offset="0%" stopColor="#fffce0" stopOpacity={hlOpacity} />
            <Stop offset="100%" stopColor="#e8b830" stopOpacity={0} />
          </RadialGradient>
        </Defs>

        {/* Background — gold gradient rounded square */}
        <Rect
          x="0"
          y="0"
          width="512"
          height="512"
          rx="115"
          ry="115"
          fill="url(#bgGrad)"
        />
        {/* Highlight layer */}
        <Circle cx="195" cy="165" r="215" fill="url(#hlGrad)" />

        {/* M Letter — wide soft glow layer */}
        <G
          fill="none"
          stroke="rgba(255,255,255,0.14)"
          strokeLinecap="round"
          strokeLinejoin="round"
        >
          <Line x1="148" y1="345" x2="148" y2="185" strokeWidth="62" />
          <Line x1="148" y1="185" x2="256" y2="298" strokeWidth="62" />
          <Line x1="256" y1="298" x2="364" y2="185" strokeWidth="62" />
          <Line x1="364" y1="185" x2="364" y2="345" strokeWidth="62" />
        </G>

        {/* M Letter — crisp white main stroke */}
        <G
          fill="none"
          stroke="#ffffff"
          strokeLinecap="round"
          strokeLinejoin="round"
          opacity={0.97}
        >
          <Line x1="148" y1="345" x2="148" y2="185" strokeWidth="30" />
          <Line x1="148" y1="185" x2="256" y2="298" strokeWidth="30" />
          <Line x1="256" y1="298" x2="364" y2="185" strokeWidth="30" />
          <Line x1="364" y1="185" x2="364" y2="345" strokeWidth="30" />
        </G>

        {/* ✨ Sparkle — top center (large) */}
        <G transform="translate(256, 108) scale(0.90)">
          <Path d={SPARKLE} fill={sparkleColor} />
        </G>

        {/* ✨ Sparkle — top right (medium) */}
        <G transform="translate(374, 122) scale(0.54)">
          <Path d={SPARKLE} fill="rgba(255,250,220,0.64)" />
        </G>

        {/* ✨ Sparkle — top left (small) */}
        <G transform="translate(150, 136) scale(0.40)">
          <Path d={SPARKLE} fill="rgba(255,250,220,0.52)" />
        </G>
      </Svg>

      {/* Text below icon */}
      {showText && variant === "full" && (
        <View style={styles.textContainer}>
          <Text style={[styles.brandName, { color: colors.text }]}>
            Momentra
          </Text>
          {showTagline && (
            <Text style={[styles.tagline, { color: colors.textSecondary }]}>
              EVERY MOMENT, EXTRA
            </Text>
          )}
        </View>
      )}
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    alignItems: "center",
  },
  textContainer: {
    alignItems: "center",
    marginTop: 12,
  },
  brandName: {
    fontSize: 28,
    fontWeight: "700",
    letterSpacing: -0.8,
  },
  tagline: {
    fontSize: 11,
    fontWeight: "300",
    letterSpacing: 4,
    marginTop: 4,
    textTransform: "uppercase",
  },
  wordmarkContainer: {
    flexDirection: "row",
    alignItems: "center",
    flexWrap: "wrap",
    justifyContent: "center",
  },
  wordmark: {
    fontWeight: "700",
    letterSpacing: -1,
  },
  sparkleText: {
    marginLeft: 2,
    marginTop: -8,
  },
});

export default MomentraLogo;
