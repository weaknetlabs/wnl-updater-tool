#!/bin/bash
#
# GUI display what is happening in the script.
# To stop, simply kill tail. e.g.: killall -KILL tail 2>/dev/null
#
ICON=~/.wt8/images/icons/caffeine-icon-small.png
TITLETEXT=$1
TITLE="Installing Upgrades..."
SPANFONT="<span font='Ubuntu Condensed 11'><b>"
tail -f /etc/issue |yad --progress --pulsate --no-buttons --auto-close \
  --text="$SPANFONT $1 </b></span>" --width=350 --center --title="$TITLE" \
  --window-icon=$ICON --percentage=13 --progress-text="Please Wait..." --image=$ICON &
