from helpers import VimToolsTestCase


class TestWl(VimToolsTestCase):

    def setUp(self):
        self.input_str = """\
        Lorem
          ipsum
            dolor
              sit
                amet...
        Lorem
          ipsum
            dolor
              sit
                amet...
        """

    def test_remove_whitelines(self):
        self.expected_str = """\
        Lorem
        ipsum
        dolor
        sit
        amet...
        Lorem
          ipsum
            dolor
              sit
                amet...
        """
        self.commands = [":Wl 1 5"]
        self.assert_files_equal()

    def test_remove_whitelines_two_digit_range(self):
        # This test ensures that a range 6 - 10 is not coerced to a range
        # 6 - 1 by Vimscript

        self.expected_str = """\
        Lorem
          ipsum
            dolor
              sit
                amet...
        Lorem
        ipsum
        dolor
        sit
        amet...
        """
        self.commands = [":Wl 6 10"]
        self.assert_files_equal()

    def test_remove_whitelines_two_digit_range_backwards_range(self):
        self.expected_str = """\
        Lorem
          ipsum
            dolor
              sit
                amet...
        Lorem
          ipsum
            dolor
              sit
                amet...
        """
        self.commands = [":Wl 10 6"]
        self.assert_files_equal()
