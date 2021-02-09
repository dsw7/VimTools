BRANCH="master"
EXIT_FAILURE=1

LIGHT_PURPLE="\033[1;35m"
LIGHT_RED="\033[1;31m"
LIGHT_YELLOW="\033[1;33m"
NO_COLOR="\033[0m"

REPOSITORY_NAME="VimTools"
FILENAME_ZIP_ARCHIVE="${REPOSITORY_NAME}-${BRANCH}.zip"
FILENAME_INFLATED="${REPOSITORY_NAME}-${BRANCH}"
USER_RUNTIME_DIRECTORY="${PWD}/.vim"

echo_step() {
    echo -e "${LIGHT_PURPLE}$1${NO_COLOR}"
}

echo_error() {
    echo -e "${LIGHT_RED}ERROR: $1${NO_COLOR}"
}

echo_warning() {
    echo -e "${LIGHT_YELLOW}WARNING: $1${NO_COLOR}"
}

download_zip_archive() {
    echo_step "[Step 1] - Downloading ${FILENAME_ZIP_ARCHIVE}..."
    local url=https://github.com/dsw7/${REPOSITORY_NAME}/archive/${BRANCH}.zip
    curl -L $url --output $FILENAME_ZIP_ARCHIVE --fail
    if [ $? -ne 0 ]
    then
        echo_error "Failed to fetch VimTools!"
        exit $EXIT_FAILURE
    fi
    echo
}

unzip_archive() {
    echo_step "[Step 2] - Inflating ${FILENAME_ZIP_ARCHIVE}..."
    unzip -o ${FILENAME_ZIP_ARCHIVE}
    if [ $? -ne 0 ]
    then
        echo_error "Failed to unzip ${FILENAME_ZIP_ARCHIVE}!"
        exit $EXIT_FAILURE
    fi
    echo
}

remove_existing_runtime_directory() {
    echo_step "[Step 3] - Remove existing $USER_RUNTIME_DIRECTORY runtime directory..."
    if [ -d $USER_RUNTIME_DIRECTORY ]
    then
        rm -rv $USER_RUNTIME_DIRECTORY
        if [ $? -ne 0 ]
        then
            echo_error "Failed to remove ${USER_RUNTIME_DIRECTORY}!"
            exit $EXIT_FAILURE
        fi
    else
        echo_warning "No existing $USER_RUNTIME_DIRECTORY directory found!"
    fi
    echo
}

rename_inflated_directory() {
    echo_step "[Step 4] - Rename inflated directory..."
    mv -v $FILENAME_INFLATED $USER_RUNTIME_DIRECTORY
    if [ $? -ne 0 ]
    then
        echo_error "Failed to rename $FILENAME_INFLATED to ${USER_RUNTIME_DIRECTORY}!"
        exit $EXIT_FAILURE
    fi
    echo
}

cleanup_files() {
    echo_step "[Step 5] - Clean up any remaining files..."
    rm -v $FILENAME_ZIP_ARCHIVE
    if [ $? -ne 0 ]
    then
        echo_warning "Failed to clean up one or more remaining files!"
    fi
    echo
}

run_all_tests() {
    echo_step "[Step 6] - Run tests..."
    local test_runner=${USER_RUNTIME_DIRECTORY}/tests/run_tests.py
    chmod +x $test_runner
    $test_runner
    if [ $? -ne 0 ]
    then
        echo_warning "One or more tests failed!"
        exit $EXIT_FAILURE
    fi
    echo
}

fetch_vimtools() {
    download_zip_archive
    unzip_archive
    remove_existing_runtime_directory
    rename_inflated_directory
    cleanup_files
    run_all_tests
}
