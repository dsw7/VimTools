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


class TestIns(TestCase):
    def setUp(self):
        input_string = """\
        foo bar baz
        foo bar baz
        foo bar baz
        """

        with open(FILENAME_ACTUAL, 'w') as f:
            f.write(dedent(input_string))

    def tearDown(self):
        remove(FILENAME_ACTUAL)
        remove(FILENAME_EXPECTED)
        remove(TEMPORARY_COMMAND_FILE)

    def test_comment_out_python(self):
        expected_string = """\
        #foo bar baz
        #foo bar baz
        foo bar baz
        """
        with open(FILENAME_EXPECTED, 'w') as f:
            f.write(dedent(expected_string))

        command = f'vim -es -c ":Ins # 1 2" -c "wq" {FILENAME_ACTUAL}'
        write_executable_command_file(command, TEMPORARY_COMMAND_FILE)

        call(TEMPORARY_COMMAND_FILE)
        self.assertTrue(
            filecmp.cmp(FILENAME_ACTUAL, FILENAME_EXPECTED)
        )

    def test_comment_out_cpp(self):
        expected_string = """\
        foo bar baz
        //foo bar baz
        //foo bar baz
        """
        with open(FILENAME_EXPECTED, 'w') as f:
            f.write(dedent(expected_string))

        command = f'vim -es -c ":Ins \/\/ 2 3" -c "wq" {FILENAME_ACTUAL}'
        write_executable_command_file(command, TEMPORARY_COMMAND_FILE)

        call(TEMPORARY_COMMAND_FILE)
        self.assertTrue(
            filecmp.cmp(FILENAME_ACTUAL, FILENAME_EXPECTED)
        )
