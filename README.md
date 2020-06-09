# VimTools
An awesome, user friendly set of `vim` commands (and other configurations) for improving developer workflow! This repository basically just contains a `.vimrc` file that enables some basic settings and also defines some user friendly shortcuts for common operations such as substitutions, inserts, etc.  

## Setup
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

## List of custom commands (implemented to date)
### Replace | Sub
_Description_: The _Replace_ or _Sub_ commands are used to replace text within either a range of lines or in the entire file.  
_Syntax_:
```
:Replace <foo> <bar>
:Replace <foo> <bar> <start-line> <end-line>
:Sub <foo> <bar>
:Sub <foo> <bar> <start-line> <end-line>
```
_Examples_:
1. Replace `cat` with `dog` in an entire file:  
```
:Sub cat dog
```
2. Replace `Lorem ipsum` with `foobar` between lines 2 and 4 (inclusive):
```
:Sub Lorem\ ipsum foobar 2 4
```

### Delete | Del
_Description_: The _Delete_ or _Del_ commands are used to delete lines within a range.
_Syntax_:
```
:Delete <start-line> <end-line>
:Del <start-line> <end-line>
```
_Examples_:
1. Delete lines 1 though 5:
```
:Del 1 5
```



