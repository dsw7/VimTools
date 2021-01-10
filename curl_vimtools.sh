LIGHT_PURPLE='\033[1;35m'
NO_COLOR='\033[0m' # No Color

echo_step() {
    echo -e "${LIGHT_PURPLE}$1${NO_COLOR}"
}

fetch_vimtools() {
    local branch="master"
    local repo="VimTools"
    local archive="${repo}-${branch}.zip"
    local inflated="${repo}-${branch}"
    local vim_directory=".vim"

    echo_step "Step 1. Downloading ${archive}..."
    curl -L https://github.com/dsw7/${repo}/archive/${branch}.zip --output $archive
    echo ""

    echo_step "Step 2. Inflating ${archive}..."
    unzip -o ${archive}
    echo ""

    echo_step "Step 3. Remove existing $vim_directory directory..."
    if [ -d $vim_directory ]
    then
        rm -rfv $vim_directory
    else
        echo "No existing $vim_directory directory found!"
    fi
    echo ""

    echo_step "Step 4. Rename inflated directory..."
    mv -v $inflated $vim_directory
    echo ""

    echo_step "Step 5. Clean up any remaining files..."
    rm -v $archive
    echo ""

    echo "Complete!"
}
