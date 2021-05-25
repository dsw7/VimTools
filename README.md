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
Almost all scripts in the project follow a simple template:
```vimscript
function s:IndentBySingleTab(start_line, end_line)
    execute a:start_line . ',' . a:end_line . 's/^/    /g'
endfunction

function s:IndentByMultipleTabs(start_line, end_line, count)
    let l:tabs = repeat('    ', str2nr(a:count))
    execute a:start_line . ',' . a:end_line . 's/^/' . l:tabs . '/g'
endfunction

function s:Indent(start_line, end_line, ...)
    if a:0 == 0
        call s:IndentBySingleTab(a:start_line, a:end_line)
    elseif a:0 == 1
        call s:IndentByMultipleTabs(a:start_line, a:end_line, a:1)
    else
        echoerr 'Function takes only one additional argument'
    endif
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Indent by 4 spaces
command -nargs=+ Ind :call s:Indent(<f-args>)
```
