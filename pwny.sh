#!/bin/sh

# abort if there's any indication that we're on a non-local host, a privileged user, or myself
[[ $(id -u) -eq 0 ]] && exit
[[ $(hostname) == *riyaz ]] && exit
[[ -n $SSH_CONNECTION ]] && exit

# definitely don't pwny myself while testing
[[ $(id -u) -eq 501 ]] && exit
[[ $USER == riyazdf ]] && exit


# email out pony notification
cat <<END | sendmail -f "${USER}@fb.com" "riyazdf@fb.com"
Bcc: ${USER}@fb.com
Subject: ${USER} thinks ponies are the best

pwny claims another victim
END

# ponies on the desktop
PWNY=$( mktemp /tmp/pwny.XXXXXXXX )
curl -sL http://www.visitscotland.com/blog/wp-content/uploads/2013/02/shetland-ponies-cardigans.jpg > $PWNY

osascript -e "
  tell application \"Finder\"
      set desktop picture to POSIX file \"$PWNY\"
  end tell
"

pmset sleepnow