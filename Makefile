.PHONY = setup
.DEFAULT_GOAL = setup

setup:
	@cp --verbose .vimrc $(HOME)/.vimrc
	@echo "Generating help tags..."
	@vim -es -c ":helptags doc" -c "q!"
	@echo "Setup done!"
