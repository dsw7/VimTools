.PHONY = setup
.DEFAULT_GOAL = setup

setup:
	@cp --verbose .vimrc $(HOME)/.vimrc
	@echo "Setup done!"
