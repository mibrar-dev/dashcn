# Captures: Overflow Marquee Component

Visual test artifacts captured using `agent-browser` (session `w-marquee`, port `8873`) against the release Flutter Web build of docs (`http://localhost:8873/#/docs/components/overflow_marquee`).

## Visual Test Artifacts

### Responsive & Theme Viewports
1. **`overflow_marquee_1280x800_light.png`**
   - **Viewport:** 1280x800, Light theme.
   - **Contents:** Full desktop docs layout showing the title header, badges, and the default demo preview card. The continuous horizontal ticker is rendering non-empty text (`dashcn continuous marquee components now live across all platforms! • Seamless looping with soft edge fades • Fully keyboard accessible`) with smooth edge fade masking.
   - **Quality:** Text is 100% visible, sharp, no clipping or CanvasKit mask bugs.

2. **`overflow_marquee_1280x800_dark.png`**
   - **Viewport:** 1280x800, Dark theme.
   - **Contents:** Full desktop docs layout in dark theme. Text contrast >= 4.5:1 against card surface. Edge fade masking transitions seamlessly into dark card background.
   - **Quality:** Clean, legible, smooth motion loop.

3. **`overflow_marquee_375x812_light.png`**
   - **Viewport:** 375x812 (mobile phone width), Light theme.
   - **Contents:** Mobile navigation header, wrapped title actions, and responsive preview card.
   - **Quality:** Zero RenderFlex overflows. Viewport bounds respected.

4. **`overflow_marquee_375x812_dark.png`**
   - **Viewport:** 375x812 (mobile phone width), Dark theme.
   - **Contents:** Mobile view in dark mode.
   - **Quality:** Zero RenderFlex overflows. Text and icons legible.

---

### Named Docs Examples
5. **`example_default.png`**
   - **Example:** `Default`
   - **Contents:** Main continuous marquee with Lucide bell icon and long news headline looping seamlessly with soft edge fades.

6. **`example_now_playing.png`**
   - **Example:** `Now playing`
   - **Contents:** Music player row featuring a music icon container, a controlled continuous `OverflowMarquee` scrolling track title ("Midnight City — M83 (Extended Club Mix, 2024 Remaster)"), dynamic "Playing · Synthwave" / "Paused" status text, and an interactive ghost icon button wired to `MarqueeController.toggle()`.

7. **`example_news_ticker.png`**
   - **Example:** `News ticker`
   - **Contents:** Destructive `Badge` labeled `LIVE` followed by a fast continuous marquee (`speed: 55.0, gap: 32.0`) scrolling release announcements.

8. **`example_vertical.png`**
   - **Example:** `Vertical`
   - **Contents:** Vertical credit roll marquee with `direction: AxisDirectional.up`, `speed: 25.0`, `gap: 16.0`, cycling movie-style credits continuously.

9. **`example_rtl_reverse.png`**
   - **Example:** `RTL reverse`
   - **Contents:** Right-to-left layout with Arabic badge `عاجل` and Arabic marquee text scrolling in native reading direction (`direction: AxisDirectional.start`, RTL aware coordinate positioning).

10. **`example_customized.png`**
    - **Example:** `Customized`
    - **Contents:** Custom styled marquee with `speed: 75.0`, `gap: 40.0`, `fadePortion: 0.15`, pinned `leading` badge (`FAST`), and pinned `trailing` icon (`LucideIcons.zap`).

---

### Interaction Video
11. **`interaction.webm`**
    - **Contents:** Short screen recording showing the component in motion:
      1. Initial continuous autonomous looping of the marquee text.
      2. Pointer hover triggering pause on hover (`pauseOnHover: true`).
      3. Pointer unhover triggering seamless resumption of scrolling.
      4. Smooth frame rate and edge fades throughout.
    - **Quality:** High-fidelity video confirming real-time interactivity.

---

### Assessment
- All examples render non-empty, visible, sharp content.
- The previous CanvasKit Web shader masking bug (which previously caused text to be completely invisible due to origin clipping in custom `ShaderMaskLayer`) has been 100% resolved by standard `ShaderMask`.
- Looping arithmetic is continuous with modulo wrap-around without jumps or blank pauses.
- Hover and focus pause behavior functions as designed.
- No visual or layout defects detected.
