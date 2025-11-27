# 🎨 OVERKOR-TEK Color Standards

**The Official Pink Revolution Color Palette**

**Last Updated:** 2025-11-27 | **Updated By:** CP2C2

---

## The Pink Revolution Palette

### Primary Colors

| Name | Hex | RGB | HSL | Usage |
|------|-----|-----|-----|-------|
| **Deep Pink** | `#FF1493` | `rgb(255, 20, 147)` | `hsl(328, 100%, 54%)` | Primary buttons, CTAs, main actions |
| **Hot Pink** | `#FF69B4` | `rgb(255, 105, 180)` | `hsl(330, 100%, 71%)` | Secondary elements, hovers |
| **Light Pink** | `#FFB6C1` | `rgb(255, 182, 193)` | `hsl(351, 100%, 86%)` | Backgrounds, subtle accents |

### Secondary Colors

| Name | Hex | RGB | HSL | Usage |
|------|-----|-----|-----|-------|
| **Medium Violet Red** | `#C71585` | `rgb(199, 21, 133)` | `hsl(322, 81%, 43%)` | Dark mode text, emphasis |
| **Medium Purple** | `#9370DB` | `rgb(147, 112, 219)` | `hsl(260, 60%, 65%)` | Operation Purple, special features |
| **Pale Violet Red** | `#DB7093` | `rgb(219, 112, 147)` | `hsl(340, 60%, 65%)` | Alternative secondary |

### Background Colors

| Name | Hex | RGB | Usage |
|------|-----|-----|-------|
| **Dark Pink Tint** | `#2d1f2d` | `rgb(45, 31, 45)` | Dark mode backgrounds |
| **Soft Pink** | `#FFF0F5` | `rgb(255, 240, 245)` | Light mode backgrounds |
| **Lavender Blush** | `#FFF0F5` | `rgb(255, 240, 245)` | Subtle backgrounds |

---

## CSS Variables

```css
:root {
  /* Primary Pink Palette */
  --pink-deep: #FF1493;
  --pink-hot: #FF69B4;
  --pink-light: #FFB6C1;

  /* Secondary Colors */
  --pink-dark: #C71585;
  --purple-medium: #9370DB;
  --pink-pale: #DB7093;

  /* Backgrounds */
  --bg-dark: #2d1f2d;
  --bg-light: #FFF0F5;

  /* Semantic Colors */
  --color-primary: var(--pink-deep);
  --color-secondary: var(--pink-hot);
  --color-accent: var(--pink-light);
  --color-special: var(--purple-medium);

  /* State Colors */
  --color-success: #FF69B4;
  --color-warning: #FFB6C1;
  --color-error: #C71585;
  --color-info: #9370DB;
}
```

---

## SCSS Variables

```scss
// Primary Pink Palette
$pink-deep: #FF1493;
$pink-hot: #FF69B4;
$pink-light: #FFB6C1;

// Secondary Colors
$pink-dark: #C71585;
$purple-medium: #9370DB;
$pink-pale: #DB7093;

// Backgrounds
$bg-dark: #2d1f2d;
$bg-light: #FFF0F5;

// Semantic Mapping
$color-primary: $pink-deep;
$color-secondary: $pink-hot;
$color-accent: $pink-light;
$color-special: $purple-medium;
```

---

## JavaScript Constants

```javascript
const PINK_COLORS = {
  // Primary
  deep: '#FF1493',
  hot: '#FF69B4',
  light: '#FFB6C1',

  // Secondary
  dark: '#C71585',
  purple: '#9370DB',
  pale: '#DB7093',

  // Backgrounds
  bgDark: '#2d1f2d',
  bgLight: '#FFF0F5'
};

// RGB versions
const PINK_RGB = {
  deep: 'rgb(255, 20, 147)',
  hot: 'rgb(255, 105, 180)',
  light: 'rgb(255, 182, 193)'
};
```

---

## Tailwind Configuration

```javascript
// tailwind.config.js
module.exports = {
  theme: {
    extend: {
      colors: {
        pink: {
          deep: '#FF1493',
          hot: '#FF69B4',
          light: '#FFB6C1',
          dark: '#C71585',
          pale: '#DB7093'
        },
        purple: {
          medium: '#9370DB'
        },
        background: {
          dark: '#2d1f2d',
          light: '#FFF0F5'
        }
      }
    }
  }
}
```

