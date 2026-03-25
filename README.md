# heavy-handed

This is a 42-key split keyboard layout for the Piantor Pro with Nocturnal Silent Linear 20g switches.
The switches activate if you breathe on them. The name is aspirational.

![Piantor Pro split keyboard with touchpad centered between halves](piantor-setup.jpg)

The full story is at [Twelve Keyboards Later](https://jorypestorious.com/blog/endgame-keyboard/).

---

## Files

| File | What it is | When to use it |
|------|-----------|----------------|
| `piantor-pro-heavy-handed.vil` | Layout for the stock Vial firmware (UID `16002279599986889074`) | Load in Vial if running the original firmware that shipped with the keyboard |
| `piantor-pro-heavy-handed-v2.vil` | Layout for the custom firmware (UID `12093350594035645365`) | Load in Vial after flashing the custom `.uf2` |
| `beekeeb_piantor_pro_vial.uf2` | Custom firmware binary for the RP2040 | Flash once onto the keyboard to replace stock firmware |
| `skhd/` | yabai + skhd hotkey daemon config | macOS window management bindings |
| `tmux/` | tmux terminal multiplexer config | Terminal session bindings |

## Firmware

### Why two versions exist

Each firmware has a unique UID baked into it. Vial matches `.vil` layout files to firmware by UID,
so the original `.vil` will not load on the custom firmware and vice versa. Both versions carry the
same keymap. The difference is the firmware underneath.

### Original: stock Vial firmware

The stock firmware ships with beekeeb's Piantor Pro. Download [Vial](https://get.vial.today/),
open `piantor-pro-heavy-handed.vil`, and the layout loads directly. No flashing required.

If you type fast enough to trigger accidental layer activations (holding Space for L2 while typing
"I" fires tmux split-vertical), the stock firmware may not have Flow Tap available depending on
when it was built. The custom firmware guarantees Flow Tap support.

### Custom: vial-qmk with Flow Tap

`piantor-pro-heavy-handed-v2.vil` requires the custom firmware (`beekeeb_piantor_pro_vial.uf2`).

**Why the custom firmware exists:**

- **Flow Tap.** Tapping term is a single threshold that applies to every tap-hold key in every
  situation. With 20g switches and fast typing, the overlap between "how long Space is held during
  normal typing" (100-150ms) and "how long Space needs to be held for intentional L2 activation"
  (150-200ms) is too tight. No single tapping term value works for both cases. Lower it and
  intentional holds trigger faster, but so do accidental holds during typing. Raise it and
  accidental holds decrease, but navigation feels sluggish.

  Flow Tap solves this by checking whether you pressed another key within 150ms before pressing
  the layer-tap key. If yes, you were typing, so the key always taps. If no, you paused before
  pressing it, so normal tap-hold behavior applies and the layer activates. Tapping term stays
  at 200ms for the hold case while the typing case is handled separately.

  The stock firmware may not include Flow Tap depending on the QMK version it was built from.

Both stock and custom firmware support QMK Settings (live tuning in Vial) and QK_BOOT (bootloader
entry without case disassembly). QK_BOOT is mapped to L5 top-left: hold Tab, tap the Ctrl position.

### How to flash the custom firmware

The `.uf2` file is the firmware binary. You flash it once. After that, use Vial to load `.vil`
layout files without reflashing.

1. Enter bootloader. If the keyboard already has QK_BOOT mapped (L5 top-left), hold Tab and tap
   the top-left key. Otherwise, install `picotool` (`brew install picotool`) or double-tap the
   reset button on the PCB if accessible.
2. The keyboard disconnects and mounts as a USB drive called `RPI-RP2`.
3. Copy `beekeeb_piantor_pro_vial.uf2` onto the `RPI-RP2` drive. It reboots automatically.
4. Open Vial and load `piantor-pro-heavy-handed-v2.vil`.
5. Go to the QMK Settings tab and confirm Flow Tap is set to 150.

### How to rebuild the firmware

The compiled `.uf2` is included in this repo, so rebuilding is optional. Only needed if you
modify the firmware source.

```bash
git clone https://github.com/vial-kb/vial-qmk.git ~/vial-qmk --depth=1
cd ~/vial-qmk
git submodule update --init --recursive
make beekeeb/piantor_pro:vial
```

Flow Tap is enabled automatically by Vial's QMK Settings feature (`QMK_SETTINGS = yes` in
`rules.mk`). No source changes needed beyond what is in `keymaps/vial/`.

**UID note:** The firmware UID lives in `keyboards/beekeeb/piantor_pro/keymaps/vial/config.h`
as `VIAL_KEYBOARD_UID`. If you regenerate the UID, the existing `.vil` files will not load.
Save a fresh `.vil` from Vial after loading your layout on the new firmware.

