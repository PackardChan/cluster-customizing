# cluster-customizing

Files in [local](local/) are for your local computer, or any other cluster. \
Files in [share](share/) are for all machine (local, odyssey and cheyenne).

## .ssh/config (Single sign on)
1. Download corresponding .ssh/config to your local/remote machine.
2. Create a token (password required):
```
ssh -Y -C -o ServerAliveInterval=30 -fN ody
```
After this, you are *still in local machine*, but you can see a token named like `~/.ssh/pchan@login.rc.fas.harvard.edu:22-localhost.localdomain`
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

## My overall login practice
1. Download openauth in local computer (NOT phone)
2. Put openauth in startup
3. If vpn is lost, connect vpn.
4. Login to rcnx01 (remember password for NoMachine and XShell, or ssh-copy-id)
5. Every month after monthly maintenance, `ssh -Y -C -o ServerAliveInterval=30 -fN rclogin14`
6. Every month after monthly maintenance, `ssh -Y -C -o ServerAliveInterval=30 -fN che`
7. `ssh -Y rclogin14`

## .inputrc (history-search-backward)

