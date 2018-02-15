#!/bin/bash
# This will display the thanks dialog after updating WNL
# YAD required, Images in ~/.wt8 required
ICON=/root/.wt8/images/icons/caffeine-icon.png
yad --display=$DISPLAY \
 --title="Thank you for updating!" \
 --window-icon=$ICON \
 --html\
 --height="10"\
 --fixed\
 --button='Got It!'\
 --text="<span font='Ubuntu Condensed 11'>\n\tThank you for updating WeakNet LINUX to <b>rev $1</b>\t\n\tPlease be sure to run this tool frequently for all updates.\n\nMore information about this can be found on my GitHUB respository\t\n\n<a href='https://github.com/weaknetlabs/wnl-updater-tool'>https://github.com/weaknetlabs/wnl-updater-tool</a></span>"\
 --image=$ICON\
 --window-on-top
