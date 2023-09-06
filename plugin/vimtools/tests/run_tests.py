import sys
from pathlib import Path
from unittest import TestLoader, TextTestRunner


def main():
    test_directory = Path(__file__).resolve().parent
    print(f"Running tests in directory: {test_directory}")

    suite = TestLoader().discover(test_directory, pattern="test_*")
    result = TextTestRunner(verbosity=2).run(suite)

    if not result.wasSuccessful():
        sys.exit(1)


if __name__ == "__main__":
    main()
