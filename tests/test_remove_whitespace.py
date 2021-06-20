from helpers import VimToolsTestCase


class TestWs(VimToolsTestCase):

    def setUp(self):
        self.input_string = '\n'.join([
            'Lorem  ',
            'ipsum  ',
            'dolor  ',
            'sit    ',
            'amet...'
        ])

    def test_remove_whitespace(self):
        expected_string = """\
        Lorem
        ipsum
        dolor
        sit
        amet...
        """
        command = [":Ws"]
        self.assert_files_equal(command, self.input_string, expected_string)
