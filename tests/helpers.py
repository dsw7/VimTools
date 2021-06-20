# pylint: disable=W0201 # Disable "Attribute defined outside __init__"

from filecmp import cmp
from textwrap import dedent
from subprocess import call
from unittest import TestCase
from stat import S_IEXEC
from tempfile import gettempdir
from contextlib import contextmanager
from os import (
    remove,
    stat,
    chmod,
    path
)

FILENAME_ACTUAL = path.join(gettempdir(), 'vimtools_test_actual')
FILENAME_EXPECTED = path.join(gettempdir(), 'vimtools_test_expected')
FILENAME_AUXILIARY = path.join(gettempdir(), 'vimtools_test_auxiliary')
TEMPORARY_COMMAND_FILE = path.join(gettempdir(), 'vimtools_command_file')


class VimToolsTestCase(TestCase):

    def write_executable_command_file(self) -> None:
        vim_command = '#!/bin/sh\nvim -es '
        for command in self.commands:
            vim_command += '-c "{}" '.format(command)

        vim_command += '-c "wq" {}'.format(FILENAME_ACTUAL)
        with open(TEMPORARY_COMMAND_FILE, 'w') as f:
            f.write(vim_command)

        status_fd = stat(TEMPORARY_COMMAND_FILE)
        chmod(TEMPORARY_COMMAND_FILE, status_fd.st_mode | S_IEXEC)

    def write_actual_contents_to_file(self) -> None:
        with open(FILENAME_ACTUAL, 'w') as f:
            f.write(dedent(self.input_contents))

    def write_expected_contents_to_file(self) -> None:
        with open(FILENAME_EXPECTED, 'w') as f:
            f.write(dedent(self.expected_contents))

    @contextmanager
    def context_file(self, *args, **kwargs) -> None:
        self.write_executable_command_file()
        self.write_actual_contents_to_file()
        self.write_expected_contents_to_file()

        try:
            call(TEMPORARY_COMMAND_FILE)
            yield None

        finally:
            remove(FILENAME_ACTUAL)
            remove(FILENAME_EXPECTED)
            remove(TEMPORARY_COMMAND_FILE)

    def assert_files_equal(self, commands: list, input_contents: str, expected_contents: str) -> None:
        self.commands = commands
        self.input_contents = input_contents
        self.expected_contents = expected_contents

        with self.context_file():
            self.assertTrue(cmp(FILENAME_ACTUAL, FILENAME_EXPECTED))

    def assert_files_not_equal(self, commands: list, input_contents: str, expected_contents: str) -> None:
        self.commands = commands
        self.input_contents = input_contents
        self.expected_contents = expected_contents

        with self.context_file():
            self.assertFalse(cmp(FILENAME_ACTUAL, FILENAME_EXPECTED))
