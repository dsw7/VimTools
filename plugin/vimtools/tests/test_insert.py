from helpers import VimToolsTestCase


class TestIns(VimToolsTestCase):

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
        """

    def test_comment_out_python(self):
        self.expected_str = """\
        #foo bar baz
        #foo bar baz
        foo bar baz
        foo bar baz
        foo bar baz
        foo bar baz
        foo bar baz
        foo bar baz
        foo bar baz
        foo bar baz
        """
        self.commands = [":Ins # 1 2"]
        self.assert_files_equal()

    def test_comment_out_python_two_digit_range(self):
        self.expected_str = """\
        foo bar baz
        foo bar baz
        foo bar baz
        foo bar baz
        foo bar baz
        #foo bar baz
        #foo bar baz
        #foo bar baz
        #foo bar baz
        #foo bar baz
        """
        self.commands = [":Ins # 6 10"]
        self.assert_files_equal()

    def test_comment_out_cpp(self):
        self.expected_str = """\
        foo bar baz
        //foo bar baz
        //foo bar baz
        foo bar baz
        foo bar baz
        foo bar baz
        foo bar baz
        foo bar baz
        foo bar baz
        foo bar baz
        """
        self.commands = [r":Ins \/\/ 2 3"]
        self.assert_files_equal()
