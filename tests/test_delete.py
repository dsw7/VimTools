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


class TestDel(TestCase):
    def setUp(self):
        input_string = """\
        foo bar 1 
        foo bar 2 
        foo bar 3 
        """

        with open(FILENAME_ACTUAL, 'w') as f:
            f.write(dedent(input_string))

    def tearDown(self):
        remove(FILENAME_ACTUAL)
        remove(FILENAME_EXPECTED)
        remove(TEMPORARY_COMMAND_FILE)

    def test_del(self):
        expected_string = """\
        foo bar 3
        """
        with open(FILENAME_EXPECTED, 'w') as f:
            f.write(expected_string)

        command = f'vim -es -c ":Del 1 2" -c "wq" {FILENAME_ACTUAL}'
        write_executable_command_file(command, TEMPORARY_COMMAND_FILE)

        call(TEMPORARY_COMMAND_FILE)
        self.assertFalse(
            filecmp.cmp(FILENAME_ACTUAL, FILENAME_EXPECTED)
        )