---

## QMK Settings

These settings are tuned for 20g switches where fingers rest with enough pressure to actuate.
All values are adjustable live in Vial's QMK Settings tab on the custom firmware.

| Setting | Value | Purpose |
|---------|-------|---------|
| Tapping Term | 200ms | How long a key must be held before it counts as a hold instead of a tap. 200ms is the QMK default and works well with Flow Tap handling the fast-typing edge case. |
| Flow Tap | 150ms | The core setting. If the previous keypress was within 150ms, layer-tap keys always tap. Raise to 170ms if you still get accidental layer activations. Lower to 130ms if intentional holds feel sluggish. |
| Quick Tap Term | 200ms | If the same key is tapped twice within this window, the second press always taps. Prevents accidental layer activation when double-tapping Space or Backspace. |
| Permissive Hold | OFF | When ON, pressing another key while holding a layer-tap key triggers the hold even before tapping term expires. With 20g switches, normal typing rolls over keys constantly, so this would cause false layer activations. |
| Hold On Other Key Press | OFF | Similar to Permissive Hold. Triggers hold on keypress instead of release. OFF for the same reason. |
| Retro Tapping | OFF | When ON, holding a layer-tap key past tapping term and releasing without pressing anything sends the tap. This adds input latency because QMK must wait the full tapping term before deciding. |
| Chordal Hold | OFF | Detects holds based on which hand pressed the next key. Breaks intentional same-hand layer use on this layout. |
| Tap Hold Caps Delay | 80ms | Delay before caps lock registers on tap-hold keys. Default value. |
| Tapping Toggle | 5 | Number of taps to permanently toggle a layer on or off. 5 is high enough to prevent accidental toggles. |
| Tap Code Delay | 0 | Delay between tap code keypresses. Not used in this layout. |

**When to adjust:** If holding Space occasionally types a space instead of activating L2 during
deliberate navigation, the 150ms Flow Tap window might be catching your intentional holds.
Lower Flow Tap to 130ms. If you still get accidental tmux splits during fast prose typing,
raise Flow Tap to 170ms.

---

## Philosophy

Every key serves one purpose. The layout has no redundant layers.

The six thumb keys handle five layers and the five most frequent non-alpha keys
(Backspace, Space, Tab, Escape, and mouse click). Modifiers stay on the outer pinky columns:
Ctrl (top left), Cmd (home left), Alt (top right), Shift-parens (bottom both).

The right outer thumb is Escape on tap, Hyper (all four modifiers) on hold.
Escape is the most common single-key action in vim and tmux.
Hyper gives skhd a dedicated modifier namespace for app launching, separate
from Alt (window management) and Ctrl (tmux).

**Ghost glyph protection:** the inner column keys (T/G/B and Y/H/N positions)
are blank on most layers. Insert used to live on the G position of L2, and it
fired constantly. Blanking the inner column on layers where it serves no purpose
fixed the problem. The inner column still carries content on some layers (L1 puts
brackets on Y and equals on H; L3 puts symbols across the right inner column)
where those keys are intentional targets.

**Why not home row mods?** At 20g actuation force, fingers rest on the keys with
enough pressure to register. Fast typing holds keys for 100-150ms during normal
rollover, which overlaps with the tapping term threshold. The firmware cannot
reliably distinguish "typing A quickly" from "starting to hold Cmd." Dedicated
modifier keys have no timing ambiguity. Ctrl is always Ctrl.

---

## Base Layer

```
+-----+-----+-----+-----+-----+-----+          +-----+-----+-----+-----+-----+-----+
|Ctrl |  Q  |  W  |  E  |  R  |  T  |          |  Y  |  U  |  I  |  O  |  P  | Alt |
+-----+-----+-----+-----+-----+-----+          +-----+-----+-----+-----+-----+-----+
| Cmd |  A  |  S  |  D  |  F  |  G  |          |  H  |  J  |  K  |  L  |  ;  |  '  |
+-----+-----+-----+-----+-----+-----+          +-----+-----+-----+-----+-----+-----+
|Sft/(|  Z  |  X  |  C  |  V  |  B  |          |  N  |  M  |  ,  |  .  |  /  |Sft/)|
+-----+-----+-----+-----+-----+-----+          +-----+-----+-----+-----+-----+-----+
                    +-----+-----+-----+    +-----+-----+-----+
                    | Tab |BkSp |Enter|    |Click|Space| Esc |
                    | L5  | L1  | L3  |    | L4  | L2  |Hyper|
                    +-----+-----+-----+    +-----+-----+-----+
```

