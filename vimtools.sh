BRANCH="master"

LIGHT_PURPLE="\033[1;35m"
LIGHT_RED="\033[1;31m"
LIGHT_YELLOW="\033[1;33m"
NO_COLOR="\033[0m"

REPOSITORY_NAME="VimTools"
FILENAME_ZIP_ARCHIVE="${REPOSITORY_NAME}-${BRANCH}.zip"
FILENAME_INFLATED="${REPOSITORY_NAME}-${BRANCH}"
VIMTOOLS_HOME="${PWD}/.vim"

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
    curl -L https://github.com/dsw7/${REPOSITORY_NAME}/archive/${BRANCH}.zip --output $FILENAME_ZIP_ARCHIVE --fail
    if [ $? -ne 0 ]
    then
        echo_error "Failed to fetch VimTools!"
        return
    fi
    echo
}

unzip_archive() {
    echo_step "[Step 2] - Inflating ${FILENAME_ZIP_ARCHIVE}..."
    unzip -o ${FILENAME_ZIP_ARCHIVE}
    echo
}

remove_existing_vim_directory() {
    echo_step "[Step 3] - Remove existing $VIMTOOLS_HOME directory..."
    if [ -d $VIMTOOLS_HOME ]
    then
        rm -rfv $VIMTOOLS_HOME
    else
        echo_warning "No existing $VIMTOOLS_HOME directory found!"
    fi
    echo
}

rename_inflated_directory() {
    echo_step "[Step 4] - Rename inflated directory..."
    mv -v $FILENAME_INFLATED $VIMTOOLS_HOME
    echo
}

cleanup_files() {
    echo_step "[Step 5] - Clean up any remaining files..."
    rm -v $FILENAME_ZIP_ARCHIVE
    echo
}

run_all_tests() {
    echo_step "[Step 6] - Run tests..."
    python3 -m unittest discover --start-directory ${VIMTOOLS_HOME}/tests -v
    echo
}

fetch_vimtools() {
    download_zip_archive
    unzip_archive
    remove_existing_vim_directory
    rename_inflated_directory
    cleanup_files
    run_all_tests
}
