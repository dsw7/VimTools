############################################
#                                          #
#  DAVID WEBER VIMTOOLS OFFICIAL MAKEFILE  #
#                                          #
############################################

GIT_BRANCH = master
GIT_REPOSITORY_NAME = VimTools
GIT_URL_VIMTOOLS = https://github.com/dsw7/$(GIT_REPOSITORY_NAME)/archive/$(GIT_BRANCH).zip
FILENAME_ZIP_ARCHIVE = $(GIT_REPOSITORY_NAME)-$(GIT_BRANCH).zip
FILENAME_INFLATED = $(GIT_REPOSITORY_NAME)-$(GIT_BRANCH)
USER_RUNTIME_DIRECTORY = $(PWD)/.vim/plugin/vimtools
USER_DOC_DIRECTORY = $(PWD)/.vim/doc
PATH_PYTHON_UNITTEST_RUNNER = $(USER_RUNTIME_DIRECTORY)/tests/run_tests.py
DOCKER_TAG = vimtools

LIGHT_PURPLE = "\033[4;1;35m"
LIGHT_RED = "\033[1;31m"
LIGHT_YELLOW = "\033[1;33m"
NO_COLOR = "\033[0m"

define ECHO_STEP
	@echo -e $(LIGHT_PURPLE)$(1)$(NO_COLOR)
endef

define ECHO_ERROR
    @echo -e $(LIGHT_RED)ERROR: $(1)$(NO_COLOR)
endef

define ECHO_WARNING
    @echo -e $(LIGHT_YELLOW)WARNING: $(1)$(NO_COLOR)
endef

.PHONY = install test full dockertest
.DEFAULT_GOAL = full

install:
	$(call ECHO_STEP,Downloading $(FILENAME_ZIP_ARCHIVE))
	@echo Using branch: $(GIT_BRANCH)
	@echo Querying URL: $(GIT_URL_VIMTOOLS)
	@curl --location $(GIT_URL_VIMTOOLS) --output $(FILENAME_ZIP_ARCHIVE) --fail
	@echo Repository will be dumped to: $(FILENAME_ZIP_ARCHIVE)

	$(call ECHO_STEP,Inflating $(FILENAME_ZIP_ARCHIVE))
	@unzip -o $(FILENAME_ZIP_ARCHIVE)
	@echo The inflated directory will be: $(FILENAME_INFLATED)

	$(call ECHO_STEP,Removing $(USER_RUNTIME_DIRECTORY) runtime directory if exists)
ifneq ($(wildcard $(USER_RUNTIME_DIRECTORY)/.),)
	$(call ECHO_WARNING,Found existing $(USER_RUNTIME_DIRECTORY) user runtime directory. Removing it!)
	@rm -rv $(USER_RUNTIME_DIRECTORY)
else
	@echo No existing $(USER_RUNTIME_DIRECTORY) found
	@echo Creating a new $(USER_RUNTIME_DIRECTORY) directory
	@mkdir -p $(USER_RUNTIME_DIRECTORY)
endif

	$(call ECHO_STEP,Renamimg inflated directory)
	@mv -v $(FILENAME_INFLATED) $(USER_RUNTIME_DIRECTORY)

	$(call ECHO_STEP,Cleaning up any remaining files)
	@rm -vf $(FILENAME_ZIP_ARCHIVE)

	$(call ECHO_STEP,Generating help tags for project)
	@echo Step ensures \":help VimTools\" information is up to date
	@vim -es -c ":helptags $(USER_DOC_DIRECTORY)" -c "q!"

	@echo --------------------------------------------------
	@echo Setup is complete!

test:
	$(call ECHO_STEP,Running all unit tests)
	@chmod +x $(PATH_PYTHON_UNITTEST_RUNNER)
	@$(PATH_PYTHON_UNITTEST_RUNNER)

full: install test

dockertest:
	$(call ECHO_STEP,Building docker image $(DOCKER_TAG))
	@docker build --tag $(DOCKER_TAG) $(PWD)/
	$(call ECHO_STEP,Running tests in docker container)
	@docker run --interactive --tty --env GIT_BRANCH=$(GIT_BRANCH) --rm $(DOCKER_TAG)
