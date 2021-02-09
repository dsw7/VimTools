# VimTools
This repository contains the `.vim` directory that I use in my day to day programming, both professionally and leisurely.
## Setup
This project is both set up and tested using `make`. To install the project:
```
$ curl https://raw.githubusercontent.com/dsw7/VimTools/master/Makefile > Makefile && make
```
The `make (all)` target simply downloads a `.zip` archive of this project, unpacks it into `${PWD}/.vim` and runs unit tests on the installation. **Warning: this will remove existing an existing .vim directory!**
## Build targets
The default target is `all` which wraps the following targets: `install` and `run-tests`.
### The `install` target:
Run as follows:
```
make install
```
To download and unpack the VimTools project into `$PWD`. To download a specific branch:
```
make install GIT_BRANCH=<branch-name>
```
### The `run-tests` target:
This target runs unit tests under the `${PWD}/.vim/tests` directory. To run the target:
```
make run-tests
```
## Accessing the commands
Open up a `vim` session and run:
```
:help VimTools
```
## Keeping the installation up to date
I suggest setting an alias for running `make` in a `.bashrc` or `.bash_aliases` file. Having a `Makefile` in `~` is ugly however. A great bypass for this is to rename the `Makefile` and put it somewhere away from plain sight then set up the alias as follows:
```
alias fetch_vimtools="make -f /path/to/MakeVimTools"
```
