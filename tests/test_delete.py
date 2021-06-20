from helpers import VimToolsTestCase


class TestDel(VimToolsTestCase):

    def setUp(self):
        self.input_string = """\
        foo bar 1
        foo bar 2
        foo bar 3
        """

    def test_del(self):
        expected_string = """\
        foo bar 3
        """
        command = [":Del 1 2"]
        self.assert_files_equal(command, self.input_string, expected_string)
