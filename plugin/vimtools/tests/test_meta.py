from helpers import VimToolsTestCase


class TestMeta(VimToolsTestCase):

    def setUp(self):
        self.input_string = """\
        foo bar baz
        foo bar baz
        foo bar baz
        """

    def test_false(self):
        expected_string = """\
        foo bar baz
        foo bar baz
        foo bar baz
        """
        command = ["/foo", ":S cat"]
        self.assert_files_not_equal(command, self.input_string, expected_string)

    def test_true(self):
        expected_string = """\
        cat bar baz
        cat bar baz
        cat bar baz
        """
        command = ["/foo", ":S cat"]
        self.assert_files_equal(command, self.input_string, expected_string)

    def test_false_indents(self):
        expected_string = """\
        cat bar baz
        cat bar baz
            cat bar baz
        """
        command = ["/foo", ":S cat"]
        self.assert_files_not_equal(command, self.input_string, expected_string)
