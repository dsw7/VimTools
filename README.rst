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

The ``make (all)`` target simply downloads a ``.zip`` archive of this project, unpacks it into ``${PWD}/.vim`` and runs unit tests on the installation.
**Warning: this will remove existing an existing .vim directory!**

The ``install`` build target
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
A more fine-grained installation approach can (and should) be used. To install the software without running tests:

.. code-block:: shell

    curl https://raw.githubusercontent.com/dsw7/VimTools/master/Makefile > Makefile
    make install

To install a specific branch using the ``Makefile``:

.. code-block:: shell

    curl https://raw.githubusercontent.com/dsw7/VimTools/master/Makefile > Makefile
    make install GIT_BRANCH=<branch-name>

The ``run-tests`` build target
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
To run just the unit tests:

.. code-block:: shell

    make run-tests

This feature is useful for local testing. This target runs unit tests under the ``${PWD}/.vim/tests`` directory.
