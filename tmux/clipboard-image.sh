#!/bin/bash
# Save clipboard image to current pane's working directory.
# Auto-names with timestamp. Shows tmux message on success.

CWD="$1"
if [ -z "$CWD" ]; then
  tmux display-message "No working directory"
  exit 1
fi

# Check if clipboard has image data
HAS_IMAGE=$(osascript -e 'try' -e 'the clipboard as «class PNGf»' -e 'return "png"' -e 'on error' -e 'return "none"' -e 'end try' 2>/dev/null)

if [ "$HAS_IMAGE" != "png" ]; then
  tmux display-message "No image on clipboard"
  exit 0
fi

FILENAME="clipboard-$(date +%Y%m%d-%H%M%S).png"
FILEPATH="$CWD/$FILENAME"

osascript \
  -e 'set imgData to the clipboard as «class PNGf»' \
  -e "set filePath to POSIX file \"$FILEPATH\"" \
  -e 'set fp to open for access filePath with write permission' \
  -e 'set eof of fp to 0' \
  -e 'write imgData to fp' \
  -e 'close access fp' 2>/dev/null

if [ $? -eq 0 ]; then
  tmux display-message "Saved: $FILENAME"
else
  tmux display-message "Failed to save clipboard image"
fi
