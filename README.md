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
### Sub
_Description_:  
The _Sub_ command is used to replace text within either a range of lines or in the entire file.  
_Syntax_:  
```
:Sub <foo> <bar>
:Sub <foo> <bar> <start-line> <end-line>
```
_Examples_:  
Replace `cat` with `dog` in an entire file:  
```
:Sub cat dog
```
Replace `Lorem ipsum` with `foobar` between lines 2 and 4 (inclusive):  
```
:Sub Lorem\ ipsum foobar 2 4
```
The _Sub_ command works with regular expressions. To replace all instances of `for` and `far` in a body of text with `foo`:
```
:Sub f[o|a]r foo
```

### Del
_Description_:  
The _Del_ command is used to delete lines within a specified range.  
_Syntax_:  
```
:Del <start-line> <end-line>
```
_Examples_:  
Delete lines 1 though 5:  
```
:Del 1 5
```

### Ind
_Description_:  
The _Ind_ command is used to indent lines by **4 spaces** within a specified range.  
_Syntax_:  
```
:Ind <start-line> <end-line>
```
_Examples_:  
Suppose we have the following code:  
```
1 namespace foo {
2 void bar() {
3     std::cout << "A foo that bars!" << std::endl;
4     std::cout << "What does that even mean?" << std::endl;
5 }
6 }
```
We want to indent the function within namespace `foo` by 4 spaces:  
```
:Ind 2 5
```
We get:  
```
1 namespace foo {
2     void bar() {
3         std::cout << "A foo that bars!" << std::endl;
4         std::cout << "What does that even mean?" << std::endl;
5     }
6 }
```

### Ins
_Description_:  
The _Ins_ command is used to insert a character at the beginning of every line within a specified range. This command is useful for commenting out large blocks of code.  
_Syntax_:  
```
:Ins <char> <start-line> <end-line>
```
_Examples_:  
Suppose we want to comment out the following:  
```
1 namespace foo {
2     void bar() {
3         std::cout << "A foo that bars!" << std::endl;
4         std::cout << "What does that even mean?" << std::endl;
5     }
6 }
```
The following command will do the trick:  
```
:Ins \/\/ 1 6
```
Note that I had to escape the forward slashes. The command returns:  
```
1 //namespace foo {
2 //    void bar() {
3 //        std::cout << "A foo that bars!" << std::endl;
4 //        std::cout << "What does that even mean?" << std::endl;
5 //    }
6 //}
```