**Left outer column** holds Ctrl (top), Cmd (home), and Shift/( (bottom).
Cmd on the left home pinky keeps one-handed Cmd+ZXCV comfortable.

**Right outer column** holds Alt (top), quote (home), and Shift/) (bottom).

**Left thumbs** are Tab/L5, Backspace/L1, and Enter/L3.
Tab sits on the outer thumb because it is used constantly. Del lives on L2.

**Right thumbs** are Click/L4, Space/L2, and Esc/Hyper.
The right inner thumb taps left-click and holds for the mouse layer.

---

## Layers

| Hold | Layer | Purpose |
|------|-------|---------|
| Backspace | L1 Num | Numbers, brackets |
| Space | L2 Nav | Arrows, editing, all tmux controls |
| Enter | L3 Sym | Shifted symbols, yabai window management |
| Right inner thumb | L4 Mouse | Mouse movement, scroll, buttons |
| Tab | L5 Fn | F-keys, media, brightness |

### L1 Num (hold Backspace)

The right hand holds a numpad with brackets. The left hand has format separators, bracket pairs,
and math operators for number-adjacent input without leaving the numpad.

```
+-----+-----+-----+-----+-----+-----+          +-----+-----+-----+-----+-----+-----+
|Ctrl |  {  |  (  |  )  |  }  |     |          |  [  |  7  |  8  |  9  |  ]  | Alt |
+-----+-----+-----+-----+-----+-----+          +-----+-----+-----+-----+-----+-----+
| Cmd |  $  |  .  |  ,  |  :  |     |          |  =  |  4  |  5  |  6  |  ;  |  '  |
+-----+-----+-----+-----+-----+-----+          +-----+-----+-----+-----+-----+-----+
|Sft/(|  /  |  *  |  +  |  %  |     |          |  \  |  1  |  2  |  3  |  `  |Sft/)|
+-----+-----+-----+-----+-----+-----+          +-----+-----+-----+-----+-----+-----+
                    +-----+-----+-----+    +-----+-----+-----+
                    |     |(hld)|     |    |  -  |  0  |  .  |
                    +-----+-----+-----+    +-----+-----+-----+
