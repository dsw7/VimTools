#!/usr/bin/env python3
import sys
from os import path
from tempfile import gettempdir
from unittest import (
    TestLoader,
    TextTestRunner
)

EXIT_SUCCESS = 0
EXIT_FAILURE = 1
PATH_REPORT = path.join(gettempdir(), 'vimtools_test_report.txt')
TEST_FILENAMES_PATTERN = 'test_*'

def write_report(failures):
    with open(PATH_REPORT, 'w') as f:
        for item in failures:
            f.write(item[0].__str__())
            f.write(item[1])
            f.write('\n')
    print(f'Wrote test report to {PATH_REPORT}')

def main():
    test_directory = path.dirname(__file__)
    realpath = path.realpath(test_directory)

    print(f'Running tests in directory: {realpath}')

    suite = TestLoader().discover(
        test_directory, pattern=TEST_FILENAMES_PATTERN
    )
    runner = TextTestRunner(verbosity=2)
    test_result = runner.run(suite)

    if test_result.wasSuccessful():
        sys.exit(EXIT_SUCCESS)
    else:
        write_report(test_result.failures)
        sys.exit(EXIT_FAILURE)

if __name__ == "__main__":
    main()
