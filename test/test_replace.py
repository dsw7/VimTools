import filecmp
from os import path, remove, stat, chmod
from stat import S_IEXEC
from subprocess import call
from tempfile import gettempdir
from unittest import TestCase


class TestSubCommand(TestCase):
    def setUp(self):
        self.filename_actual = path.join(gettempdir(), 'vimtools_test_actual')
        self.filename_expected = path.join(gettempdir(), 'vimtools_test_expected')
        self.temporary_command_file = path.join(gettempdir(), 'vim_command')

        with open(self.filename_actual, 'w') as f:
            f.write('foo bar baz\nfoo bar baz\nfoo bar baz\n')

    def tearDown(self):
        remove(self.filename_actual)
        remove(self.filename_expected)
        remove(self.temporary_command_file)

    def write_executable_command_file(self, command):
        with open(self.temporary_command_file, 'w') as f:
            f.write(f'#!/bin/sh\n{command}')

        status_fd = stat(self.temporary_command_file)
        chmod(self.temporary_command_file, status_fd.st_mode | S_IEXEC)

    def test_sub_no_limits(self):
        with open(self.filename_expected, 'w') as f:
            f.write('cat bar baz\ncat bar baz\ncat bar baz\n')

        command = f'vim -es -c "/foo" -c ":S cat" -c "wq" {self.filename_actual}'
        self.write_executable_command_file(command)

        call(self.temporary_command_file)
        self.assertTrue(
            filecmp.cmp(self.filename_actual, self.filename_expected)
        )

    def test_sub_one_line(self):
        with open(self.filename_expected, 'w') as f:
            f.write('foo bar baz\ncat bar baz\nfoo bar baz\n')

        command = f'vim -es -c "/foo" -c ":S cat 2" -c "wq" {self.filename_actual}'
        self.write_executable_command_file(command)

        call(self.temporary_command_file)
        self.assertTrue(
            filecmp.cmp(self.filename_actual, self.filename_expected)
        )

    def test_sub_between_lines(self):
        with open(self.filename_expected, 'w') as f:
            f.write('cat bar baz\ncat bar baz\nfoo bar baz\n')

        command = f'vim -es -c "/foo" -c ":S cat 1 2" -c "wq" {self.filename_actual}'
        self.write_executable_command_file(command)

        call(self.temporary_command_file)
        self.assertTrue(
            filecmp.cmp(self.filename_actual, self.filename_expected)
        )

    def test_sub_or_condition(self):
        with open(self.filename_expected, 'w') as f:
            f.write('cat bar cat\ncat bar cat\ncat bar cat\n')

        command = f'vim -es -c "/foo\|baz" -c ":S cat" -c "wq" {self.filename_actual}'
        self.write_executable_command_file(command)

        call(self.temporary_command_file)
        self.assertTrue(
            filecmp.cmp(self.filename_actual, self.filename_expected)
        )

    def test_sub_and_condition(self):
        with open(self.filename_expected, 'w') as f:
            f.write('cat\ncat\ncat\n')

        command = f'vim -es -c "/foo.*baz" -c ":S cat" -c "wq" {self.filename_actual}'
        self.write_executable_command_file(command)

        call(self.temporary_command_file)
        self.assertTrue(
            filecmp.cmp(self.filename_actual, self.filename_expected)
        )
