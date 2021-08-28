from os import remove
from textwrap import dedent
from helpers import VimToolsTestCase, FILENAME_AUXILIARY


class TestBlock(VimToolsTestCase):

    def setUp(self):
        self.input_string = """\
        foo
        bar
        baz
        """

        auxiliary_input_string = """\
        spam
        ham
        eggs
        """
        with open(FILENAME_AUXILIARY, 'w') as f:
            f.write(dedent(auxiliary_input_string))

    def tearDown(self):
        remove(FILENAME_AUXILIARY)

    def test_block_1_3(self):
        expected_string = """\
        foo
        bar
        baz
        spam
        ham
        eggs

        """
        # Looks like cursor automatically placed at end of file
        command = [":Block {} 1 3".format(FILENAME_AUXILIARY)]
        self.assert_files_equal(command, self.input_string, expected_string)

    def test_block_1_2(self):
        expected_string = """\
        foo
        bar
        baz
        spam
        ham

        """
        command = [":Block {} 1 2".format(FILENAME_AUXILIARY)]
        self.assert_files_equal(command, self.input_string, expected_string)

    def test_block_2_3(self):
        expected_string = """\
        foo
        bar
        baz
        ham
        eggs

        """
        command = [":Block {} 2 3".format(FILENAME_AUXILIARY)]
        self.assert_files_equal(command, self.input_string, expected_string)

    def test_block_invalid_range(self):
        expected_string = """\
        foo
        bar
        baz
        """
        # Ensure original file remains untouched...
        command = [":Block {} 2 5".format(FILENAME_AUXILIARY)]
        self.assert_files_equal(command, self.input_string, expected_string)

    def test_block_invalid_file(self):
        expected_string = """\
        foo
        bar
        baz
        """
        # Ensure original file remains untouched...
        command = [":Block {} 1 2".format('/tmp/f4tl2x.txt')]
        self.assert_files_equal(command, self.input_string, expected_string)
