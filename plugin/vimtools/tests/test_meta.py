from helpers import VimToolsTestCase


class TestMeta(VimToolsTestCase):

    def setUp(self):
        self.input_str = """\
        foo bar baz
        foo bar baz
        foo bar baz
        """

    def test_false(self):
        self.expected_str = """\
        foo bar baz
        foo bar baz
        foo bar baz
        """
        self.commands = ["/foo", ":S cat"]
        self.assert_files_not_equal()

    def test_true(self):
        self.expected_str = """\
        cat bar baz
        cat bar baz
        cat bar baz
        """
        self.commands = ["/foo", ":S cat"]
        self.assert_files_equal()

    def test_false_indents(self):
        self.expected_str = """\
        cat bar baz
        cat bar baz
            cat bar baz
        """
        self.commands = ["/foo", ":S cat"]
        self.assert_files_not_equal()
