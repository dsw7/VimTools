BRANCH = master
REPOSITORY_NAME = VimTools
FILENAME_ZIP_ARCHIVE = $(REPOSITORY_NAME)-$(BRANCH).zip
FILENAME_INFLATED = $(REPOSITORY_NAME)-$(BRANCH)
USER_RUNTIME_DIRECTORY = $(PWD)/.vim
TEST_RUNNER = $(USER_RUNTIME_DIRECTORY)/tests/run_tests.py

LIGHT_PURPLE = "\033[1;35m"
LIGHT_RED = "\033[1;31m"
LIGHT_YELLOW = "\033[1;33m"
NO_COLOR = "\033[0m"

define echo_step
	@echo -e $(LIGHT_PURPLE)$(1)$(NO_COLOR)
endef

define echo_error
    @echo -e $(LIGHT_RED)ERROR: $(1)$(NO_COLOR)
endef

define echo_warning
    @echo -e $(LIGHT_YELLOW)WARNING: $(1)$(NO_COLOR)
endef

define download_zip_archive
    $(call echo_step,"[Step 1] - Downloading $(FILENAME_ZIP_ARCHIVE)...")
    @curl -L https://github.com/dsw7/$(REPOSITORY_NAME)/archive/$(BRANCH).zip --output $(FILENAME_ZIP_ARCHIVE) --fail
endef

define unzip_archive
    $(call echo_step,"[Step 2] - Inflating $(FILENAME_ZIP_ARCHIVE)...")
    @unzip -o $(FILENAME_ZIP_ARCHIVE)
endef

define remove_existing_runtime_directory
    $(call echo_step,"[Step 3] - Remove $(USER_RUNTIME_DIRECTORY) runtime directory if exists...")
    if [ -d $(USER_RUNTIME_DIRECTORY) ]; then rm -rv $(USER_RUNTIME_DIRECTORY); fi
endef

define rename_inflated_directory
    $(call echo_step,"[Step 4] - Rename inflated directory...")
    @mv -v $(FILENAME_INFLATED) $(USER_RUNTIME_DIRECTORY)
endef

define cleanup_files
    $(call echo_step,"[Step 5] - Clean up any remaining files...")
    @rm -v $(FILENAME_ZIP_ARCHIVE)
endef

define run_all_tests
    $(call echo_step,"[Step 6] - Run tests...")
    @chmod +x $(TEST_RUNNER)
	@$(TEST_RUNNER)
endef

install:
	$(call download_zip_archive)
	$(call unzip_archive)
	$(call remove_existing_runtime_directory)
	$(call rename_inflated_directory)
	$(call cleanup_files)

run-tests:
	$(call run_all_tests)

install-test:
	$(call download_zip_archive)
	$(call unzip_archive)
	$(call remove_existing_runtime_directory)
	$(call rename_inflated_directory)
	$(call cleanup_files)
	$(call run_all_tests)
