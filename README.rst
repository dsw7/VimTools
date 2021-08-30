VimTools
==================================================
This repository contains the ``.vim`` directory that I use in my day to day programming, both professionally and leisurely.
This is not a true ``vim`` plugin.

.. contents:: **Table of Contents:**
    :depth: 2

Setting up VimTools
--------------------------------------------------
This project is both set up and tested using ``make``.

Install - quick and dirty
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
To install the project:

.. code-block:: bash

    curl https://raw.githubusercontent.com/dsw7/VimTools/master/Makefile > Makefile && make

The default ``make`` target simply downloads a ``.zip`` archive of this project, unpacks the archive, then moves
the following files/directories to the following destinations:

.. code-block::

    /path/to/VimTools-master/plugin/vimtools/* -> ${HOME}/.vim/plugin/vimtools/
    /path/to/VimTools-master/doc/vimtools.txt  -> ${HOME}/.vim/doc/

The target then runs unit tests on the installation.

The ``setup`` build target
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
A more fine-grained installation approach can (and should) be used. To install the software without running tests:

.. code-block:: bash

    make install

To install a specific branch using the ``Makefile``:

.. code-block:: bash

    make GIT_BRANCH=<branch-name> install

The ``test`` build target
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
To run just the unit tests:

.. code-block:: bash

    make test

This feature is useful for local testing. This target runs unit tests under the ``${HOME}/.vim/plugin/vimtools/tests`` directory.

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

.. code-block:: bash

    alias fetch_vimtools="make -f /path/to/MakeVimTools"

Testing with Docker
--------------------------------------------------
This project is tested with Docker. To run tests with Docker, first make sure that Docker is installed. then ``git clone`` the project:

.. code-block:: bash

    git clone https://github.com/dsw7/VimTools.git

Change directories into the ``VimTools`` directory and run the following ``make`` target:

.. code-block:: bash

    make dockertest

This will test the ``master`` branch by default. To test a specific branch:

.. code-block:: bash

    make GIT_BRANCH=<branch-name> dockertest

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
