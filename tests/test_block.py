import filecmp
from os import remove
from textwrap import dedent
from subprocess import call
from unittest import TestCase
from utils.consts import (
    FILENAME_ACTUAL,
    FILENAME_EXPECTED,
    FILENAME_AUXILIARY,
    TEMPORARY_COMMAND_FILE
)
from utils.primitives import (
    write_executable_command_file
)


class TestBlock(TestCase):
    def setUp(self):
        input_string = """\
        foo
        bar
        baz
        """
        with open(FILENAME_ACTUAL, 'w') as f:
            f.write(dedent(input_string))

        input_string = """\
        spam
        ham
        eggs
        """
        with open(FILENAME_AUXILIARY, 'w') as f:
            f.write(dedent(input_string))

    def tearDown(self):
        remove(FILENAME_ACTUAL)
        remove(FILENAME_EXPECTED)
        remove(FILENAME_AUXILIARY)
        remove(TEMPORARY_COMMAND_FILE)

    def test_block_1_3(self):
        expected_string = """\
        foo
        bar
        baz
        spam
        ham
        eggs

        """
        with open(FILENAME_EXPECTED, 'w') as f:
            f.write(dedent(expected_string))

        # Looks like cursor automatically placed at end of file

        command = f'vim -es -c ":Block {FILENAME_AUXILIARY} 1 3" -c "wq" {FILENAME_ACTUAL}'
        write_executable_command_file(command, TEMPORARY_COMMAND_FILE)

        call(TEMPORARY_COMMAND_FILE)
        self.assertTrue(
            filecmp.cmp(FILENAME_ACTUAL, FILENAME_EXPECTED)
        )

    def test_block_1_2(self):
        expected_string = """\
        foo
        bar
        baz
        spam
        ham

        """
        with open(FILENAME_EXPECTED, 'w') as f:
            f.write(dedent(expected_string))

        command = f'vim -es -c ":Block {FILENAME_AUXILIARY} 1 2" -c "wq" {FILENAME_ACTUAL}'
        write_executable_command_file(command, TEMPORARY_COMMAND_FILE)

        call(TEMPORARY_COMMAND_FILE)
        self.assertTrue(
            filecmp.cmp(FILENAME_ACTUAL, FILENAME_EXPECTED)
        )

    def test_block_2_3(self):
        expected_string = """\
        foo
        bar
        baz
        ham
        eggs

        """
        with open(FILENAME_EXPECTED, 'w') as f:
            f.write(dedent(expected_string))

        command = f'vim -es -c ":Block {FILENAME_AUXILIARY} 2 3" -c "wq" {FILENAME_ACTUAL}'
        write_executable_command_file(command, TEMPORARY_COMMAND_FILE)

        call(TEMPORARY_COMMAND_FILE)
        self.assertTrue(
            filecmp.cmp(FILENAME_ACTUAL, FILENAME_EXPECTED)
        )

    def test_block_invalid_range(self):
        expected_string = """\
        foo
        bar
        baz
        """
        with open(FILENAME_EXPECTED, 'w') as f:
            f.write(dedent(expected_string))

        # Ensure original file remains untouched...

        command = f'vim -es -c ":Block {FILENAME_AUXILIARY} 2 5" -c "wq" {FILENAME_ACTUAL}'
        write_executable_command_file(command, TEMPORARY_COMMAND_FILE)

        call(TEMPORARY_COMMAND_FILE)
        self.assertTrue(
            filecmp.cmp(FILENAME_ACTUAL, FILENAME_EXPECTED)
        )

    def test_block_invalid_file(self):
        expected_string = """\
        foo
        bar
        baz
        """
        with open(FILENAME_EXPECTED, 'w') as f:
            f.write(dedent(expected_string))

        # Ensure original file remains untouched...

        command = f'vim -es -c ":Block /tmp/f4tl2x.txt 1 2" -c "wq" {FILENAME_ACTUAL}'
        write_executable_command_file(command, TEMPORARY_COMMAND_FILE)

        call(TEMPORARY_COMMAND_FILE)
        self.assertTrue(
            filecmp.cmp(FILENAME_ACTUAL, FILENAME_EXPECTED)
        )
