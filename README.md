# cluster-customizing

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

## File transfer
https://gist.github.com/meowoodie/4bcf6d6ae81727b618bf

## .inputrc (history-search-backward)

## .vim .vimrc

