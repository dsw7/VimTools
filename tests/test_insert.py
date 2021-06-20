from helpers import VimToolsTestCase


class TestIns(VimToolsTestCase):

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
        """

    def test_comment_out_python(self):
        expected_string = """\
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
        command = [":Ins # 1 2"]
        self.assert_files_equal(command, self.input_string, expected_string)

    def test_comment_out_python_two_digit_range(self):
        expected_string = """\
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
        command = [":Ins # 6 10"]
        self.assert_files_equal(command, self.input_string, expected_string)

    def test_comment_out_cpp(self):
        expected_string = """\
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
        command = [r":Ins \/\/ 2 3"]
        self.assert_files_equal(command, self.input_string, expected_string)