```

### L2 Nav + tmux (hold Space)

The left hand handles arrows and editing. The right hand controls all of tmux.

```
+-----+-----+-----+-----+-----+-----+          +-----+-----+-----+-----+-----+-----+
|Ctrl |Home |PgDn |PgUp | End |     |          |     |splth|spltv|zoom |copy | Alt |
+-----+-----+-----+-----+-----+-----+          +-----+-----+-----+-----+-----+-----+
| Cmd |Left |Down | Up  |Right|     |          |prevW|nextS|prevS|nextW|sesh |     |
+-----+-----+-----+-----+-----+-----+          +-----+-----+-----+-----+-----+-----+
|Sft/(|Cmd+Z|Cmd+X|Cmd+C|Cmd+V|CmdSZ|          |     | git | jump|newWn| yazi|     |
+-----+-----+-----+-----+-----+-----+          +-----+-----+-----+-----+-----+-----+
                    +-----+-----+-----+    +-----+-----+-----+
                    | Del |BkSp |Enter|    |     |(hld)|     |
                    +-----+-----+-----+    +-----+-----+-----+
```

### L3 Sym + yabai (hold Enter)

The right hand holds shifted symbols. The left hand controls yabai window management.

```
+-----+-----+-----+-----+-----+-----+          +-----+-----+-----+-----+-----+-----+
|Ctrl |rsz← |rsz↓ |rsz↑ |rsz→ |     |          |  {  |  &  |  *  |  (  |  }  | Alt |
+-----+-----+-----+-----+-----+-----+          +-----+-----+-----+-----+-----+-----+
| Cmd |fcs← |fcs↓ |fcs↑ |fcs→ |     |          |  +  |  $  |  %  |  ^  |  :  |  "  |
+-----+-----+-----+-----+-----+-----+          +-----+-----+-----+-----+-----+-----+
|Sft/(|swp← |swp↓ |swp↑ |swp→ |     |          |  |  |  !  |  @  |  #  |  ~  |Sft/)|
+-----+-----+-----+-----+-----+-----+          +-----+-----+-----+-----+-----+-----+
                    +-----+-----+-----+    +-----+-----+-----+
                    |full |rotat|(hld)|    |  _  |  (  |  )  |
                    +-----+-----+-----+    +-----+-----+-----+
```

### L4 Mouse (hold right inner thumb)

The left hand controls cursor and scroll. The right hand has one-handed editing shortcuts.

```
+-----+-----+-----+-----+-----+-----+          +-----+-----+-----+-----+-----+-----+
|Ctrl |Scr L|Scr D|Scr U|Scr R|     |          |     |newTb|close|save |slAll| Alt |
+-----+-----+-----+-----+-----+-----+          +-----+-----+-----+-----+-----+-----+
| Cmd |Mse L|Mse D|Mse U|Mse R|     |          |     |undo | cut |copy |paste|     |
+-----+-----+-----+-----+-----+-----+          +-----+-----+-----+-----+-----+-----+
|     |     |     |     |     |     |          |     |redo |find |     |     |     |
+-----+-----+-----+-----+-----+-----+          +-----+-----+-----+-----+-----+-----+
                    +-----+-----+-----+    +-----+-----+-----+
                    | Mid |Click|Right|    |(hld)|     |     |
                    +-----+-----+-----+    +-----+-----+-----+
```

### L5 Fn + Media (hold Tab)

F-keys live on the right hand. Media controls sit on the left home row. Brightness is on the right pinky.
The H position holds a plain Space for Claude Code voice mode (hold Tab, hold H).
On the custom firmware, the top-left Ctrl position holds QK_BOOT (hold Tab, tap Ctrl) to enter bootloader.

```
+-----+-----+-----+-----+-----+-----+          +-----+-----+-----+-----+-----+-----+
|Boot |     |     |     |     |     |          |     | F7  | F8  | F9  | F12 |ScSht|
+-----+-----+-----+-----+-----+-----+          +-----+-----+-----+-----+-----+-----+
|     |Mute |Vol- |Vol+ |Play |     |          |Space| F4  | F5  | F6  | F11 |Bri+ |
+-----+-----+-----+-----+-----+-----+          +-----+-----+-----+-----+-----+-----+
|     |     |     |     |     |     |          |     | F1  | F2  | F3  | F10 |Bri- |
+-----+-----+-----+-----+-----+-----+          +-----+-----+-----+-----+-----+-----+
                    +-----+-----+-----+    +-----+-----+-----+
                    |(hld)|     |     |    | M0  | M1  | M2  |
                    +-----+-----+-----+    +-----+-----+-----+
```

---

## Macros

| Slot | Keys | Purpose | Layer | Position |
|------|------|---------|-------|----------|
| M0 | RAlt+Space | Raycast launcher | L5 | right thumb outer |
| M1 | LAlt+D | Wispr transcription | L5 | right thumb middle |
| M2 | Ctrl+A | tmux prefix (raw) | L5 | right thumb inner |
| M3 | Ctrl+A, [ | tmux copy mode | L2 | P position |
| M4 | Ctrl+A, - | tmux split horizontal | L2 | U position |
| M5 | Ctrl+A, \| | tmux split vertical | L2 | I position |
| M6 | Ctrl+A, z | tmux zoom pane | L2 | O position |
| M7 | Ctrl+A, g | lazygit popup | L2 | M position |
| M8 | Ctrl+A, a | sesh session picker | L2 | ; position |
| M9 | Ctrl+A, j | zoxide directory jump | L2 | , position |
| M10 | Ctrl+A, c | new tmux window | L2 | . position |
| M11 | Ctrl+A, y | yazi file manager popup | L2 | / position |
| M12 | Alt+P | tmux previous window | L2 | H position |
| M13 | Alt+N | tmux next window | L2 | L position |
| M14 | Alt+Y | tmux previous session | L2 | K position |
| M15 | Alt+U | tmux next session | L2 | J position |

---

## Shared Configs

The keyboard layout is one layer in a stack. The configs in `skhd/` and `tmux/`
are the shared bindings that connect the Piantor to the rest of the environment.

`skhd/skhdrc` defines three modifier domains: Alt for yabai window management,
Hyper (Esc hold) for skhd app launching, and Ctrl+Alt/Shift+Alt for L3 layer
passthrough. `skhd/cycle-display.sh` handles multi-monitor focus cycling.

`tmux/tmux.conf` sets prefix to Ctrl+A with sesh session management, popup
windows for lazygit/yazi/btop, and vim-tmux-navigator pane integration.
`tmux/clipboard-image.sh` pastes clipboard images into the current pane directory.

Karabiner-Elements handles two OS-level remaps for the MacBook built-in keyboard:
Cmd+HJKL arrows from home position, and Caps Lock as Ctrl (tap Escape).

---

## Hardware

- **Board:** [Piantor Pro](https://github.com/beekeeb/piantor) 42-key split, aluminum case
- **Switches:** Nocturnal Silent Linear 20g (lightest available, silent)
- **Keycaps:** [CS Chicago Stenographer](https://www.asymplex.xyz/product/cs-chicago-stenographer-profile) (cold-cast resin, porcelain feel, Choc-compatible)
- **Firmware:** [Vial](https://get.vial.today/) (QMK fork with live configuration)
