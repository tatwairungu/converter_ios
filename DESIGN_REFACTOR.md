# 🇰🇪 Kenya Converter App — Design Refactor

**Goal:** Redesign the app to a **modern, minimal**, above-the-fold layout (no scrolling to see results), while **keeping Kenyan colors** (green, red, black, white) used more sparingly and systematically.

**Scope:** Applies to **Weight, Length, Temperature, Currency** tabs and shared components.  
**Status:** Builds on your Phase 1 & 2 foundation; drives Phase 3 (“Enhanced UX”) to completion.

---

## 0) Design Principles

- **No-scroll core flow:** Input → Units → Result are all visible without scrolling on 6.1″ iPhones (393×852 pt).  
- **Kenyan identity, calm UI:** Green = primary action/tint. Red = warnings/emphasis only. Black = text/icon strokes. White/neutral surfaces dominate.  
- **Clarity first:** One primary action per view. Large result, small help text.  
- **Consistency:** Same patterns across all converters (component library).  
- **Accessible:** WCAG AA contrast, Dynamic Type, VoiceOver, 44×44 pt touch targets.

---

## 1) Token System (map to your `KenyanTheme`)

> Keep your struct and property names; update values/usage.

### 1.1 Colors (hex suggestions)
- `Colors.primary` (Kenyan green, tint/action): **#0B6E4F**  
- `Colors.secondary` (Kenyan red, warnings/emphasis): **#C1121F**  
- `Colors.text` (neutral near-black): **#111827**  
- `Colors.background`: **#FFFFFF**  
- Neutrals (add internally if needed):  
  - surface: **#F7F7F7**  
  - border: **#E5E7EB**  
  - mutedText: **#6B7280**

**Do / Don’t**
- ✅ Use **green** for focus, selection, active states, icons, and the swap control.  
- ✅ Use **red** only for errors, out-of-range values, and destructive states.  
- ❌ Don’t outline every control in green; prefer neutral fills with green focus/active.

### 1.2 Typography (use your `Typography`)
- `largeTitle` → **Result number** & screen title when needed.  
- `title` → Section titles (“From”, “To”, “Value”).  
- `headline` → Field labels, capsule chips.  
- `body` → Input text, picker rows.  
- `caption` → Helper lines (“0°C = 32°F • 100°C = 212°F”), error messages.

### 1.3 Spacing & Radii
- Base grid = **8 pt**.  
- Vertical rhythm: `md` (16) between related items; `lg` (24) between sections.  
- Corner radii: **12 pt** for cards/fields; **20–24 pt** for circular buttons (swap).

### 1.4 Contrast Targets
- Text on background ≥ **4.5:1** (body).  
- Large result (≥ 24 pt) ≥ **3:1**.  
- Disabled/placeholder ≥ **3:1** where possible.

---

## 2) Above-the-Fold Layout (all tabs)

**Canvas assumptions:** 393×852 pt (6.1″). Content max-width 344–360 pt.

**Stack order (top → bottom):**
1) **Header**: icon + screen title (optional subtitle).  
2) **Value input** (numeric keypad).  
3) **Units row**: **From** and **To** pickers side-by-side.  
4) **Swap button**: centered, circular, subtle elevation.  
5) **Result card**: large number, unit; **always visible**.  
6) **Reference strip** (tiny helper line).  
7) **Tab bar**.

**Target heights:**  
- Header 64–72, Input 56, Pickers row 56, Swap 36–40, Result 112–128, Reference 20, vertical paddings 16–24 → **fits without scroll**.

**Small screens (SE):** Compress header to 56, result to 96, reduce paddings by 2–4 pt. Result must still be visible when the keyboard is up.

---

## 3) Component Specs (shared across all converters)

### 3.1 Header
- Thermometer/scale/length/money icon (SF Symbols outline), tinted `primary`.  
- Title in `title` semibold; optional muted subtitle in `caption`.

### 3.2 Value Input
- Single text field labeled **“Value”**; right-aligned numeric text.  
- Unit hint chip (e.g., “°C”) reflecting **From** unit.  
- States: default, focus (underline/tint = `primary`), error (`secondary` underline + caption).  
- Keyboard: **decimal pad** with **Done** accessory.

### 3.3 Unit Pickers (side-by-side)
- Label above each: **From**, **To**.  
- Neutral **filled** controls with thin border; selected state highlights title text and chevron in `primary`.  
- Options vary per tab (see section 4).

