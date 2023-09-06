from helpers import VimToolsTestCase


class TestWs(VimToolsTestCase):
    def setUp(self):
        self.input_str = "\n".join(
            ["Lorem  ", "ipsum  ", "dolor  ", "sit    ", "amet..."]
        )

    def test_remove_whitespace(self):
        self.expected_str = """\
        Lorem
        ipsum
        dolor
        sit
        amet...
        """
        self.commands = [":Ws"]
        self.assert_files_equal()
