# heavy-handed

A 42-key split keyboard layout for the Piantor Pro with 20g Kailh Choc switches. The switches activate if you breathe on them. The name is aspirational.

Vial firmware. Load `piantor-pro-heavy-handed.vil` in [Vial](https://get.vial.today/) and flash.

## Philosophy

Every key serves one purpose. No redundant layers. The six thumb keys handle layers and the three most frequent non-alpha keys (Backspace, Space, Enter). Modifiers stay on the outer pinky columns: Ctrl (top left), Cmd (home left), Alt (top right), Shift-parens (bottom both). The right outer thumb is Escape on tap, Hyper (all four modifiers) on hold, because Escape is the most common single-key action in vim and tmux, and Hyper gives Karabiner a dedicated modifier namespace with zero collisions.

Ghost glyph protection: the inner column keys (T/G/B and Y/H/N positions) send nothing on every layer except base. At 20g actuation, your thumb grazes these keys during fast typing. If they contain Insert, F-keys, or Caps Lock, you get phantom output. The fix is structural: make the wrong thing absent, not unlikely.

## Base Layer

```
+-----+-----+-----+-----+-----+-----+     +-----+-----+-----+-----+-----+-----+
|Ctrl |  Q  |  W  |  E  |  R  |  T  |     |  Y  |  U  |  I  |  O  |  P  | Alt |
+-----+-----+-----+-----+-----+-----+     +-----+-----+-----+-----+-----+-----+
| Cmd |  A  |  S  |  D  |  F  |  G  |     |  H  |  J  |  K  |  L  |  ;  |  '  |
+-----+-----+-----+-----+-----+-----+     +-----+-----+-----+-----+-----+-----+
|Sft/(|  Z  |  X  |  C  |  V  |  B  |     |  N  |  M  |  ,  |  .  |  /  |Sft/)|
+-----+-----+-----+-----+-----+-----+     +-----+-----+-----+-----+-----+-----+
              +-----+-----+-----+     +-----+-----+-----+
              | Tab |BkSp |Enter|     |Click|Space| Esc |
              | L5  | L1  | L3  |     | L4  | L2  |Hyper|
              +-----+-----+-----+     +-----+-----+-----+
```

Left outer column: Ctrl (top), Cmd (home), Shift/( (bottom). Right outer column: Alt (top), quote (home), Shift/) (bottom). Cmd on left home pinky keeps one-handed Cmd+ZXCV comfortable.

The right inner thumb taps left-click and holds for the mouse layer. Useful for scrolling without leaving the keyboard.

## Layers

| Hold | Layer | Purpose |
|------|-------|---------|
| Backspace | L1 Num | Numbers, brackets |
| Space | L2 Nav | Arrows, home/end/pgup/pgdn, Cmd+ZXCV, tmux HJKL nav |
| Enter | L3 Sym | Shifted symbols |
| Right inner thumb | L4 Mouse | Mouse movement, scroll, buttons |
| Tab | L5 Fn | F-keys, macros, brightness, volume, playback |

### L1 Num (hold Backspace)

Left hand empty, right hand numpad with brackets.

```
+-----+-----+-----+-----+-----+-----+     +-----+-----+-----+-----+-----+-----+
|     |     |     |     |     |     |     |  [  |  7  |  8  |  9  |  ]  | Alt |
+-----+-----+-----+-----+-----+-----+     +-----+-----+-----+-----+-----+-----+
|     |     |     |     |     |     |     |  =  |  4  |  5  |  6  |  ;  |  '  |
+-----+-----+-----+-----+-----+-----+     +-----+-----+-----+-----+-----+-----+
|     |     |     |     |     |     |     |  \  |  1  |  2  |  3  |  `  |Sft/)|
+-----+-----+-----+-----+-----+-----+     +-----+-----+-----+-----+-----+-----+
              +-----+-----+-----+     +-----+-----+-----+
              |     |(hld)|     |     |  -  |  0  |  .  |
              +-----+-----+-----+     +-----+-----+-----+
```

### L2 Nav (hold Space)

Left hand arrows and editing, right hand tmux HJKL navigation.

```
+-----+-----+-----+-----+-----+-----+     +-----+-----+-----+-----+-----+-----+
|Ctrl |Home |PgDn |PgUp | End |     |     |     |     |     |     |     | Alt |
+-----+-----+-----+-----+-----+-----+     +-----+-----+-----+-----+-----+-----+
| Cmd |Left |Down | Up  |Right|     |     | tWP | tSN | tSP | tWN |     |     |
+-----+-----+-----+-----+-----+-----+     +-----+-----+-----+-----+-----+-----+
|Sft/(|Cmd+Z|Cmd+X|Cmd+C|Cmd+V|CmdSZ|     |     |     |     |     |     |Sft/)|
+-----+-----+-----+-----+-----+-----+     +-----+-----+-----+-----+-----+-----+
              +-----+-----+-----+     +-----+-----+-----+
              | Del |BkSp |Enter|     |     |(hld)|     |
              +-----+-----+-----+     +-----+-----+-----+
