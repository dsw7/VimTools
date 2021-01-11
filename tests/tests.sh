FILENAME_ACTUAL="${TMP}/vimtools_test_actual"
FILENAME_EXPECTED="${TMP}/vimtools_test_expected"

assert_files_equal() {
    cmp -s $FILENAME_ACTUAL $FILENAME_EXPECTED
    local exit_code=$?

    if [ $exit_code == 0 ]
    then
        echo "PASSED"
    elif [ $exit_code == 1 ]
    then
        echo "FAILED"
    else
        echo "ERROR"
    fi
}

test_sub_command_one_line() {
    echo "foo bar baz" > $FILENAME_ACTUAL
    echo "cat bar baz" > $FILENAME_EXPECTED
    vim -es -c "/foo" -c ":S cat" -c "wq" $FILENAME_ACTUAL
    assert_files_equal
}

test_sub_command_two_lines() {
    cat > $FILENAME_ACTUAL << EOF
foo bar baz
foo bar baz
EOF
    cat > $FILENAME_EXPECTED << EOF
cat bar baz
cat bar baz
EOF
    vim -es -c "/foo" -c ":S cat" -c "wq" $FILENAME_ACTUAL
    assert_files_equal
}

test_sub_command_add_limits() {
    cat > $FILENAME_ACTUAL << EOF
foo bar baz
foo bar baz
foo bar baz
EOF
    cat > $FILENAME_EXPECTED << EOF
cat bar baz
cat bar baz
foo bar baz
EOF
    vim -es -c "/foo" -c ":S cat 1 2" -c "wq" $FILENAME_ACTUAL
    assert_files_equal
}

test_sub_command_one_line
test_sub_command_two_lines
test_sub_command_add_limits
LIGHT_PURPLE='\033[1;35m'
LIGHT_RED='\033[1;31m'
LIGHT_YELLOW='\033[1;33m'
NO_COLOR='\033[0m'

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
    local branch="master"
    local repo="VimTools"
    local archive="${repo}-${branch}.zip"
    local inflated="${repo}-${branch}"
    local vim_directory=".vim"

    echo_step "[Step 1] - Downloading ${archive}..."
    curl -L https://github.com/dsw7/${repo}/archive/${branch}.zip --output $archive --fail
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
}
