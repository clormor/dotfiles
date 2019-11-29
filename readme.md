Home Directory
==============

A selection of files in my home directory (mostly dot files) that are painful
to re-create when moving between machines.

## How to safely clone

    cd ~
    git init
    git remote add origin git@github.com:clormor/home-directory.git
    git fetch
    git pull origin master

At this point, git will throw an error with a list of untracked files and
directories. Manually *move* these files and directories to a backup location,
e.g.

    # do this for each untracked file that git warns you about
    mv .bashrc .bashrc.backup
    ...

After that you can successfully pull;

    git pull origin master
