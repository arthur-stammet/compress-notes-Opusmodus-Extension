# Compress Notes Extension

Author: **Arthur Stammet**  
Created: November 2025  
Location: `~/Opusmodus/User Source/Extensions/`

---

## 📖 Overview
The **Compress Notes Extension** performs run‑length encoding on a list of notes.  
It reduces consecutive identical notes into two parallel lists:

- **Notes list** → the sequence of changing pitches  
- **Lengths list** → the number of consecutive repetitions  

Depending on the `mode` keyword, you can extract only notes, only lengths, or normalized lengths.

---

## ⚙️ Function

```lisp
(compress-notes notes &key mode)
```

# Modes
- 'notes → return only the pitch list
- 'lengths → return only the repetition counts
- 'vector-lengths → return repetition counts normalized to floats in [0,1]

## 🧪 Usage Examples

```lisp
(setq my-notes '(a3 a3 a3 c4 b2 b2 eb3 eb3 eb3 eb3 g5))

;; Notes only
(compress-notes my-notes :mode 'notes)
;; → (a3 c4 b2 eb3 g5)

;; Lengths only
(compress-notes my-notes :mode 'lengths)
;; → (3 1 2 4 1)

;; Normalized vector lengths
(compress-notes my-notes :mode 'vector-lengths)
;; → (0.75 0.25 0.5 1.0 0.25)
```

## 📂 Installation
Place the file compress-notes.opmo in:

```Code
~/Opusmodus/User Source/Extensions/
```

Restart Opusmodus, and the function will be globally available.

## ✅ Summary
- Compresses note sequences into pitch list and length list
- Provides three modes: 'notes, 'lengths, 'vector-lengths
- Useful for algorithmic composition, pattern analysis, and data normalization workflows