### 3.4 Swap Control
- Circular 36–40 pt, subtle shadow (elevation 1).  
- Bidirectional arrows icon; short **180° rotate** on tap (150–200 ms).  
- Haptic: light impact.

### 3.5 Result Card
- Elevated neutral card (surface fill, thin border).  
- **Primary line:** large result value (semibold) + unit in smaller weight.  
- **Secondary line:** formula or context (caption).  
- Empty/invalid: show “—” in muted and guidance caption.

### 3.6 Reference Strip
- One-line microcopy for canonical checks (caption, muted).  
- Examples per tab:  
  - Temperature: `0°C = 32°F • 100°C = 212°F`  
  - Length: `1 m = 3.28084 ft`  
  - Weight: `1 kg = 2.20462 lb`  
  - Currency: `Rates update every 4h`

### 3.7 Tab Bar
- Icons + labels; tint = `primary`; keep monochrome line icons.

---

## 4) Tab-Specific Rules

### 4.1 Temperature
- Units: **Celsius (°C)**, **Fahrenheit (°F)**, **Kelvin (K)**.  
- Validation: **K ≥ 0**; highlight violations in `secondary` with message: “Kelvin cannot be negative.”  
- Reference strip: as above.  
- Optional: **emoji context** retained but toned down (display near reference strip, not in header).

### 4.2 Length
- Units: m, cm, km, in, ft, mi (prioritize commonly paired ones in the picker).  
- Reference: `1 m = 3.28084 ft • 1 km = 0.621371 mi`.

### 4.3 Weight
- Units: kg, g, lb, oz.  
- Presets (chips under input): **1**, **10**, **100**, **1000** for quick taps (optional if space allows).

### 4.4 Currency
- Base: **KES**. Target: USD, EUR, GBP, JPY, CAD, AUD (as you have).  
- Micro-states: **Loading**, **Stale**, **Offline** (see section 5).  
- Reference: “Rates cached every 4h • Last updated: HH:mm”.  
- Manual refresh: small circular button near result card header (uses `primary`).

---

## 5) States, Motion, and Feedback

### 5.1 Live Conversion
- Update result as the user types; no convert button required.  
- On keyboard show, **nudge** the result card up ~8 pt (spring 0.8) to reinforce visibility (do not scroll the whole view).

### 5.2 Errors & Edge Cases
- Empty value: result “—”, caption “Enter a number to convert.”  
- Non-numeric: red underline + caption “Enter a valid number (e.g., 36.6).”  
- Out-of-range rules per tab (e.g., Kelvin).

### 5.3 Haptics
- Swap: light impact.  
- Error: notification warning.

### 5.4 Currency Data States
- **Loading:** skeleton pulse for result card (1.2s).  
- **Fresh:** normal UI.  
- **Stale (>4h):** muted badge “Stale • Tap refresh”.  
- **Offline:** banner “Offline • Showing cached rates” + time since last update.

---

## 6) Accessibility

- **Dynamic Type:** Support up to **XL**; result wraps unit to next line if needed.  
- **VoiceOver order:** Header → Value label → Value field → From label → From picker → Swap → To picker → Result value (announce with unit) → Reference → Tabs.  
- **Labels & Hints:** Each control announces unit and direction (e.g., “From unit, Celsius selected, adjustable”).  
- **Hit Targets:** ≥ 44×44 pt.  
- **Color alone:** Never the only cue; pair with icon/label or state text.

---

## 7) Dark Mode

- Background: **#0B0B0B**, Card: **#111111**, Border: **#2A2A2A**, Text: **#E5E7EB**, Muted: **#9CA3AF**.  
- Keep `primary` green for tints; verify contrast on dark.  
- Reduce shadows; rely on borders/separators for depth.

---

## 8) Microcopy (shared)

- Input label: **Value**  
- Section labels: **From**, **To**  
- Empty result: **—**  
- Error: **Enter a valid number** / **Kelvin cannot be negative**  
- Currency stale: **Stale • Tap refresh**  
- Offline: **Offline • Showing cached rates**

Tone: neutral, concise, helpful.

---

## 9) Design Delivery (Figma / handoff)

