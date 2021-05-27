VimTools
========
This repository contains the ``.vim`` directory that I use in my day to day programming, both professionally and leisurely. This is not a true ``vim`` plugin.

Table of contents
-----------------
.. contents:: _
    :depth: 2

Setting up VimTools
-------------------
This project is both set up and tested using ``make``. To install the project:

.. code-block:: shell

    curl https://raw.githubusercontent.com/dsw7/VimTools/master/Makefile > Makefile && make

The ``make (all)`` target simply downloads a ``.zip`` archive of this project, unpacks it into ``${PWD}/.vim`` and runs unit tests on the installation. **Warning: this will remove existing an existing .vim directory!**
