#!/bin/bash
#Desc: Fetch gmail tool

# Decrypts passwords quietly
# see: https://wiki.archlinux.org/index.php/Mutt#Passwords_management
. <(gpg -qd "creds.gpg")

# Username and password for your Gmail/G Suite account
username=$my_user
# Password assigned from decrypted file
password=$my_pass

SHOW_COUNT=3 # No of recent unread mails to be shown

echo
mails=$(curl  -u $username:$password --silent "https://mail.google.com/mail/feed/atom" | \
tr -d '\n' | sed 's:</entry>:\n:g' | \
head -n $SHOW_COUNT | \
sed -n 's/.*<title>\(.*\)<\/title.*<issued>\([^<]*\).*<author><name>\([^<]*\)<\/name><email>\([^<]*\).*/From: \3 [\4] at \2 \nSubject: \1\n/p'
)

while IFS= read -r line; do
  if [[ $line =~ .*at.* ]]; then
    date=$(echo $line | sed -e "s/.* at \(.*T.*Z\)/\1/g")
    date=$(date --date=$date +%x-%X)
    echo "... $line ..."
    echo $date
  else
    echo $line
  fi
done <<< "$mails"

