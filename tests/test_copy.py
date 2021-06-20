from helpers import VimToolsTestCase


class TestCp(VimToolsTestCase):

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
        # :Cp command can write to line 7

    def test_copy(self):
        expected_string = """\
        namespace foo {
            void bar() {
                std::cout << "A foo that bars!" << std::endl;
                std::cout << "What does that even mean?" << std::endl;
            }
        }

        namespace foo {
            void bar() {
                std::cout << "A foo that bars!" << std::endl;
                std::cout << "What does that even mean?" << std::endl;
            }
        }
        """

        command = [":Cp 1 6 7"]
        self.assert_files_equal(command, self.input_string, expected_string)
