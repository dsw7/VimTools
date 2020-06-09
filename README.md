# VimTools
An awesome, user friendly set of vim commands (and other configurations) for improving developer workflow! This repository basically just contains a `.vimrc` file that enables some basic settings and also defines some user friendly shortcuts for common operations such as substitutions, inserts, etc.  

### Setup
Easy! Start by grabbing the `dsw7.vimrc` file:
```
$ curl https://raw.githubusercontent.com/dsw7/VimTools/master/dsw7.vimrc --output dsw7.vimrc
```
Then simply source the `dsw7.vimrc` file in your user home's `.vimrc` file if you want to preserve existing configurations:
```
source /path/to/dsw7.vimrc
```
Alternatively, if you don't have an existing `.vimrc` file in your home directory and want to keep things simple:
```
$ cd
$ curl https://raw.githubusercontent.com/dsw7/VimTools/master/dsw7.vimrc --output .vimrc
```
