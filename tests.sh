FILENAME_ACTUAL="${TMP}/vimtools_test_actual"
FILENAME_EXPECTED="${TMP}/vimtools_test_expected"
LIGHT_RED="\033[1;31m"
DARK_GREEN="\033[0;32m"
NO_COLOR="\033[0m"

assert_files_equal() {
    local function_name=$1

    cmp -s $FILENAME_ACTUAL $FILENAME_EXPECTED
    local exit_code=$?

    if [ $exit_code == 0 ]
    then
        echo -e "${DARK_GREEN}[ PASSED ]${NO_COLOR} - $function_name"
    elif [ $exit_code == 1 ]
    then
        echo -e "${LIGHT_RED}[ FAILED ]${NO_COLOR} - $function_name"
    else
        echo -e "${LIGHT_RED}[ ERROR ]${NO_COLOR} - $function_name"
    fi
}

test_sub_command_no_limits() {
    cat > $FILENAME_ACTUAL << EOF
foo bar baz
foo bar baz
EOF
    cat > $FILENAME_EXPECTED << EOF
cat bar baz
cat bar baz
EOF
    vim -es -c "/foo" -c ":S cat" -c "wq" $FILENAME_ACTUAL
    assert_files_equal ${FUNCNAME[0]}
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
    assert_files_equal ${FUNCNAME[0]}
}

test_remove_whitespace() {
    echo "foo bar baz  " > $FILENAME_ACTUAL
    echo "foo bar baz" > $FILENAME_EXPECTED
    vim -es -c ":Ws" -c "wq" $FILENAME_ACTUAL
    assert_files_equal ${FUNCNAME[0]}
}

test_remove_preceding_whitelines() {
    cat > $FILENAME_ACTUAL << EOF
foo bar baz
    foo bar baz
    foo bar baz
    foo bar baz
EOF
    cat > $FILENAME_EXPECTED << EOF
foo bar baz
    foo bar baz
foo bar baz
foo bar baz
EOF
    vim -es -c ":Wl 3 4" -c "wq" $FILENAME_ACTUAL
    assert_files_equal ${FUNCNAME[0]}
}

test_copy_command() {
    cat > $FILENAME_ACTUAL << EOF
foo bar baz
foo bar baz


EOF
    cat > $FILENAME_EXPECTED << EOF
foo bar baz
foo bar baz

foo bar baz
foo bar baz

EOF
    vim -es -c ":Cp 1 2 3" -c "wq" $FILENAME_ACTUAL
    assert_files_equal ${FUNCNAME[0]}
}

test_indent_command() {
    cat > $FILENAME_ACTUAL << EOF
foo bar baz
foo bar baz
foo bar baz
EOF
    cat > $FILENAME_EXPECTED << EOF
foo bar baz
    foo bar baz
    foo bar baz
EOF
    vim -es -c ":Ind 2 3" -c "wq" $FILENAME_ACTUAL
    assert_files_equal ${FUNCNAME[0]}
}

test_insert_command() {
    cat > $FILENAME_ACTUAL << EOF
foo bar baz
foo bar baz
foo bar baz
EOF
    cat > $FILENAME_EXPECTED << EOF
>foo bar baz
>foo bar baz
>foo bar baz
EOF
    vim -es -c ":Ins > 1 3" -c "wq" $FILENAME_ACTUAL
    assert_files_equal ${FUNCNAME[0]}
}

test_delete_command() {
    cat > $FILENAME_ACTUAL << EOF
foo bar baz
foo bar baz
foo bar baz
foo bar baz
EOF
    cat > $FILENAME_EXPECTED << EOF
foo bar baz
foo bar baz
EOF
    vim -es -c ":Del 3 4" -c "wq" $FILENAME_ACTUAL
    assert_files_equal ${FUNCNAME[0]}
}

test_move_command() {
    cat > $FILENAME_ACTUAL << EOF
foo bar baz
foo bar baz


EOF
    cat > $FILENAME_EXPECTED << EOF

foo bar baz
foo bar baz

EOF
    vim -es -c ":Mv 1 2 3" -c "wq" $FILENAME_ACTUAL
    assert_files_equal ${FUNCNAME[0]}
}

test_sub_command_no_limits
test_sub_command_add_limits
test_remove_whitespace
test_remove_preceding_whitelines
test_copy_command
test_indent_command
test_insert_command
test_delete_command
test_move_command
