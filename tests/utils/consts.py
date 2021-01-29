from os import path
from tempfile import gettempdir

FILENAME_ACTUAL = path.join(gettempdir(), 'vimtools_test_actual')
FILENAME_EXPECTED = path.join(gettempdir(), 'vimtools_test_expected')
TEMPORARY_COMMAND_FILE = path.join(gettempdir(), 'vimtools_command_file')
