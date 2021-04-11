import filecmp
from os import remove
from textwrap import dedent
from subprocess import call
from unittest import TestCase
from utils.consts import (
    FILENAME_ACTUAL,
    FILENAME_EXPECTED,
    TEMPORARY_COMMAND_FILE
)
from utils.primitives import (
    write_executable_command_file
)


class TestWs(TestCase):
    def setUp(self):
        input_string = [
            'Lorem  ',
            'ipsum  ',
            'dolor  ',
            'sit    ',
            'amet...'
        ]
        with open(FILENAME_ACTUAL, 'w') as f:
            f.write('\n'.join(input_string))

    def tearDown(self):
        remove(FILENAME_ACTUAL)
        remove(FILENAME_EXPECTED)
        remove(TEMPORARY_COMMAND_FILE)

    def test_remove_whitespace(self):
        expected_string = """\
        Lorem
        ipsum
        dolor
        sit
        amet...
        """
        with open(FILENAME_EXPECTED, 'w') as f:
            f.write(dedent(expected_string))

        command = f'vim -es -c ":Ws" -c "wq" {FILENAME_ACTUAL}'
        write_executable_command_file(command, TEMPORARY_COMMAND_FILE)

        call(TEMPORARY_COMMAND_FILE)
        self.assertTrue(
            filecmp.cmp(FILENAME_ACTUAL, FILENAME_EXPECTED)
        )

    def test_skip_whitespace_command_if_no_whitespace(self):
        expected_string = """\
        Lorem
        ipsum
        dolor
        sit
        amet...
        """
        with open(FILENAME_EXPECTED, 'w') as f:
            f.write(dedent(expected_string))

        command = f'vim -es -c ":Ws" -c "wq" {FILENAME_ACTUAL}'
        write_executable_command_file(command, TEMPORARY_COMMAND_FILE)

        # the second call will attempt to strip whitespace from file where none exists
        call(TEMPORARY_COMMAND_FILE)
        call(TEMPORARY_COMMAND_FILE)

        self.assertTrue(
            filecmp.cmp(FILENAME_ACTUAL, FILENAME_EXPECTED)
        )
