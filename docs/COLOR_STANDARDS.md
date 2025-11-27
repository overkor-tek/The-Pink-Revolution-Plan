# Pink Revolution Color Standards

**Organization:** overkor-tek
**Version:** 1.0
**Last Updated:** November 27, 2025

---

## Official Color Palette

### Primary Colors

| Name | Hex | RGB | CSS Variable | Usage |
|------|-----|-----|--------------|-------|
| **DeepPink** | `#FF1493` | `rgb(255, 20, 147)` | `--pink-primary` | Main actions, buttons, links |
| **HotPink** | `#FF69B4` | `rgb(255, 105, 180)` | `--pink-secondary` | Secondary elements, hover states |
| **LightPink** | `#FFB6C1` | `rgb(255, 182, 193)` | `--pink-light` | Backgrounds, cards |
| **MediumVioletRed** | `#C71585` | `rgb(199, 21, 133)` | `--pink-dark` | Dark mode, text emphasis |
| **MediumPurple** | `#9370DB` | `rgb(147, 112, 219)` | `--purple-accent` | Operation Purple, accents |

---

## CSS Implementation

### CSS Variables (Root)

```css
:root {
  /* Pink Revolution Primary Palette */
  --pink-primary: #FF1493;
  --pink-secondary: #FF69B4;
  --pink-light: #FFB6C1;
  --pink-dark: #C71585;
  --purple-accent: #9370DB;

  /* Semantic Aliases */
  --color-primary: var(--pink-primary);
  --color-secondary: var(--pink-secondary);
  --color-accent: var(--purple-accent);
  --color-background: var(--pink-light);
  --color-text-emphasis: var(--pink-dark);
}
```

### Dark Mode

```css
[data-theme="dark"], .dark-mode {
  --pink-primary: #FF1493;
  --pink-secondary: #FF69B4;
  --pink-light: #2D1F2D;      /* Darkened pink tone */
  --pink-dark: #FFB6C1;        /* Inverted for readability */
  --purple-accent: #B19CD9;    /* Lightened purple */
}
```

---

## Tailwind CSS Classes

### Color Mapping

| Blue (Replace) | Pink (Use Instead) |
|----------------|-------------------|
| `text-blue-500` | `text-pink-500` |
| `text-blue-600` | `text-pink-600` |
| `bg-blue-500` | `bg-pink-500` |
| `bg-blue-100` | `bg-pink-100` |
| `border-blue-500` | `border-pink-500` |
| `ring-blue-500` | `ring-pink-500` |
| `hover:bg-blue-600` | `hover:bg-pink-600` |

### Custom Tailwind Config

```javascript
// tailwind.config.js
module.exports = {
  theme: {
    extend: {
      colors: {
        'revolution': {
          'primary': '#FF1493',
          'secondary': '#FF69B4',
          'light': '#FFB6C1',
          'dark': '#C71585',
          'purple': '#9370DB',
        }
      }
    }
  }
}
```

---

## Find & Replace Guide

### CSS/SCSS Files

| Find | Replace |
|------|---------|
| `#0000FF` | `#FF1493` |
| `#1E90FF` | `#FF69B4` |
| `#87CEEB` | `#FFB6C1` |
| `#00008B` | `#C71585` |
| `blue` | `deeppink` |
| `dodgerblue` | `hotpink` |
| `skyblue` | `lightpink` |
| `darkblue` | `mediumvioletred` |

### JavaScript/TypeScript

```javascript
// Before
const primaryColor = '#0000FF';
const theme = { primary: 'blue' };

// After
const primaryColor = '#FF1493';
const theme = { primary: 'deeppink' };
```

---

## Component Examples

### Buttons

```css
.btn-primary {
  background-color: #FF1493;
  color: white;
  border: none;
}

.btn-primary:hover {
  background-color: #C71585;
}

.btn-secondary {
  background-color: transparent;
  color: #FF1493;
  border: 2px solid #FF1493;
}

.btn-secondary:hover {
  background-color: #FFB6C1;
}
```

### Links

```css
a {
  color: #FF1493;
  text-decoration: none;
}

a:hover {
  color: #C71585;
  text-decoration: underline;
}
```

### Alerts/Notifications

```css
.alert-info {
  background-color: #FFB6C1;
  border-left: 4px solid #FF1493;
  color: #C71585;
}

.alert-purple {
  background-color: #E6E0F8;
  border-left: 4px solid #9370DB;
  color: #6B5B95;
}
```

---

## Accessibility

### Contrast Ratios

| Combination | Ratio | WCAG Level |
|-------------|-------|------------|
| DeepPink on White | 3.5:1 | AA Large |
| MediumVioletRed on White | 5.2:1 | AA |
| White on DeepPink | 3.5:1 | AA Large |
| White on MediumVioletRed | 5.2:1 | AA |

### Recommendations

- Use `#C71585` (MediumVioletRed) for body text on light backgrounds
- Use `#FF1493` (DeepPink) for large text, buttons, and decorative elements
- Always ensure sufficient contrast in dark mode

---

## Repository Status

| Repository | Color Status | Phase |
|------------|--------------|-------|
| philosopher-ai-backend | PINK | Phase 1 Complete |
| consciousness-revolution | Blue | Phase 2 Pending |
| 100x-platform | Unknown | Phase 3 Pending |
| consciousness-bugs | N/A | Documentation Only |

---

## Quick Reference Card

```
PINK REVOLUTION COLORS
======================
Primary:   #FF1493  DeepPink
Secondary: #FF69B4  HotPink
Light:     #FFB6C1  LightPink
Dark:      #C71585  MediumVioletRed
Accent:    #9370DB  MediumPurple
```

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | Nov 27, 2025 | Initial color standards |

---

**Part of the Pink Revolution**

*For the mission. For the awakening.* 💗
