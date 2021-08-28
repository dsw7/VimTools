from helpers import VimToolsTestCase


class TestSub(VimToolsTestCase):

    def setUp(self):
        self.input_string = """\
        foo bar baz
        foo bar baz
        foo bar baz
        """

    def test_sub_no_limits(self):
        expected_string = """\
        cat bar baz
        cat bar baz
        cat bar baz
        """
        command = ["/foo", ":S cat"]
        self.assert_files_equal(command, self.input_string, expected_string)

    def test_sub_one_line(self):
        expected_string = """\
        foo bar baz
        cat bar baz
        foo bar baz
        """
        command = ["/foo", ":S cat 2"]
        self.assert_files_equal(command, self.input_string, expected_string)

    def test_sub_between_lines(self):
        expected_string = """\
        cat bar baz
        cat bar baz
        foo bar baz
        """
        command = ["/foo", ":S cat 1 2"]
        self.assert_files_equal(command, self.input_string, expected_string)

    def test_sub_or_condition(self):
        expected_string = """\
        cat bar cat
        cat bar cat
        cat bar cat
        """
        command = [r"/foo\|baz", ":S cat"]
        self.assert_files_equal(command, self.input_string, expected_string)

    def test_sub_and_condition(self):
        expected_string = """\
        cat
        cat
        cat
        """
        command = [r"/foo.*baz", ":S cat"]
        self.assert_files_equal(command, self.input_string, expected_string)
