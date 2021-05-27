VimTools
==================================================
This repository contains the ``.vim`` directory that I use in my day to day programming, both professionally and leisurely.
This is not a true ``vim`` plugin.

Table of Contents
--------------------------------------------------
.. contents::
    :depth: 2

Setting up VimTools
--------------------------------------------------
This project is both set up and tested using ``make``.

Install - quick and dirty
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
To install the project:

.. code-block:: shell

    curl https://raw.githubusercontent.com/dsw7/VimTools/master/Makefile > Makefile && make

The ``make (all)`` target simply downloads a ``.zip`` archive of this project, unpacks it into ``${PWD}/.vim`` and
runs unit tests on the installation. **Warning: this will remove existing an existing .vim directory!**

The ``install`` build target
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
A more fine-grained installation approach can (and should) be used. To install the software without running tests:

.. code-block:: shell

    curl https://raw.githubusercontent.com/dsw7/VimTools/master/Makefile > Makefile
    make install

To install a specific branch using the ``Makefile``:

.. code-block:: shell

    make install GIT_BRANCH=<branch-name>

The ``run-tests`` build target
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
To run just the unit tests:

.. code-block:: shell

    make run-tests

This feature is useful for local testing. This target runs unit tests under the ``${PWD}/.vim/tests`` directory.

Accessing the commands
--------------------------------------------------
Open up a ``vim`` session and run:

.. code-block::

    :help VimTools

Keeping the installation up to date
--------------------------------------------------
I suggest setting an alias for running ``make`` in a ``.bashrc`` or ``.bash_aliases`` file.
Having a ``Makefile`` in ``~`` is ugly however. A great bypass for this is to rename the
``Makefile`` and put it somewhere away from plain sight then set up the alias as follows:

.. code-block:: shell

    alias fetch_vimtools="make -f /path/to/MakeVimTools"

Testing with Docker
--------------------------------------------------
This project is tested with Docker. To run tests with Docker, first make sure that Docker is installed. Then run:

.. code-block:: shell

    cd /path/to/VimTools
    docker build -t vimtools .

This will generate a Debian based local Docker image. To actually test the product, run the ``vimtools`` image:

.. code-block:: shell

    docker run -it --rm vimtools

This will test the ``master`` branch by default. To test a specific branch:

.. code-block:: shell

    docker run -it -e GIT_BRANCH=<branch-name> --rm vimtools

General code structure
--------------------------------------------------
Almost all scripts in this project follow the general layout:

.. code-block::

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

Moving from top to bottom:

- **Helper functions**: In this case ``s:Helper{Foo,Bar,Baz}``. These functions serve auxiliary roles
- **A main function**: In this case ``s:MainFunction``. The main function retains its scope relative to the script and makes use of the helper functions
- **A vertical separator**: This separator delineates the interface between private and public scope
- **A short description**: This short description explains what action the consequent command performs
- **The command**: This line is the adapter between the main function and the global namespace
