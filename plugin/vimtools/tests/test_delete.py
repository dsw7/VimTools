from helpers import VimToolsTestCase


class TestDel(VimToolsTestCase):

    def setUp(self):
        self.input_str = """\
        foo bar 1
        foo bar 2
        foo bar 3
        """

    def test_del(self):
        self.expected_str = """\
        foo bar 3
        """
        self.commands = [":Del 1 2"]
        self.assert_files_equal()
