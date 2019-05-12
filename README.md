# cluster-customizing
Describes how I customize my accounts in computer clusters, with some specific tips for Harvard Odyssey and NCAR Cheyenne.

Files in [local](local/) are for your local computer, or any other cluster. \
Files in [share](share/) are for all machines (local, odyssey and cheyenne).

<a name="contents"></a>
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->


- [.ssh/config (Single sign on, for Mac or other Linux-like systems)](#sshconfig-single-sign-on-for-mac-or-other-linux-like-systems)
- [Publickey (No password sign on)](#publickey-no-password-sign-on)
- [.ssh/config (No password sign on with host-based authentication)](#sshconfig-no-password-sign-on-with-host-based-authentication)
- [~NoMachine for Odyssey~ (Decommissioned)](#nomachine-for-odyssey-decommissioned)
- [My Odyssey login practice](#my-odyssey-login-practice)
- [File transfer - ZModem](#file-transfer---zmodem)
- [File transfer - other](#file-transfer---other)
- [.inputrc (history-search-backward)](#inputrc-history-search-backward)
- [.vim .vimrc](#vim-vimrc)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## .ssh/config (Single sign on, for Mac or other Linux-like systems)
[Back to contents](#contents)

[SSH ControlMaster](https://www.rc.fas.harvard.edu/resources/documentation/linux/using-ssh-controlmaster-for-single-sign-on/) allows you to sign on once and reuse it. You must go from same source node to same destination node.
1. On source node, download corresponding .ssh/config, and change pchan to your username on destination node. In the example below, I have defined a nickname `ody`. I have appended ControlPath with -%l so that different source nodes on same file system will not interfere.
```
Host ody
  User pchan
  HostName login.rc.fas.harvard.edu
  ControlMaster auto
  ControlPath ~/.ssh/%r@%h:%p-%l
```
2. On source node, run `ssh -CY -o ServerAliveInterval=30 -fN ody` to create a token (password required). This step prints nothing to screen and you are **still on source node**, but a token named like `~/.ssh/pchan@login.rc.fas.harvard.edu:22-localhost.localdomain` is created.

3. When token exists and is open, use nickname `ody` to replace `username@address` (examples below). **Stop and redo step 2** if you are asked for password.
```
ssh -Y ody
rsync ody:~/some_file ~/  # file transfer
sftp ody
```

## Publickey (No password sign on)
[Back to contents](#contents)

```
ssh-keygen
ssh-copy-id pchan@rcnx01.rc.fas.harvard.edu
```
https://www.thegeekstuff.com/2008/11/3-steps-to-perform-ssh-login-without-password-using-ssh-keygen-ssh-copy-id/

## .ssh/config (No password sign on with host-based authentication)
[Back to contents](#contents)

Cheyenne only, across various cheyenne login nodes.
```
Host cheyenne?
  HostName %h.ib0
```

## ~NoMachine for Odyssey~ (Decommissioned)
[Back to contents](#contents)

 * Can disconnect and reconnect without losing your session.
 * Faster graphic forwarding than [X11](https://www.rc.fas.harvard.edu/resources/documentation/x11-forwarding/).
1. Avoid loading modules in bashrc.
1. Follow instructions on [RC page](https://www.rc.fas.harvard.edu/resources/documentation/nx-nomachine/).
1. I suggest saving password, and GNOME desktop in the connection file.
1. <kbd>Ctrl</kbd><kbd>Alt</kbd><kbd>0</kbd>, click `Display`, turn on `Resize remote screen`.
1. From top-left corner, click `Applications` > `System Tools` > `Terminal` to open a new terminal.
 * Some keyboard shortcuts may not work. I use right click to copy and paste.

## My Odyssey login practice
[Back to contents](#contents)

1. Download [openauth](https://www.rc.fas.harvard.edu/resources/documentation/openauth/) on local computer (NOT phone).
2. Put openauth in startup. Windows user: follow steps below. Mac user: invent your way and tell me.
   1. In `File Explorer`, simply type `startup` in path line. This will bring you to `C:\Users\some_user\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup`.
   2. From downloaded zip file of openauth, copy `*-openauth.bat` into startup folder.
   3. Edit `*-openauth.bat` with absolute path of `JAuth.jar`, e.g. `start javaw -jar C:\Users\some_user\Desktop\JAuth.jar`.
3. Connect **RC** VPN at `vpn.rc.fas.harvard.edu` with username like `pchan@odyssey`.
4. Login to rcnx01 (remember password for NoMachine and XShell, or ssh-copy-id).
5. Every time after monthly maintenance, `ssh -CY -o ServerAliveInterval=30 -fN rclogin14`.
6. Every time after monthly maintenance, `ssh -CY -o ServerAliveInterval=30 -fN che`.
7. `ssh -Y rclogin14`

## File transfer - ZModem
[Back to contents](#contents)

I like lrzsz (ZModem) for small file transfer (no need to switch to another terminal/program!). \
Mac user: follow this [link](https://gist.github.com/meowoodie/4bcf6d6ae81727b618bf) to set up. \
Windows user: use XShell - [Home/School Free Version available](https://www.netsarang.com/download/free_license.html), or [other clients that support ZModem](https://en.wikipedia.org/wiki/Comparison_of_SSH_clients#Features). \
After that, download [sz and rz](share/bin/) and put under `~/bin/` (this is usually in your path by default). \
Now, you can run `sz some_file` to download and `rz` to upload.

## File transfer - other
[Back to contents](#contents)

 * Odyssey Home directory and Lab storage can be mounted on your local computer. ([link](https://www.rc.fas.harvard.edu/resources/documentation/mounting-storage/))
 * [Dropbox synchronizing](https://www.dropboxwiki.com/tips-and-tricks/using-the-official-dropbox-command-line-interface-cli). Try get [Harvard-funded Dropbox](https://wiki.harvard.edu/confluence/display/USERDOCS/SEAS+Dropbox+eligibility+table).
 * GitHub - [free student pack available](https://help.github.com/articles/applying-for-a-student-developer-pack/).
 * Large file transfer with Globus (link: [Cheyenne](https://www2.cisl.ucar.edu/resources/storage-and-file-systems/globus-file-transfers), [Odyssey](https://www.rc.fas.harvard.edu/globus-file-transfer/)).
 * More options on [RC page](https://www.rc.fas.harvard.edu/resources/odyssey-quickstart-guide/#Transfer_any_files_you_may_need).

## .inputrc (history-search-backward)
[Back to contents](#contents)

Bottons (e.g. <kbd>PageUp</kbd> or <kbd>&uparrow;</kbd>) can be bound to action `history-search-backward`, so no need to memorize and type historical commands. In bash, this can be done by inputrc (defaults in /etc/inputrc).
1. (Usu. Windows) If there is <kbd>PageUp</kbd> on your keyboard and it can go to remote server, you can download [.inputrc.less](share/.inputrc.less) and move to `~/.inputrc`.
1. If not (usu. Mac), you can download [.inputrc.more](share/.inputrc.more) and move to `~/.inputrc`. This will bind <kbd>&uparrow;</kbd> to `history-search-backward`, instead of `previous-history`.
1. For the first time, sign out and sign in, or `bind -f ~/.inputrc` to load the new inputrc.
1. Now when you type `cd`<kbd>PageUp</kbd>, or `ss`<kbd>PageUp</kbd>, you will be able to use <kbd>PageUp</kbd> and <kbd>PageDn</kbd> to search historical commands. Use <kbd>&uparrow;</kbd> and <kbd>&downarrow;</kbd> instead if you used .inputrc.more. Use <kbd>Ctrl</kbd><kbd>c</kbd> to stop searching.
1. You might also want to do `export HISTSIZE=9999` and `export HISTCONTROL=ignoredups` in your .bashrc to store more histories.

## .vim .vimrc
[Back to contents](#contents)


