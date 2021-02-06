BRANCH = master
REPOSITORY_NAME = VimTools
FILENAME_ZIP_ARCHIVE = $(REPOSITORY_NAME)-$(BRANCH).zip
FILENAME_INFLATED = $(REPOSITORY_NAME)-$(BRANCH)
USER_RUNTIME_DIRECTORY = $(PWD)/.vim

LIGHT_PURPLE = "\033[1;35m"
LIGHT_RED = "\033[1;31m"
LIGHT_YELLOW = "\033[1;33m"
NO_COLOR = "\033[0m"

define echo_step
	@echo -e $(LIGHT_PURPLE)$(1)$(NO_COLOR)
endef

define echo_error
    echo -e $(LIGHT_RED)ERROR: $(1)$(NO_COLOR)
endef

define echo_warning
    echo -e $(LIGHT_YELLOW)WARNING: $(1)$(NO_COLOR)
endef

define download_zip_archive
    $(call echo_step,"[Step 1] - Downloading $(FILENAME_ZIP_ARCHIVE)...")
    curl -L https://github.com/dsw7/$(REPOSITORY_NAME)/archive/$(BRANCH).zip --output $(FILENAME_ZIP_ARCHIVE) --fail
endef

install:
	$(call download_zip_archive)

test:
	@echo "Creating empty text files..."

install-test:
	@echo "Install and test..."
