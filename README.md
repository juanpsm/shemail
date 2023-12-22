# SHemail

Get mails (more specifically, authentication codes) from your terminal.

## Reqs

* `gpg` for encripting credentials
* `curl` to get mails from [gmail feed](https://mail.google.com/mail/feed/atom)
* Common linux command-line tools such as `tr`, `head`, `sed`, `tac`
* For notifications (ubuntu): `notify-send` and `paplay`
* a gmail account

## Usage

### Credentials

First, you need to encrypt your credentials into a file. You need at least one
gpg key which you can create or see with:

```shell
# See keys
gpg --list-keys
# Create key
gpg --full-gen-key
```

Then using the example file, create and edit the credential file:

```shell
cp .creds.example .creds
```

Edit the newly created file with your own credentials. Then encrypt using the
public key previously retrieved:

```shell
cat .creds | gpg --recipient PUBLIC-KEY --encrypt > .creds.gpg
```

### Configuration

There is no easily customizable configuration at the moment. Feel free to edit
the script.

The script retrieves the last 10 emails and searchs for `"AuthCode:"` in their
subjects, expecting the auth code email is titled something like

```text
AuthCode: 508892
```

If found it displays the latest code, with its arrival date. Then it loops
fetching new mail until a new one matching that subject arrives, showing the
code, sending a desktop notification (for gnome) and playing a sound 
(pulseaudio).

### Use

You can make a link to some dir in your `PATH` to use the scrip anywhere:

```shell
ln -s <path/to/shemail> <file-in-your-PATH>
# for example
ln -s ~/tools/shemail/shemail ~/bin/shemail
```

```text
❯ shemail
૮ ᴖﻌᴖა Sυρєя Ç0∂3 R3тяiєνєя ૮–ﻌ– ა
꒷꒦꒷꒦꒷꒦꒷꒦꒷꒦꒷꒦꒷꒦꒷꒦꒷
v0.0.3

Your last code (on 22/12/23 17:13:13) was: 715059 ୭̥⋆*｡
(Run what you need to run in order to get a new code.)
 🐾  Checking mails (CRTL+C to quit)  🌕︎🌕︎🌕︎🌕︎🌕︎🌕︎🌕︎🌕︎🌕︎🌕︎🌕︎🌕︎🌕︎🌕︎🌕︎🌕︎
૮ ⚆ﻌ⚆ა New code found (22/12/23 18:57:39): 508892
Have fun! ૮ ˙Ⱉ˙ ა rawr!
```
