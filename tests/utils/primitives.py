from os import stat, chmod
from stat import S_IEXEC

def write_executable_command_file(command, filename):
    with open(filename, 'w') as f:
        f.write(f'#!/bin/sh\n{command}')

    status_fd = stat(filename)
    chmod(filename, status_fd.st_mode | S_IEXEC)
