#!/usr/bin/env python3
import sys
from os import path
from unittest import (
    TestLoader,
    TextTestRunner
)

EXIT_SUCCESS = 0
EXIT_FAILURE = 1

def main():
    test_directory = path.dirname(__file__)
    realpath = path.realpath(test_directory)

    print(f'Running tests in directory: {realpath}')
    test_filenames = 'test_*'

    suite = TestLoader().discover(
        test_directory, pattern=test_filenames
    )
    runner = TextTestRunner(verbosity=2)
    test_result = runner.run(suite)

    if test_result.wasSuccessful():
        sys.exit(EXIT_SUCCESS)
    else:
        sys.exit(EXIT_FAILURE)

if __name__ == "__main__":
    main()
