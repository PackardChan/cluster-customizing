# cluster-customizing
Describes how I customize my accounts in computer clusters, with some specific advice for Harvard Odyssey and NCAR Cheyenne.

Files in [local](local/) are for your local computer, or any other cluster. \
Files in [share](share/) are for all machine (local, odyssey and cheyenne).

## .ssh/config (Single sign on)
1. Download corresponding .ssh/config to your local/remote machine.
2. Create a token (password required):
```
ssh -CY -o ServerAliveInterval=30 -fN ody
```
After this, you are **still in local machine**, but you can see a token named like `~/.ssh/pchan@login.rc.fas.harvard.edu:22-localhost.localdomain` \
3. When token exists, use `ody` to replace `username@address`, e.g.:
```
ssh -Y ody
rsync ody:~/some_file ~/  # file transfer
```
https://www.rc.fas.harvard.edu/resources/documentation/linux/using-ssh-controlmaster-for-single-sign-on/

## No password sign on (with publickey)
```
ssh-keygen
ssh-copy-id pchan@rcnx01.rc.fas.harvard.edu
```
https://www.thegeekstuff.com/2008/11/3-steps-to-perform-ssh-login-without-password-using-ssh-keygen-ssh-copy-id/

## .ssh/config (No password sign on with host-based authentication)
Cheyenne only, across various cheyenne login nodes.
```
Host cheyenne?
HostName %h.ib0
```

## NoMachine for Odyssey

## My Odyssey login practice
1. Download [openauth](https://www.rc.fas.harvard.edu/resources/documentation/openauth/) on local computer (NOT phone).
2. Put openauth in startup. Windows user: use steps below. Mac user: invent your way and tell me.
   1. In `File Explorer`, simply type `startup` in path line. This will bring you to `C:\Users\some_user\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup`.
   2. From downloaded zip file of openauth, copy `*-openauth.bat` into startup folder.
   3. Correct `*-openauth.bat` with absolute path of `JAuth.jar`, e.g. `start javaw -jar C:\Users\some_user\Desktop\JAuth.jar`.
3. Connect **RC** VPN at `vpn.rc.fas.harvard.edu` with username like `pchan@odyssey`.
4. Login to rcnx01 (remember password for NoMachine and XShell, or ssh-copy-id).
5. Every time after monthly maintenance, `ssh -CY -o ServerAliveInterval=30 -fN rclogin14`.
6. Every time after monthly maintenance, `ssh -CY -o ServerAliveInterval=30 -fN che`.
7. `ssh -Y rclogin14`

## File transfer - ZModem
I like lrzsz (ZModem) for small file transfer (no need to switch to another terminal/program!). \
Mac user: follow this [link](https://gist.github.com/meowoodie/4bcf6d6ae81727b618bf) to set up. \
Windows user: use XShell - [Home/School Free Version available](https://www.netsarang.com/download/free_license.html), or [other clients that support ZModem](https://en.wikipedia.org/wiki/Comparison_of_SSH_clients#Features). \
After that, download [sz and rz](share/bin/) and put under `~/bin/` (this is usually in your path by default). \
Now, you can run `sz some_file` to download and `rz` to upload. \

## File transfer - other
 * Odyssey Home directory and Lab storage can be mounted on your local computer. ([link](https://www.rc.fas.harvard.edu/resources/documentation/mounting-storage/))
 * [Dropbox synchronizing](https://www.dropboxwiki.com/tips-and-tricks/using-the-official-dropbox-command-line-interface-cli). Try get [Harvard-funded Dropbox](https://wiki.harvard.edu/confluence/display/USERDOCS/SEAS+Dropbox+eligibility+table).
 * Large file transfer with Globus ([Cheyenne](https://www2.cisl.ucar.edu/resources/storage-and-file-systems/globus-file-transfers), [Odyssey](https://www.rc.fas.harvard.edu/globus-file-transfer/)).
 * More options on [RC page](https://www.rc.fas.harvard.edu/resources/odyssey-quickstart-guide/#Transfer_any_files_you_may_need).

## .inputrc (history-search-backward)

## .vim .vimrc

