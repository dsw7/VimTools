from helpers import VimToolsTestCase


class TestMv(VimToolsTestCase):

    def setUp(self):
        self.input_string = """\
        namespace foo {
            void bar() {
                std::cout << "A foo that bars!" << std::endl;
                std::cout << "What does that even mean?" << std::endl;
            }
        }

        """
        # needs to be a newline after the } such that
        # :Mv command drag line 6 (and preceding contents)
        # to line 7

    def test_move(self):
        expected_string = """\

        namespace foo {
            void bar() {
                std::cout << "A foo that bars!" << std::endl;
                std::cout << "What does that even mean?" << std::endl;
            }
        }
        """
        command = [':Mv 1 6 7']
        self.assert_files_equal(command, self.input_string, expected_string)