```

Right home row: H=prev window (M12), J=next session (M15), K=prev session (M14), L=next window (M13). Spatial like vim: H/L horizontal (windows), J/K vertical (sessions).

### L3 Sym (hold Enter)

Left hand empty, right hand shifted symbols.

```
+-----+-----+-----+-----+-----+-----+     +-----+-----+-----+-----+-----+-----+
|     |     |     |     |     |     |     |  {  |  &  |  *  |  (  |  }  | Alt |
+-----+-----+-----+-----+-----+-----+     +-----+-----+-----+-----+-----+-----+
|     |     |     |     |     |     |     |  +  |  $  |  %  |  ^  |  :  |  "  |
+-----+-----+-----+-----+-----+-----+     +-----+-----+-----+-----+-----+-----+
|     |     |     |     |     |     |     |  |  |  !  |  @  |  #  |  ~  |Sft/)|
+-----+-----+-----+-----+-----+-----+     +-----+-----+-----+-----+-----+-----+
              +-----+-----+-----+     +-----+-----+-----+
              |     |     |(hld)|     |  _  |  (  |  )  |
              +-----+-----+-----+     +-----+-----+-----+
```

### L4 Mouse (hold right inner thumb)

Left hand controls cursor and scroll, left thumbs for buttons.

```
+-----+-----+-----+-----+-----+-----+     +-----+-----+-----+-----+-----+-----+
|Ctrl |Scr L|Scr D|Scr U|Scr R|     |     |     |     |     |     |     |     |
+-----+-----+-----+-----+-----+-----+     +-----+-----+-----+-----+-----+-----+
| Cmd |Mse L|Mse D|Mse U|Mse R|     |     |     |     |     |     |     |     |
+-----+-----+-----+-----+-----+-----+     +-----+-----+-----+-----+-----+-----+
|     |     |     |     |     |     |     |     |     |     |     |     |     |
+-----+-----+-----+-----+-----+-----+     +-----+-----+-----+-----+-----+-----+
              +-----+-----+-----+     +-----+-----+-----+
              | Mid |Click|Right|     |     |     |(hld)|
              +-----+-----+-----+     +-----+-----+-----+
```

### L5 Fn (hold Tab)

F-keys on right, macros on left, media on outer columns and left thumbs. Del available here since Tab replaced it on base.

```
+-----+-----+-----+-----+-----+-----+     +-----+-----+-----+-----+-----+-----+
|Bri+ |     | F19 | F20 | F21 |     |     |     | F7  | F8  | F9  | F12 |ScSht|
+-----+-----+-----+-----+-----+-----+     +-----+-----+-----+-----+-----+-----+
|Bri- | M9  | M8  | M7  | M3  |     |     |     | F4  | F5  | F6  | F11 |Vol+ |
+-----+-----+-----+-----+-----+-----+     +-----+-----+-----+-----+-----+-----+
|     | M11 | M10 | M6  | M5  | M4  |     |     | F1  | F2  | F3  | F10 |Vol- |
+-----+-----+-----+-----+-----+-----+     +-----+-----+-----+-----+-----+-----+
              +-----+-----+-----+     +-----+-----+-----+
              |(hld)|Mute |Play |     | M0  | M1  | M2  |
              +-----+-----+-----+     +-----+-----+-----+
```

Left macros: M3=copy mode, M4=split-h, M5=split-v, M6=zoom, M7=lazygit, M8=sesh, M9=zoxide, M10=new window, M11=claude window. Right thumbs: M0=Raycast, M1=Whisper, M2=tmux prefix.

## Macros

All 16 slots used. Tmux macros send the prefix (Ctrl+A) then the command key, matching `~/.config/tmux/tmux.conf` bindings exactly.

| Slot | Keys | Purpose |
|------|------|---------|
| M0 | RAlt+Space | Raycast launcher |
| M1 | LAlt+D | Whisper transcription |
| M2 | Ctrl+A | tmux prefix (raw) |
| M3 | Ctrl+A, [ | tmux copy mode |
| M4 | Ctrl+A, \| | tmux split horizontal |
| M5 | Ctrl+A, - | tmux split vertical |
| M6 | Ctrl+A, z | tmux zoom pane |
| M7 | Ctrl+A, g | lazygit popup |
| M8 | Ctrl+A, a | sesh session picker |
| M9 | Ctrl+A, j | zoxide directory jump |
| M10 | Ctrl+A, c | new tmux window |
| M11 | Ctrl+A, C | new claude window |
| M12 | Alt+P | tmux previous window |
| M13 | Alt+N | tmux next window |
| M14 | Alt+Y | tmux previous session |
| M15 | Alt+U | tmux next session |

M12-M15 are placed on L2 right hand home row for spatial tmux nav without the prefix.

## The Ecosystem

### skhd + yabai (window management)

Alt is the window management modifier (right top pinky on the Piantor).

```
Alt + h/j/k/l      Focus window west/south/north/east
Alt + Shift + hjkl  Swap window position
Alt + Ctrl + hjkl   Resize window
Alt + 1-6           Switch to space 1-6
Alt + Shift + 1-6   Move window to space (and follow)
Alt + f             Toggle fullscreen
Alt + r             Rotate layout 90 degrees
Alt + Tab           Toggle last space
Alt + q/w/e/s/a/g   Launch Chrome/WezTerm/Zen/Slack/Asana/Calendar
Alt + c             Screenshot (interactive selection)
```

### Karabiner-Elements (OS-level remaps)

Two rules:

1. **Cmd+HJKL = Arrow keys.** Hold left Cmd (home pinky) and press HJKL for arrow keys from home position. Works on both the Piantor and the MacBook's built-in keyboard.

2. **Left Ctrl alone = Escape.** A safety net for the MacBook's built-in keyboard when traveling without the Piantor.

### tmux (terminal multiplexer)

Prefix is Ctrl+A (keyboard macro M2). The layout's macros match these tmux bindings:

```
Prefix + |         Split horizontal (M4)
Prefix + -         Split vertical (M5)
Prefix + z         Zoom toggle (M6)
Prefix + g         lazygit popup (M7)
Prefix + a         sesh session picker with fzf (M8)
Prefix + j         zoxide directory jump (M9)
Prefix + c         New window (M10)
Prefix + C         New window running claude (M11)
Prefix + [         Copy mode, vi keys (M3)
Prefix + y         yazi file manager popup
Prefix + b         btop / macmon popup
Prefix + f         Fuzzy find panes across all sessions
Prefix + L         Toggle last session (sesh)
Prefix + space     tmux-fingers (vimium-style hint labels for text selection)
Prefix + /         fuzzback (fzf search through scrollback)
Prefix + o         tmux-claude-sessions (switch between Claude Code sessions)
Alt + n/p          Next/previous window (no prefix, M13/M12)
Alt + y/u          Previous/next session (no prefix, M14/M15)
```

Plugins:

| Plugin | What it does |
|--------|-------------|
| [catppuccin/tmux](https://github.com/catppuccin/tmux) | Mocha theme, rounded window tabs, session name in status left, uptime in status right |
| [vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator) | Ctrl+hjkl moves between vim splits and tmux panes seamlessly |
| [tmux-resurrect](https://github.com/tmux-plugins/tmux-resurrect) + [continuum](https://github.com/tmux-plugins/tmux-continuum) | Persist and auto-restore sessions across reboots |
| [tmux-fingers](https://github.com/Morantron/tmux-fingers) | Vimium-style hint labels to yank visible text (Prefix+Space) |
| [tmux-fzf-url](https://github.com/wfxr/tmux-fzf-url) | Extract and open URLs from scrollback with fzf |
| [tmux-fuzzback](https://github.com/roosta/tmux-fuzzback) | fzf search through scrollback history (Prefix+/) |
| [tmux-open-nvim](https://github.com/trevarj/tmux-open-nvim) | Open files from tmux in the nearest neovim instance |
| [tmux-jumplist](https://github.com/joryeugene/tmux-jumplist) | Navigate back/forward through pane history, like Ctrl-O/Ctrl-I in vim |

### sketchybar (status bar)

Top bar running catppuccin mocha to match tmux. Hack Nerd Font for icons and labels.

```
Left:   [workspace indicators]  [focused app name]
Right:  [mail badge] | [cpu] [memory] | [wifi] | [battery] [volume] | [clock]
```

Colors: background `#1e1e2e`, foreground `#cdd6f4`, accents in catppuccin blue (`#89b4fa`), green (`#a6e3a1`), yellow (`#f9e2af`), red (`#f38ba8`). Separators between widget groups. Everything sourced from modular `items/` and `plugins/` directories.

### WezTerm (terminal emulator)

[WezTerm](https://wezfurlong.org/wezterm/) over Ghostty, Kitty, Rio, or Warp. GPU-accelerated, Lua-programmable, cross-platform consistent. Handles Claude Code's large outputs without choking. Pairs with tmux for multiplexing rather than using a built-in multiplexer. More on the full terminal stack in [Terminal Velocity](https://joryeugene.github.io/blog/terminal-velocity/).

### Raycast

Activated by RAlt+Space (macro M0). Vim navigation mode enabled. Extensions include Claude AI, Brew, Kill Process, TLDR. Compact window mode.

## Hardware

- **Board:** [Piantor Pro](https://github.com/beekeeb/piantor) 42-key split, aluminum case
- **Switches:** Nocturnal Silent Linear 20g (lightest available, silent)
- **Keycaps:** [CS Chicago Stenographer](https://www.asymplex.xyz/product/cs-chicago-stenographer-profile) (cold-cast resin, porcelain feel, Choc-compatible)
- **Firmware:** [Vial](https://get.vial.today/) (QMK fork with live configuration)
