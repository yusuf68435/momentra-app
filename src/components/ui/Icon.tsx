import React, { memo } from 'react';
import Svg, { Path } from 'react-native-svg';
import { ICON_PATHS, type IconName } from '../../constants/icons';

export type { IconName };

interface IconProps {
  /** Icon name from the icon registry */
  name: IconName;
  /** Icon size in pixels (default: 24) */
  size?: number;
  /** Icon color (default: "currentColor") */
  color?: string;
  /** Accessibility label */
  accessibilityLabel?: string;
}

const IconComponent: React.FC<IconProps> = ({
  name,
  size = 24,
  color = 'currentColor',
  accessibilityLabel,
}) => {
  const iconData = ICON_PATHS[name];

  if (!iconData) {
    if (__DEV__) {
      console.warn(`[Icon] Unknown icon name: "${name}"`);
    }
    // Render an empty placeholder with the correct dimensions
    return (
      <Svg
        width={size}
        height={size}
        viewBox="0 0 24 24"
        accessibilityLabel={accessibilityLabel}
      />
    );
  }

  const viewBox = iconData.viewBox ?? '0 0 24 24';

  return (
    <Svg
      width={size}
      height={size}
      viewBox={viewBox}
      accessibilityLabel={accessibilityLabel}
      accessibilityRole="image"
    >
      <Path d={iconData.path} fill={color} />
    </Svg>
  );
};

export const Icon = memo(IconComponent);
