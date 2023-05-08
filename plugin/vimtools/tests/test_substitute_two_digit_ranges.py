from helpers import VimToolsTestCase


class TestSubTwoDigitRanges(VimToolsTestCase):

    def setUp(self):
        self.input_str = """\
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
        self.expected_str = """\
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
        self.commands = ["/foo", ":S cat 15"]
        self.assert_files_equal()

    def test_sub_between_lines(self):
        self.expected_str = """\
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
        self.commands = ["/foo", ":S cat 16 20"]
        self.assert_files_equal()

    def test_sub_from_start_to_specific_line(self):
        self.expected_str = """\
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
        self.commands = ["/foo", ":S cat :10"]
        self.assert_files_equal()

    def test_sub_from_specific_line_to_end_of_file(self):
        self.expected_str = """\
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
        self.commands = ["/foo", ":S cat 10:"]
        self.assert_files_equal()
