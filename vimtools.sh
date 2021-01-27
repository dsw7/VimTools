BRANCH="master"
REPOSITORY_NAME="VimTools"
LIGHT_PURPLE="\033[1;35m"
LIGHT_RED="\033[1;31m"
LIGHT_YELLOW="\033[1;33m"
NO_COLOR="\033[0m"

echo_step() {
    echo -e "${LIGHT_PURPLE}$1${NO_COLOR}"
}

echo_error() {
    echo -e "${LIGHT_RED}ERROR: $1${NO_COLOR}"
}

echo_warning() {
    echo -e "${LIGHT_YELLOW}WARNING: $1${NO_COLOR}"
}

fetch_vimtools() {
    local archive="${REPOSITORY_NAME}-${BRANCH}.zip"
    local inflated="${REPOSITORY_NAME}-${BRANCH}"
    local vim_directory=".vim"
    local test_filename="${vim_directory}/tests.sh"

    echo_step "[Step 1] - Downloading ${archive}..."
    curl -L https://github.com/dsw7/${REPOSITORY_NAME}/archive/${BRANCH}.zip --output $archive --fail
    if [ $? -ne 0 ]
    then
        echo_error "Failed to fetch VimTools!"
        return
    fi
    echo

    echo_step "[Step 2] - Inflating ${archive}..."
    unzip -o ${archive}
    echo

    echo_step "[Step 3] - Remove existing $vim_directory directory..."
    if [ -d $vim_directory ]
    then
        rm -rfv $vim_directory
    else
        echo_warning "No existing $vim_directory directory found!"
    fi
    echo

    echo_step "[Step 4] - Rename inflated directory..."
    mv -v $inflated $vim_directory
    echo

    echo_step "[Step 5] - Clean up any remaining files..."
    rm -v $archive
    echo

    echo_step "[Step 6] - Run tests..."
    # replace with python3 -m unittest discover --start-directory ${PWD}/test -v
    echo "Adding executable permissions to $test_filename"
    chmod +x $test_filename
    echo "Running test script $test_filename"
    $test_filename
    echo
}
