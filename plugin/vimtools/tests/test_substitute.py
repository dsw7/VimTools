from helpers import VimToolsTestCase


class TestSub(VimToolsTestCase):

    def setUp(self):
        self.input_str = """\
        foo bar baz
        foo bar baz
        foo bar baz
        """

    def test_sub_no_limits(self):
        self.expected_str = """\
        cat bar baz
        cat bar baz
        cat bar baz
        """
        self.commands = ["/foo", ":S cat"]
        self.assert_files_equal()

    def test_sub_one_line(self):
        self.expected_str = """\
        foo bar baz
        cat bar baz
        foo bar baz
        """
        self.commands = ["/foo", ":S cat 2"]
        self.assert_files_equal()

    def test_sub_between_lines(self):
        self.expected_str = """\
        cat bar baz
        cat bar baz
        foo bar baz
        """
        self.commands = ["/foo", ":S cat 1 2"]
        self.assert_files_equal()

    def test_sub_or_condition(self):
        self.expected_str = """\
        cat bar cat
        cat bar cat
        cat bar cat
        """
        self.commands = [r"/foo\|baz", ":S cat"]
        self.assert_files_equal()

    def test_sub_and_condition(self):
        self.expected_str = """\
        cat
        cat
        cat
        """
        self.commands = [r"/foo.*baz", ":S cat"]
        self.assert_files_equal()
