from helpers import VimToolsTestCase


class TestWl(VimToolsTestCase):

    def setUp(self):
        self.input_string = """\
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
        expected_string = """\
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
        command = [":Wl 1 5"]
        self.assert_files_equal(command, self.input_string, expected_string)

    def test_remove_whitelines_two_digit_range(self):
        # This test ensures that a range 6 - 10 is not coerced to a range
        # 6 - 1 by Vimscript

        expected_string = """\
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
        command = [":Wl 6 10"]
        self.assert_files_equal(command, self.input_string, expected_string)

    def test_remove_whitelines_two_digit_range_backwards_range(self):
        expected_string = """\
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
        command = [":Wl 10 6"]
        self.assert_files_equal(command, self.input_string, expected_string)