**Pages:** Tokens · Components · Screens (Light) · Screens (Dark) · Prototypes.  
**Components:** Header, ValueField, UnitPicker, SwapButton, ResultCard, ReferenceStrip, TabBar, Badge, Banner, Skeleton.  
**Variants:** default/focus/error · light/dark · loading/stale/offline (currency).  
**Prototypes:** swap rotation, input focus, skeleton loading.

---

## 10) Implementation Plan (no code here)

1) **Token pass**  
   - Update `KenyanTheme.Colors` values (keep property names).  
   - Set `accent = primary`; reserve `secondary` (red) for errors.

2) **Layout pass**  
   - Replace stacked unit pickers with **side-by-side** row.  
   - Insert **Result card** above the fold (directly under pickers/swap).  
   - Remove heavy green field outlines → neutral surfaces + `primary` focus.

3) **Behavior pass**  
   - Live conversion on change; graceful empty/invalid handling.  
   - Keyboard accessory with **Done**; keep result visible (no scroll).  
   - Haptics on swap; error haptics on invalid.

4) **Currency states**  
   - Visual “Loading/Stale/Offline” as specified; manual refresh affordance.

5) **Accessibility & Dark mode**  
   - Dynamic Type wrap rules; VoiceOver order/labels; dark colors.

6) **Polish**  
   - Motion durations 150–200 ms; subtle, consistent.  
   - QA checklist (below) on devices.

---

## 11) QA Checklist (acceptance criteria)

- [ ] **No scroll** needed to see the result on 6.1″ and 6.7″ iPhones (portrait).  
- [ ] Result remains **visible while typing** with keyboard open.  
- [ ] Contrast meets **WCAG AA** in light & dark.  
- [ ] Dynamic Type up to **XL** without clipping; result/unit wrap gracefully.  
- [ ] VoiceOver announces labels, units, and result correctly; logical order.  
- [ ] Touch targets (pickers, swap, refresh) ≥ 44×44 pt.  
- [ ] Haptics: swap (light), error (warning).  
- [ ] Currency: clear Loading/Stale/Offline visuals; last updated time shown.  
- [ ] Performance: 60 fps animations; no jank on tab switches.  
- [ ] Localization readiness: strings externalized; number formatting respects locale.

---

## 12) Alignment with Your Development Plan

- **Phase 3: Design Consistency & UX** → This refactor fulfills:  
  - Unified patterns, smooth micro-animations, loading states, input validation, haptics, clear buttons, copy result (affordance in Result card).  
- **Phase 4: Persistence & Sharing** → Placeholders in Result card actions (copy/share/favorite).  
- **Phase 5: Marketing/ASO** → Cleaner screenshots, consistent visual language.

---

## 13) User Stories (for tracking)

- As a user, I can **see the converted result without scrolling**, even with the keyboard open.  
- As a user, I get **instant conversion** feedback as I type.  
- As a user, I can **swap units** with a single tap and feel a light haptic.  
- As a user, I understand **when currency data is stale or offline**.  
- As a user with low vision, I can **increase text size** and still use the app comfortably.

---

## 14) Risks & Mitigations

- **Small devices:** Crowd risk → compress paddings, allow result unit to wrap, hide optional presets.  
- **Color misuse:** Over-using red/green → lock usage in tokens & review PRs against “Do/Don’t”.  
- **Keyboard overlap:** Ensure content shift (not scroll) on keyboard show; test with long decimals.

---

## 15) Rollout Checklist (Cursor tasks)

- [ ] Update `KenyanTheme` values (no API or model changes).  
- [ ] Refactor converter screens to shared **Above-the-Fold** template.  
- [ ] Implement focus/invalid states; add **Done** toolbar to numeric keyboard.  
- [ ] Add haptics and swap rotation.  
- [ ] Currency visual states + refresh affordance.  
- [ ] Dark mode styles.  
- [ ] Accessibility (Dynamic Type, VoiceOver, hit areas).  
- [ ] Device QA (6.1″, 6.7″, SE).  
- [ ] Final visual polish & copy pass.

---

## 16) Success Metrics

- **0 required scrolls** in main conversion flow.  
- **Time to first clear result < 3s** from launch.  
- **Crash-free sessions:** ≥ 99.9%.  
- **Usability feedback:** Tap targets, readability, and clarity rated “Good” or better in informal tests.

---

**Owner:** Design & Frontend  
**Version:** 1.0 (Aug 2025)  
**Next:** Execute token/layout pass → behavior → currency states → accessibility → QA.
