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
USER_RUNTIME_DIRECTORY = $(PWD)/.vim
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

.PHONY = fetch inflate position clean tags setup test full dockertest
.DEFAULT_GOAL = full

fetch:
	$(call ECHO_STEP,Downloading $(FILENAME_ZIP_ARCHIVE))
	@echo Using branch: $(GIT_BRANCH)
	@echo Querying URL: $(GIT_URL_VIMTOOLS)
	@curl -L $(GIT_URL_VIMTOOLS) --output $(FILENAME_ZIP_ARCHIVE) --fail
	@echo Repository will be dumped to: $(FILENAME_ZIP_ARCHIVE)

inflate:
	$(call ECHO_STEP,Inflating $(FILENAME_ZIP_ARCHIVE))
	@unzip -o $(FILENAME_ZIP_ARCHIVE)
	@echo The inflated directory will be: $(FILENAME_INFLATED)

position:
	$(call ECHO_STEP,Removing $(USER_RUNTIME_DIRECTORY) runtime directory if exists)
ifneq ($(wildcard $(USER_RUNTIME_DIRECTORY)/.),)
	$(call ECHO_WARNING,Found existing $(USER_RUNTIME_DIRECTORY) user runtime directory. Removing it!)
	@rm -rv $(USER_RUNTIME_DIRECTORY)
else
	@echo No existing $(USER_RUNTIME_DIRECTORY) found
endif
	$(call ECHO_STEP,Renamimg inflated directory)
	@mv -v $(FILENAME_INFLATED) $(USER_RUNTIME_DIRECTORY)

clean:
	$(call ECHO_STEP,Cleaning up any remaining files)
	@rm -vf $(FILENAME_ZIP_ARCHIVE)

tags:
	$(call ECHO_STEP,Generating help tags for project)
	@echo Step ensures \":help VimTools\" information is up to date
	@vim -es -c ":helptags $(USER_RUNTIME_DIRECTORY)/doc" -c "q!"

setup: fetch inflate position clean tags

test:
	$(call ECHO_STEP,Running all unit tests)
	@chmod +x $(PATH_PYTHON_UNITTEST_RUNNER)
	@$(PATH_PYTHON_UNITTEST_RUNNER)

full: setup test

dockertest:
	$(call ECHO_STEP,Building docker image $(DOCKER_TAG))
	@docker build --tag $(DOCKER_TAG) --build-arg GIT_BRANCH=$(GIT_BRANCH) $(PWD)/
	$(call ECHO_STEP,Running tests in docker container)
	@docker run --interactive --tty --rm $(DOCKER_TAG)
