# VimTools
This repository contains the `.vim` directory that I use in my day to day programming, both professionally and leisurely.
## Table of Contents
- [Setup](#setup)
- [Build targets](#build-targets)
  - [The `install` target](#the-install-target)
  - [The `run-tests` target](#the-run-tests-target)
- [Accessing the commands](#accessing-the-commands)
- [Keeping the installation up to date](#keeping-the-installation-up-to-date)
- [Testing with Docker](#testing-with-docker)
- [General code structure](#general-code-structure)
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
## Testing with Docker
I am testing this project with Docker. To run tests with Docker, first make sure that Docker is installed. Then run:
```
cd /path/to/VimTools
docker build -t vimtools .
```
This will generate a Debian based local Docker image. To actually test the product, run the `vimtools` image:
```
docker run -it --rm vimtools
```
This will test the `master` branch by default. To test a specific branch:
```
docker run -it -e GIT_BRANCH=<branch-name> --rm vimtools
```
## General code structure
Almost all scripts in this project follow the general layout:
```
function s:HelperFoo(<args>)
    ...
endfunction

function s:HelperBar(<args>)
    ...
endfunction

function s:HelperBaz(<args>)
    ...
endfunction

function s:MainFunction(<args>)
    call s:HelperFoo(...)
    call s:HelperBar(...)
    call s:HelperBaz(...)
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" A short description...
command -nargs=<nargs> CommandName :call s:MainFunction(...)
```
Moving from top to bottom, we have the following:
- **Helper functions**: In this case `s:Helper{Foo,Bar,Baz}`. These functions serve auxiliary roles
- **A main function**: In this case `s:MainFunction`. The main function retains its scope relative to the script and makes use of the helper functions
- **A vertical separator**: This separator delineates the interface between private and public scope
- **A short description**: This short description explains what action the consequent command performs
- **The command**: This line is the adapter between the main function and the global namespace
