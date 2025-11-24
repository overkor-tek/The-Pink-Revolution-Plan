# Getting Started Examples

**Beginner-friendly examples for your first Pink Revolution contributions**

---

## 📁 Examples in This Directory

### 1. First Contribution
- **Level:** ⭐ Beginner
- **Time:** 5-10 minutes
- **Files:** Simple typo fix, documentation improvement

### 2. Simple Transformation
- **Level:** ⭐⭐ Beginner
- **Time:** 15-30 minutes
- **Files:** Single CSS file, simple color changes

### 3. README Update
- **Level:** ⭐ Beginner
- **Time:** 10-15 minutes
- **Files:** Adding badges, fixing links

---

## 🎯 Learning Objectives

By completing these examples, you will:
- Understand basic Git workflow
- Make your first pull request
- Transform your first blue color to pink
- Experience the Pink Revolution firsthand

---

## 📝 Example 1: Fix a Typo

**Scenario:** Found a typo in documentation

**Steps:**
```bash
# 1. Fork and clone repository
git clone https://github.com/YOUR_USERNAME/The-Pink-Revolution-Plan
cd The-Pink-Revolution-Plan

# 2. Create branch
git checkout -b fix-typo-readme

# 3. Fix typo in README.md
# Change: "revolutoin" → "revolution"

# 4. Commit
git add README.md
git commit -m "📝 Fix typo in README.md"

# 5. Push and create PR
git push origin fix-typo-readme
```

**Expected Result:** PR merged, you're officially a contributor! 🎉

---

## 🎨 Example 2: Simple Color Transformation

**Scenario:** Transform a single CSS file

**File:** `button.css`
```css
/* BEFORE - Blue buttons */
.btn-primary {
  background-color: #007bff;
  border-color: #007bff;
}

.btn-primary:hover {
  background-color: #0056b3;
  border-color: #0056b3;
}
```

**Transformation:**
```css
/* AFTER - Pink buttons */
.btn-primary {
  background-color: #FF69B4;  /* Hot Pink */
  border-color: #FF69B4;
}

.btn-primary:hover {
  background-color: #FF1493;  /* Deep Pink */
  border-color: #FF1493;
}
```

**Steps:**
```bash
# 1. Create transformation branch
git checkout -b pink-buttons

# 2. Make changes to button.css

# 3. Test locally (open in browser)

# 4. Commit with descriptive message
git add button.css
git commit -m "🌸 Transform button colors from blue to pink"

# 5. Push and create PR
git push origin pink-buttons
```

**Expected Result:** Pink buttons looking beautiful! 💖

---

## 📄 Example 3: Update README with Pink Badge

**Scenario:** Add Pink Revolution badge to README

**Steps:**
```bash
# 1. Create branch
git checkout -b add-pink-badge

# 2. Generate badge using tool
python tools/badge_generator.py --status in-progress

# 3. Add badge to README.md at top
```

**Badge Code:**
```markdown
![Pink Revolution](https://img.shields.io/badge/Pink_Revolution-In_Progress-FF69B4?style=for-the-badge&logo=github)
```

**Commit:**
```bash
git add README.md
git commit -m "✨ Add Pink Revolution badge to README"
git push origin add-pink-badge
```

**Expected Result:** Proud Pink Revolution badge displayed! 🏅

---

## 🎓 Next Steps

Completed all getting-started examples?

**Level Up:** Move to [intermediate examples](../intermediate/)

**Need Help:**
- Check [LEARNING_PATH.md](../../docs/LEARNING_PATH.md)
- Ask in GitHub Discussions
- Open an issue with `question` label

---

**💖 Every contribution counts. Every pink pixel matters. 💖**