---

## Color Migration Reference

When transforming blue colors to pink, use this mapping:

| Old Blue | New Pink | Notes |
|----------|----------|-------|
| `#007bff` (Bootstrap Primary) | `#FF1493` (Deep Pink) | Primary buttons |
| `#17a2b8` (Bootstrap Info) | `#FF69B4` (Hot Pink) | Info elements |
| `#0d6efd` (Bootstrap 5 Primary) | `#FF1493` (Deep Pink) | Primary actions |
| `#0dcaf0` (Bootstrap 5 Cyan) | `#FFB6C1` (Light Pink) | Accents |
| `#1e1e1e` (Dark Background) | `#2d1f2d` (Dark Pink Tint) | Dark mode |
| `#f8f9fa` (Light Background) | `#FFF0F5` (Lavender Blush) | Light mode |

---

## Usage Guidelines

### Buttons

```css
/* Primary Button */
.btn-primary {
  background-color: #FF1493;
  color: white;
}

.btn-primary:hover {
  background-color: #FF69B4;
}

/* Secondary Button */
.btn-secondary {
  background-color: #FF69B4;
  color: white;
}

.btn-secondary:hover {
  background-color: #FFB6C1;
  color: #2d1f2d;
}
```

### Links

```css
a {
  color: #FF1493;
}

a:hover {
  color: #C71585;
}

a:visited {
  color: #9370DB;
}
```

### Backgrounds

```css
/* Light Mode */
body.light {
  background-color: #FFF0F5;
  color: #2d1f2d;
}

/* Dark Mode */
body.dark {
  background-color: #2d1f2d;
  color: #FFB6C1;
}
```

---

## Accessibility Notes

### Contrast Ratios

| Combination | Ratio | WCAG Level |
|-------------|-------|------------|
| Deep Pink on White | 3.14:1 | AA Large Text |
| Deep Pink on Dark (#2d1f2d) | 5.89:1 | AA All Text |
| Hot Pink on Dark (#2d1f2d) | 7.42:1 | AAA All Text |
| Light Pink on Dark (#2d1f2d) | 10.23:1 | AAA All Text |
| Dark Pink on White | 5.62:1 | AA All Text |

### Recommendations

1. Use **Deep Pink** for large text and icons on white backgrounds
2. Use **Light Pink** for text on dark backgrounds
3. Always test contrast with WebAIM Contrast Checker
4. Provide focus indicators in **Hot Pink** or **Medium Purple**

---

## Operation Purple 🟣

Special color reserved for Operation Purple notification system:

| Name | Hex | Usage |
|------|-----|-------|
| Medium Purple | `#9370DB` | Operation Purple branding, special features |

```css
.operation-purple {
  background-color: #9370DB;
  color: white;
}
```

---

## Color Palette Visualization

```
┌─────────────────────────────────────────────────────────────────┐
│                     THE PINK REVOLUTION                         │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  ████████████████  Deep Pink (#FF1493) - Primary                │
│                                                                 │
│  ████████████████  Hot Pink (#FF69B4) - Secondary               │
│                                                                 │
│  ████████████████  Light Pink (#FFB6C1) - Accent                │
│                                                                 │
│  ████████████████  Dark Pink (#C71585) - Emphasis               │
│                                                                 │
│  ████████████████  Medium Purple (#9370DB) - Special            │
│                                                                 │
│  ████████████████  Dark Tint (#2d1f2d) - Background             │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

---

## Quick Reference Card

```
PRIMARY:    #FF1493 (Deep Pink)     - Buttons, CTAs
SECONDARY:  #FF69B4 (Hot Pink)      - Hovers, Secondary
ACCENT:     #FFB6C1 (Light Pink)    - Backgrounds, Subtle
DARK:       #C71585 (Medium Violet) - Text emphasis
SPECIAL:    #9370DB (Medium Purple) - Operation Purple
BG DARK:    #2d1f2d                 - Dark mode
BG LIGHT:   #FFF0F5                 - Light mode
```

---

**Document Created By:** CP2C2
**Status:** OFFICIAL STANDARD
**Enforcement:** ALL REPOSITORIES

💗 **PINK IS THE NEW BLUE** 💗
