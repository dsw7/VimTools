import filecmp
from os import remove, stat, chmod
from stat import S_IEXEC
from subprocess import call
from unittest import TestCase
from utils.consts import (
    FILENAME_ACTUAL,
    FILENAME_EXPECTED,
    TEMPORARY_COMMAND_FILE
)


class TestSubCommand(TestCase):
    def setUp(self):
        with open(FILENAME_ACTUAL, 'w') as f:
            f.write('foo bar baz\nfoo bar baz\nfoo bar baz\n')

    def tearDown(self):
        remove(FILENAME_ACTUAL)
        remove(FILENAME_EXPECTED)
        remove(TEMPORARY_COMMAND_FILE)

    def write_executable_command_file(self, command):
        with open(TEMPORARY_COMMAND_FILE, 'w') as f:
            f.write(f'#!/bin/sh\n{command}')

        status_fd = stat(TEMPORARY_COMMAND_FILE)
        chmod(TEMPORARY_COMMAND_FILE, status_fd.st_mode | S_IEXEC)
