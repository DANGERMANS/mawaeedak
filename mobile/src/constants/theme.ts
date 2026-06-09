/**
 * Theme Constants — Mawaeedak Mobile Design System
 * 
 * Saudi Identity: Luxurious, calm, organized
 * Colors: Gold (#C9A063), Brown (#8A6B3D), Cream (#FAF7F2)
 */

export const THEME = {
  // Primary Colors
  primary: '#C9A063',        // Gold - luxurious
  secondary: '#8A6B3D',      // Brown - warm
  accent: '#2F2B25',          // Dark - elegant
  
  // Backgrounds
  background: '#FAF7F2',      // Cream - main bg
  surface: '#FFFFFF',         // White - cards
  surfaceAlt: '#F5EFE6',     // Light cream - secondary
  
  // Text
  text: '#2F2B25',            // Dark - primary text
  textSecondary: '#6F6557',    // Brown gray - secondary
  textMuted: '#9C9083',      // Light - hints
  
  // Semantic
  error: '#B45A4D',          // Terracotta - errors
  success: '#7A9A74',        // Olive - success
  warning: '#D4A84B',        // Amber - warnings
  info: '#6B8E9F',           // Steel blue - info
  
  // Borders
  border: '#DCD7CF',          // Soft gray
  borderLight: '#EAE5DD',    // Light gray
  
  // Shadows
  shadow: 'rgba(47, 43, 37, 0.08)',
  
  // Spacing
  spacing: {
    xs: 4,
    sm: 8,
    md: 16,
    lg: 24,
    xl: 32,
    xxl: 48,
  },
  
  // Border Radius
  radius: {
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    full: 9999,
  },
  
  // Font Sizes
  fontSize: {
    xs: 10,
    sm: 12,
    md: 14,
    lg: 16,
    xl: 18,
    xxl: 24,
    xxxl: 32,
  },
  
  // Font Weights
  fontWeight: {
    normal: '400',
    medium: '500',
    semibold: '600',
    bold: '700',
  },
} as const;

export type ThemeColors = typeof THEME;