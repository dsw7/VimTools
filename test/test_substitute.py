import filecmp
from os import path, remove, stat, chmod
from stat import S_IEXEC
from subprocess import call
from tempfile import gettempdir
from unittest import TestCase
from consts import (
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

    def test_sub_no_limits(self):
        with open(FILENAME_EXPECTED, 'w') as f:
            f.write('cat bar baz\ncat bar baz\ncat bar baz\n')

        command = f'vim -es -c "/foo" -c ":S cat" -c "wq" {FILENAME_ACTUAL}'
        self.write_executable_command_file(command)

        call(TEMPORARY_COMMAND_FILE)
        self.assertTrue(
            filecmp.cmp(FILENAME_ACTUAL, FILENAME_EXPECTED)
        )

    def test_sub_one_line(self):
        with open(FILENAME_EXPECTED, 'w') as f:
            f.write('foo bar baz\ncat bar baz\nfoo bar baz\n')

        command = f'vim -es -c "/foo" -c ":S cat 2" -c "wq" {FILENAME_ACTUAL}'
        self.write_executable_command_file(command)

        call(TEMPORARY_COMMAND_FILE)
        self.assertTrue(
            filecmp.cmp(FILENAME_ACTUAL, FILENAME_EXPECTED)
        )

    def test_sub_between_lines(self):
        with open(FILENAME_EXPECTED, 'w') as f:
            f.write('cat bar baz\ncat bar baz\nfoo bar baz\n')

        command = f'vim -es -c "/foo" -c ":S cat 1 2" -c "wq" {FILENAME_ACTUAL}'
        self.write_executable_command_file(command)

        call(TEMPORARY_COMMAND_FILE)
        self.assertTrue(
            filecmp.cmp(FILENAME_ACTUAL, FILENAME_EXPECTED)
        )

    def test_sub_or_condition(self):
        with open(FILENAME_EXPECTED, 'w') as f:
            f.write('cat bar cat\ncat bar cat\ncat bar cat\n')

        command = f'vim -es -c "/foo\|baz" -c ":S cat" -c "wq" {FILENAME_ACTUAL}'
        self.write_executable_command_file(command)

        call(TEMPORARY_COMMAND_FILE)
        self.assertTrue(
            filecmp.cmp(FILENAME_ACTUAL, FILENAME_EXPECTED)
        )

    def test_sub_and_condition(self):
        with open(FILENAME_EXPECTED, 'w') as f:
            f.write('cat\ncat\ncat\n')

        command = f'vim -es -c "/foo.*baz" -c ":S cat" -c "wq" {FILENAME_ACTUAL}'
        self.write_executable_command_file(command)

        call(TEMPORARY_COMMAND_FILE)
        self.assertTrue(
            filecmp.cmp(FILENAME_ACTUAL, FILENAME_EXPECTED)
        )
