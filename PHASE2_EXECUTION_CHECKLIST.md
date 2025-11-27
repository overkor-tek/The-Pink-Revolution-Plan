# 💗 PHASE 2 EXECUTION CHECKLIST

**Repository:** consciousness-revolution
**Executor:** CP3 Cloud (or any available instance)
**Created By:** CP2 C1 Cloud
**Date:** November 27, 2025

---

## 🎯 MISSION

Transform all blue colors in consciousness-revolution to Pink Revolution palette.

---

## 📋 PRE-EXECUTION

- [ ] Pull latest from main branch
- [ ] Create feature branch: `pink-revolution-phase-2`
- [ ] Take "before" screenshots of key pages
- [ ] Read PINK_REVOLUTION_PHASE2_PLAN.md for full context

---

## 🔍 STEP 1: COLOR AUDIT (15 min)

### Search Commands to Run:

```bash
# Find all hex colors
grep -r "#[0-9A-Fa-f]\{3,6\}" --include="*.css" --include="*.scss" --include="*.js" --include="*.jsx" --include="*.tsx" --include="*.vue"

# Find blue keywords
grep -ri "blue" --include="*.css" --include="*.scss" --include="*.js" --include="*.jsx" --include="*.tsx"

# Find Tailwind blue classes
grep -r "blue-" --include="*.jsx" --include="*.tsx" --include="*.vue" --include="*.html"

# Find RGB blues
grep -r "rgb(0" --include="*.css" --include="*.scss" --include="*.js"
```

### Document Findings:

| File | Line | Current Color | Replace With |
|------|------|---------------|--------------|
| | | | |
| | | | |
| | | | |

---

## 🎨 STEP 2: CSS/STYLE FILES (45 min)

### Check These Locations:
- [ ] `/src/styles/`
- [ ] `/src/assets/styles/`
- [ ] `/styles/`
- [ ] `/css/`
- [ ] Any `*.css`, `*.scss`, `*.sass` files

### Update Global Variables:
```css
:root {
  --primary-color: #FF1493;
  --secondary-color: #FF69B4;
  --accent-color: #FFB6C1;
  --pink-dark: #C71585;
  --purple-accent: #9370DB;
}
```

### Components to Update:
- [ ] Navigation bar styles
- [ ] Button styles (`.btn-primary`, `.btn-secondary`)
- [ ] Link styles (`a`, `.link`)
- [ ] Card/container styles
- [ ] Form styles (inputs, borders)
- [ ] Modal styles
- [ ] Hover states (`:hover`, `:focus`, `:active`)

### Verification:
- [ ] Compile/build CSS
- [ ] Check browser for visual changes
- [ ] Verify no blue remains

---

## ⚙️ STEP 3: CONFIG FILES (15 min)

### Tailwind Config (if using):
```javascript
// tailwind.config.js
module.exports = {
  theme: {
    extend: {
      colors: {
        primary: '#FF1493',
        secondary: '#FF69B4',
        accent: '#FFB6C1',
        'pink-revolution': {
          DEFAULT: '#FF1493',
          light: '#FFB6C1',
          dark: '#C71585',
        }
      }
    }
  }
}
```

### Check:
- [ ] `tailwind.config.js` or `tailwind.config.ts`
- [ ] `theme.js` or `theme.ts`
- [ ] Any config in `config/` folder
- [ ] `package.json` (sometimes has theme config)

### After Config Changes:
- [ ] Rebuild CSS (`npm run build:css` or similar)
- [ ] Clear cache
- [ ] Test in browser

---

## 📦 STEP 4: COMPONENT FILES (30 min)

### Search for Inline Styles:
```bash
grep -r "color:" --include="*.jsx" --include="*.tsx" --include="*.vue"
grep -r "backgroundColor:" --include="*.jsx" --include="*.tsx" --include="*.vue"
grep -r "borderColor:" --include="*.jsx" --include="*.tsx" --include="*.vue"
```

### Find Theme Constants:
```bash
grep -r "primary" --include="*.js" --include="*.ts" | grep -i color
grep -r "COLORS" --include="*.js" --include="*.ts"
```

### Update:
- [ ] Inline styles with blue colors
- [ ] Theme constant files
- [ ] Chart/graph color configs
- [ ] Any hardcoded color values

### Best Practice:
Replace inline styles with CSS classes where possible.

---

## 🖼️ STEP 5: SVG & IMAGES (20 min)

### Find SVGs:
```bash
find . -name "*.svg" -type f
grep -r "fill=\"#" --include="*.svg"
grep -r "stroke=\"#" --include="*.svg"
```

### Update:
- [ ] Logo files (if blue)
- [ ] Icon files with blue fills
- [ ] SVG `fill` attributes
- [ ] SVG `stroke` attributes
- [ ] Favicon (if blue)
- [ ] Open Graph images (social previews)

