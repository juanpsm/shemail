#!/bin/bash
#Desc: Fetch gmail tool

# Decrypts passwords quietly
# see: https://wiki.archlinux.org/index.php/Mutt#Passwords_management
#source "gpg -dq $HOME/creds.gpg |"
. <(gpg -qd "$HOME/creds.gpg")

# Username and password for your Gmail/G Suite account
username=$my_user
# Password assigned from decrypted file
password=$my_pass

SHOW_COUNT=1 # No of recent unread mails to be shown

echo
curl  -u $username:$password --silent "https://mail.google.com/mail/feed/atom" | \
tr -d '\n' | sed 's:</entry>:\n:g' |\
 sed -n 's/.*<title>\(.*\)<\/title.*<author><name>\([^<]*\)<\/name><email>\([^<]*\).*/From: \2 [\3] \nSubject: \1\n/p' | \
head -n $(( $SHOW_COUNT * 3 ))