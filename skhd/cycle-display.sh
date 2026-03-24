#!/bin/sh
# Cycle to next display by focusing a real window on it.
# Overlay apps (Wispr Flow, system widgets) report as windows but cannot take
# keyboard focus, so we filter them out.

cur=$(yabai -m query --displays --display | jq '.index')
total=$(yabai -m query --displays | jq 'length')
next=$(( cur % total + 1 ))

# Skip unfocusable overlay apps (use '| not' because != breaks in some shells)
win=$(yabai -m query --windows --display $next \
  | jq '[.[] | select((.app == "Wispr Flow" or .app == "Notification Centre" or .app == "Control Centre") | not)] | .[0].id')

if [ "$win" != "null" ] && [ -n "$win" ]; then
  yabai -m window --focus "$win"
else
  yabai -m display --focus "$next"
fi
