from helpers import VimToolsTestCase


class TestInd(VimToolsTestCase):

    def setUp(self):
        self.input_str = """\
        foo bar baz
        foo bar baz
        foo bar baz
        """

    def test_ind(self):
        self.expected_str = """\
            foo bar baz
            foo bar baz
        foo bar baz
        """
        self.commands = [":Ind 1 2"]
        self.assert_files_equal()

    def test_ind_multiple_tabs(self):
        self.expected_str = """\
                    foo bar baz
                    foo bar baz
        foo bar baz
        """
        self.commands = [":Ind 1 2 3"]
        self.assert_files_equal()
