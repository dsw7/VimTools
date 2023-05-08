# pylint: disable=W0201 # Disable "Attribute defined outside __init__"

from contextlib import contextmanager
from filecmp import cmp
from pathlib import Path
from stat import S_IEXEC
from subprocess import call
from tempfile import gettempdir
from textwrap import dedent
from typing import List
from unittest import TestCase


class VimToolsTestCase(TestCase):

    filename_actual = Path(gettempdir(), 'vimtools_test_actual')
    filename_expected = Path(gettempdir(), 'vimtools_test_expected')
    command_file = Path(gettempdir(), 'vimtools_command_file')

    def write_executable_command_file(self) -> None:
        vim_command = '#!/bin/sh\nvim -es '
        for command in self.commands:
            vim_command += f'-c "{command}" '

        vim_command += f'-c "wq" {self.filename_actual}'

        self.command_file.write_text(vim_command)
        self.command_file.chmod(self.command_file.stat().st_mode | S_IEXEC)

    def write_actual_contents_to_file(self) -> None:
        self.filename_actual.write_text(dedent(self.input_contents))

    def write_expected_contents_to_file(self) -> None:
        self.filename_expected.write_text(dedent(self.expected_contents))

    @contextmanager
    def context_file(self, *args, **kwargs) -> None:
        self.write_executable_command_file()
        self.write_actual_contents_to_file()
        self.write_expected_contents_to_file()

        try:
            call(self.command_file)
            yield None

        finally:
            self.filename_actual.unlink()
            self.filename_expected.unlink()
            self.command_file.unlink()

    def assert_files_equal(self, commands: List[str], input_contents: str, expected_contents: str) -> None:
        self.commands = commands
        self.input_contents = input_contents
        self.expected_contents = expected_contents

        with self.context_file():
            self.assertTrue(cmp(self.filename_actual, self.filename_expected))

    def assert_files_not_equal(self, commands: List[str], input_contents: str, expected_contents: str) -> None:
        self.commands = commands
        self.input_contents = input_contents
        self.expected_contents = expected_contents

        with self.context_file():
            self.assertFalse(cmp(self.filename_actual, self.filename_expected))
