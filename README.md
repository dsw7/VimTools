# VimTools
This repository contains the `.vim` directory that I use in my day to day programming, both professionally and leisurely.
## Setup
I recommend grabbing the contents of the `vimtools.sh` file as follows:
```
$ curl https://raw.githubusercontent.com/dsw7/VimTools/master/vimtools.sh > vimtools.sh && source vimtools.sh && fetch_vimtools
```
The `vimtools.sh` script simply downloads a `.zip` archive of this project and unpacks it into `${PWD}/.vim`. **Warning: this will remove existing an existing .vim directory!** To make life a little easier, the contents of the `vimtools.sh` script can be appended to a `.bashrc` file and the latest VimTools package can obtained as follows:
```
cd
source .bashrc
fetch_vimtools
```
## List of custom commands (implemented to date)
### S
_Description_:  
- The _S_ command is used to replace text within either a range of lines or in the entire file. The _S_ command replaces the contents of the `"/` register with a new entry `<bar>`

_Syntax_:  
```
:/<foo>
:S <bar>
```
Or:
```
:/<foo>
:S <bar> <start-line> <end-line>
```
_Examples_:  
- Replace `cat` with `dog` in an entire file:
```
:/cat
:S dog
```
- Replace `Lorem` with `ipsum` between lines 2 and 4 (inclusive):

```
:/Lorem
:S ipsum 2 4
```

### SubAll
_Description_:  
- The _SubAll_ command is used to replace text in all files within the current working directory or the current working directory and all subdirectories

_Syntax_:  
```
:SubAll <foo> <bar> <*|**>
```
_Examples_:  
- Replace `cat` with `dog` in the current file and all files within the current working directory and subdirectories:

```
:SubAll cat dog **
```

### Del
_Description_:  
- The _Del_ command is used to delete lines within a specified range.

_Syntax_:  
```
:Del <start-line> <end-line>
```
_Examples_:  
- Delete lines 1 though 5:

```
:Del 1 5
```

### Ind
_Description_:  
- The _Ind_ command is used to indent lines by **4 spaces** within a specified range.

_Syntax_:  
```
:Ind <start-line> <end-line>
```
_Examples_:  
- Suppose we have the following code:

```c++
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
```c++
1 namespace foo {
2     void bar() {
3         std::cout << "A foo that bars!" << std::endl;
4         std::cout << "What does that even mean?" << std::endl;
5     }
6 }
```

### Ins
_Description_:  
- The _Ins_ command is used to insert a character at the beginning of every line within a specified range. This command is useful for commenting out large blocks of code.

_Syntax_:  
```
:Ins <char> <start-line> <end-line>
```
_Examples_:  
- Suppose we want to comment out the following:

```c++
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
Note that we had to escape the forward slashes in the above example. The command returns:  
```c++
1 //namespace foo {
2 //    void bar() {
3 //        std::cout << "A foo that bars!" << std::endl;
4 //        std::cout << "What does that even mean?" << std::endl;
5 //    }
6 //}
```

### Cp
_Description_:  
- The _Cp_ command is used to copy and paste a block of lines. 

_Syntax_:  
```
:Cp <start-line> <end-line> <destination>
```
_Examples_:  
- Suppose we want to copy the following code to lines 8 onward:

```c++
1 namespace foo {
2     void bar() {
3         std::cout << "A foo that bars!" << std::endl;
4         std::cout << "What does that even mean?" << std::endl;
5     }
6 }
```
The following command;
```
:Cp 1 6 8
```
Will yield the following:
```c++
1  namespace foo {
2      void bar() {
3          std::cout << "A foo that bars!" << std::endl;
4          std::cout << "What does that even mean?" << std::endl;
5      }
6  }
7
8  namespace foo {
9      void bar() {
10         std::cout << "A foo that bars!" << std::endl;
11         std::cout << "What does that even mean?" << std::endl;
12     }
13 }
```

### Ws
_Description_:  
- The _Ws_ command is used to remove trailing whitespace. 

_Syntax_:  
```
:Ws
```
Command takes no arguments.

### Mv
_Description_:  
- The _Mv_ command is used to move a block of text.

_Syntax_:  
```
:Mv <start-line> <end-line> <destination>
```
_Examples_:  
- Suppose we drag the following code to line 9:

```c++
1 namespace foo {
2     void bar() {
3         std::cout << "A foo that bars!" << std::endl;
4         std::cout << "What does that even mean?" << std::endl;
5     }
6 }
```
The following command will do the trick:  
```
:Mv 1 6 9
```
The result:
```c++
1
2
3
4 namespace foo {
5     void bar() {
6         std::cout << "A foo that bars!" << std::endl;
7         std::cout << "What does that even mean?" << std::endl;
8     }
9 }
```

### Paste
_Description_:  
- The _Paste_ command is used to paste system clipboard contents to a file.

_Syntax_:  
```
:Paste
```
_Examples_:  
- Suppose we want to copy the following text into line 2 of a file:  
```
Lorem ipsum dolor sit amet...
```
We would start by hightlighting the above text and using the standard command `Ctrl-C`. We would then move the cursor to line 2 in the Vim session and type:
```
:Paste
```
Which would yield:
```
1
2 Lorem ipsum dolor sit amet...
```

### Wl
_Description_:  
- The _Wl_ command removes whitespace before a set of lines.

_Syntax_:  
```
:Wl <start-line> <end-line>
```
_Examples_:  
- Suppose we copied the following into the editor:    
```
1 Lorem
2     ipsum
3         dolor
4             sit 
5                 amet...
```
We could re-align the text as follows:
```
:Wl 1 5
```
Which would yield:
```
1 Lorem
2 ipsum
3 dolor
4 sit 
5 amet...
```

### Header
_Description_:  
- The _Header_ command inserts some sort of header in a README or related file.

_Syntax_:  
```
:Header <header-text>
```
Or:
```
:Header <header-text> <padding>
```
_Examples_:  
- Insert a title with default padding:
```
:Header FOOBARBAZ
```
Yields:
```
1 =====================
2 ===== FOOBARBAZ =====
3 =====================
```
The `<padding>` option specifies how much lateral padding to add:
```
:Header FOOBARBAZ 15
```
Yields:
```
1 =========================================
2 =============== FOOBARBAZ ===============
3 =========================================
```
### Col
_Description_:  
- The _Col_ command simply enables `cursorcolumn`. Calling the command a second time will disable `cursorcolumn`. The command takes no arguments.
