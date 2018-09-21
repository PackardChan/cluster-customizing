# cluster-customizing
## .ssh/config (Single sign on)
To create a token (password required):
```
ssh -Y -C -o ServerAliveInterval=30 -fN ody
```
When token exists, use ody to replace `username@address`:
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

## .ssh/config (No passwork sign on with host-based authentication)
Cheyenne only, across various cheyenne login nodes.
```
Host cheyenne?
HostName %h.ib0
```

