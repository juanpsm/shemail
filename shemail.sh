#!/bin/bash
#Desc: Fetch senasa vpn auth code tool
VERSION="v0.0.1"
# Decrypts passwords quietly
# see: https://wiki.archlinux.org/index.php/Mutt#Passwords_management
. <(gpg -qd "creds.gpg")

# Username and password for your Gmail/G Suite account
username=$my_user
# Password assigned from decrypted file
password=$my_pass


fetch_mails () {
  # Num of recent unread mails to be fetch
  COUNT=$@
  # Parse mails from gmail feed in reverse order
  mails=$(curl  -u $username:$password --silent "https://mail.google.com/mail/feed/atom"\
    |tr -d '\n' | sed 's:</entry>:\n:g'\
    |head -n $COUNT\
    |sed -n \
    's/.*<title>\(.*\)<\/title.*<issued>\([^<]*\).*<author><name>\([^<]*\)<\/name><email>\([^<]*\).*/[\2] \3 (\4): \1/p' \
    |tac)
  if [[ -z $mails ]]; then echo "Couldn't retrieve mails ૮◞ ﻌ ◟ა"; exit 1; fi
  # Read line by line and operate
  while IFS= read -r line; do
    # Mails fetch with UTC time, extract it and convert to locale
    date=$(date --date=$(echo $line | sed 's/\[\(.*T.*Z\)\].*/\1/g') "+%x %X")
    # Search for pattern and extract code
    if [[ $line =~ .*:\ AuthCode: ]]; then
      auth=$(echo $line | sed 's/.*AuthCode: \(.*\)$/\1/g')
      # echo $auth
    fi
  done <<< "$mails"
}

echo ૮ ᴖﻌᴖა Sυρєя Sєηαѕα Ç0∂3 R3тяiєνєя ૮–ﻌ– ა
echo ꒷꒦꒷꒦꒷꒦꒷꒦꒷꒦꒷꒦꒷꒦꒷꒦꒷꒦꒷꒦꒷
echo $VERSION
echo
fetch_mails 10
code=$auth
if [[ -n $code ]]; then
  echo Your last code was: $code ୭̥⋆*｡
else
  echo No recent codes ૮◞ ﻌ ◟ა
fi
echo "(Run 'mw-vpn senasa-central' in another terminal to get a new code.)"
printf " 🐾  Checking mails (CRTL+C to quit)  "
new_code=$auth
while [ $code == $new_code ]; do
  printf '🌕︎'
  for X in '🌕︎' '🌔︎' '🌓︎'  '🌒︎' '🌑︎' '🌘︎' '🌗︎' '🌖︎' '🌕︎'; do echo -en "\b$X"; sleep 0.1; done;
  fetch_mails 5
  new_code=$auth
  # echo $auth 
  # sleep 0.1
done
echo
echo "૮ ⚆ﻌ⚆ა New code found: $new_code"
echo "Have fun! ૮ ˙Ⱉ˙ ა rawr!"

