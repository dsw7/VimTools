from helpers import VimToolsTestCase


class TestInd(VimToolsTestCase):

    def setUp(self):
        self.input_string = """\
        foo bar baz
        foo bar baz
        foo bar baz
        """

    def test_ind(self):
        expected_string = """\
            foo bar baz
            foo bar baz
        foo bar baz
        """
        command = [":Ind 1 2"]
        self.assert_files_equal(command, self.input_string, expected_string)

    def test_ind_multiple_tabs(self):
        expected_string = """\
                    foo bar baz
                    foo bar baz
        foo bar baz
        """
        command = [":Ind 1 2 3"]
        self.assert_files_equal(command, self.input_string, expected_string)
