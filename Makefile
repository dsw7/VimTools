GIT_BRANCH = master
GIT_REPOSITORY_NAME = VimTools
GIT_URL_VIMTOOLS = https://github.com/dsw7/$(GIT_REPOSITORY_NAME)/archive/$(GIT_BRANCH).zip
FILENAME_ZIP_ARCHIVE = $(GIT_REPOSITORY_NAME)-$(GIT_BRANCH).zip
FILENAME_INFLATED = $(GIT_REPOSITORY_NAME)-$(GIT_BRANCH)
USER_RUNTIME_DIRECTORY = $(PWD)/.vim
PATH_PYTHON_UNITTEST_RUNNER = $(USER_RUNTIME_DIRECTORY)/tests/run_tests.py

LIGHT_PURPLE = "\033[4;1;35m"
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

all: install run-tests

install:
	$(call echo_step,Downloading $(FILENAME_ZIP_ARCHIVE))
	@echo Using branch: $(GIT_BRANCH)
	@echo Querying URL: $(GIT_URL_VIMTOOLS)

	@curl -L $(GIT_URL_VIMTOOLS) --output $(FILENAME_ZIP_ARCHIVE) --fail
	@echo Repository will be dumped to: $(FILENAME_ZIP_ARCHIVE)

	$(call echo_step,Inflating $(FILENAME_ZIP_ARCHIVE))
	@unzip -o $(FILENAME_ZIP_ARCHIVE)

	$(call echo_step,Removing $(USER_RUNTIME_DIRECTORY) runtime directory if exists)
ifneq ($(wildcard $(USER_RUNTIME_DIRECTORY)/.),)
	$(call echo_warning,Found existing $(USER_RUNTIME_DIRECTORY) user runtime directory. Removing it!)
	@rm -rv $(USER_RUNTIME_DIRECTORY)
else
	@echo No existing $(USER_RUNTIME_DIRECTORY) found
endif

	$(call echo_step,Renamimg inflated directory)
	@mv -v $(FILENAME_INFLATED) $(USER_RUNTIME_DIRECTORY)

	$(call echo_step,Cleaning up any remaining files)
	@rm -v $(FILENAME_ZIP_ARCHIVE)

	$(call echo_step,Generating help tags for project)
	@vim -es -c ":helptags $(USER_RUNTIME_DIRECTORY)/docs" -c "q!"

run-tests:
	$(call echo_step,Running all unit tests)
	@chmod +x $(PATH_PYTHON_UNITTEST_RUNNER)
	@$(PATH_PYTHON_UNITTEST_RUNNER)
