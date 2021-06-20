from helpers import VimToolsTestCase


class TestSubTwoDigitRanges(VimToolsTestCase):

    def setUp(self):
        self.input_string = """\
        foo bar baz
        foo bar baz
        foo bar baz
        foo bar baz
        foo bar baz
        foo bar baz
        foo bar baz
        foo bar baz
        foo bar baz
        foo bar baz
        foo bar baz
        foo bar baz
        foo bar baz
        foo bar baz
        foo bar baz
        foo bar baz
        foo bar baz
        foo bar baz
        foo bar baz
        foo bar baz
        """

    def test_sub_one_line(self):
        expected_string = """\
        foo bar baz
        foo bar baz
        foo bar baz
        foo bar baz
        foo bar baz
        foo bar baz
        foo bar baz
        foo bar baz
        foo bar baz
        foo bar baz
        foo bar baz
        foo bar baz
        foo bar baz
        foo bar baz
        cat bar baz
        foo bar baz
        foo bar baz
        foo bar baz
        foo bar baz
        foo bar baz
        """
        command = ["/foo", ":S cat 15"]
        self.assert_files_equal(command, self.input_string, expected_string)

    def test_sub_between_lines(self):
        expected_string = """\
        foo bar baz
        foo bar baz
        foo bar baz
        foo bar baz
        foo bar baz
        foo bar baz
        foo bar baz
        foo bar baz
        foo bar baz
        foo bar baz
        foo bar baz
        foo bar baz
        foo bar baz
        foo bar baz
        foo bar baz
        cat bar baz
        cat bar baz
        cat bar baz
        cat bar baz
        cat bar baz
        """
        command = ["/foo", ":S cat 16 20"]
        self.assert_files_equal(command, self.input_string, expected_string)

    def test_sub_from_start_to_specific_line(self):
        expected_string = """\
        cat bar baz
        cat bar baz
        cat bar baz
        cat bar baz
        cat bar baz
        cat bar baz
        cat bar baz
        cat bar baz
        cat bar baz
        cat bar baz
        foo bar baz
        foo bar baz
        foo bar baz
        foo bar baz
        foo bar baz
        foo bar baz
        foo bar baz
        foo bar baz
        foo bar baz
        foo bar baz
        """
        command = ["/foo", ":S cat :10"]
        self.assert_files_equal(command, self.input_string, expected_string)

    def test_sub_from_specific_line_to_end_of_file(self):
        expected_string = """\
        foo bar baz
        foo bar baz
        foo bar baz
        foo bar baz
        foo bar baz
        foo bar baz
        foo bar baz
        foo bar baz
        foo bar baz
        cat bar baz
        cat bar baz
        cat bar baz
        cat bar baz
        cat bar baz
        cat bar baz
        cat bar baz
        cat bar baz
        cat bar baz
        cat bar baz
        cat bar baz
        """
        command = ["/foo", ":S cat 10:"]
        self.assert_files_equal(command, self.input_string, expected_string)