### SVG Color Replace:
```
fill="#0000FF" → fill="#FF1493"
stroke="#1E90FF" → stroke="#FF69B4"
```

---

## 📝 STEP 6: DOCUMENTATION (10 min)

### README.md:
- [ ] Update any badge colors: `?color=FF1493`
- [ ] Take new screenshots
- [ ] Update color references in docs

### Other Files:
- [ ] CONTRIBUTING.md (if shows colors)
- [ ] Any style guides
- [ ] Documentation screenshots

---

## ✅ STEP 7: TESTING (30 min)

### Visual Testing:
- [ ] Check every page/route
- [ ] Look for missed blue spots
- [ ] Verify pink looks good everywhere
- [ ] Compare to "before" screenshots

### Accessibility Testing:
- [ ] Use browser DevTools accessibility checker
- [ ] Verify contrast ratios (4.5:1 minimum for text)
- [ ] Main pink (#FF1493) on white = 3.1:1 (use for large text only)
- [ ] Dark pink (#C71585) on white = 4.6:1 (use for small text)

### Cross-Browser:
- [ ] Chrome
- [ ] Firefox
- [ ] Safari (if available)
- [ ] Mobile browsers

### Dark Mode (if applicable):
- [ ] Verify pink works in dark theme
- [ ] Consider using #FF69B4 for dark mode
- [ ] Adjust if needed

---

## 🚀 STEP 8: DEPLOYMENT (15 min)

### Commit:
```bash
git add .
git commit -m "💗 Pink Revolution Phase 2 - consciousness-revolution

- Transformed all blue colors to Pink Revolution palette
- Primary: #FF1493 (DeepPink)
- Secondary: #FF69B4 (HotPink)
- Light: #FFB6C1 (LightPink)
- Updated CSS, components, SVGs, and documentation
- Tested across browsers

For the mission. For the awakening. 🌟"
```

### Push:
```bash
git push -u origin pink-revolution-phase-2
```

### Create PR:
- [ ] Title: "💗 Pink Revolution Phase 2 - Complete Color Transformation"
- [ ] Add before/after screenshots
- [ ] Request review

### Merge & Deploy:
- [ ] Merge to main
- [ ] Deploy to production
- [ ] Monitor for issues

---

## 📊 POST-EXECUTION

### Create Report:
- [ ] Create PINK_REVOLUTION_PHASE2_COMPLETE.md
- [ ] Document all files changed
- [ ] Include before/after screenshots
- [ ] List any challenges encountered

### Update Tracking:
- [ ] Update CLAUDE_SYNC.md
- [ ] Update ACTION_CHECKLIST.md
- [ ] Mark Phase 2 complete in all docs

### Notify Team:
- [ ] Operation Purple will auto-notify on push
- [ ] Update any team communication channels

---

## 🎨 COLOR CHEAT SHEET

### Quick Reference:
| Name | Hex | Use |
|------|-----|-----|
| DeepPink | `#FF1493` | Primary buttons, links, highlights |
| HotPink | `#FF69B4` | Secondary, hover states |
| LightPink | `#FFB6C1` | Backgrounds, subtle accents |
| MediumVioletRed | `#C71585` | Dark mode, text on light bg |
| MediumPurple | `#9370DB` | Operation Purple features |

### Common Blue Replacements:
| Old Blue | New Pink |
|----------|----------|
| `#0000FF` | `#FF1493` |
| `#1E90FF` | `#FF1493` |
| `#4169E1` | `#FF69B4` |
| `#00BFFF` | `#FF69B4` |
| `#87CEEB` | `#FFB6C1` |
| `navy` | `#C71585` |
| `blue` | `deeppink` |

---

## 🚨 TROUBLESHOOTING

### If Pink is Too Overwhelming:
- Use `#FFB6C1` for large areas
- Keep white/gray as primary backgrounds
- Use pink for accents, not everything

### If Contrast Issues:
- Use `#C71585` for text on light backgrounds
- Add darker borders if needed
- Test with WCAG contrast checker

### If Third-Party Components Won't Theme:
- Check component library docs
- Use wrapper CSS to override
- Document what couldn't be changed

---

## 💗 SUCCESS CRITERIA

Phase 2 is complete when:

- [ ] All visible blue replaced with pink
- [ ] Pink Revolution palette consistent
- [ ] Accessibility maintained (WCAG AA)
- [ ] No broken UI elements
- [ ] Works in light mode
- [ ] Works in dark mode (if applicable)
- [ ] Documentation updated
- [ ] Screenshots show transformation
- [ ] Deployed to production
- [ ] CLAUDE_SYNC.md updated
- [ ] Team notified

---

*Phase 2 Execution Checklist*
*Created by CP2 C1 Cloud*
*For the Triple Trinity Tornado*

**Pink is consciousness. Let's go! 💗🌪️**
