define print_bold
	@echo "\033[1m$(1) [api] ...\033[0m"
endef

# Wipe python environment
clean:
	@$(call print_bold,Cleaning)
	@rm -f uv.lock || true
	@rm -rf .venv || true



# Install python environment from scratch
install:
	@$(call print_bold,Installing)
	@deactivate || true
	uv sync


# Run formatter
format:
	@$(call print_bold,Formatting)
	@.venv/bin/ruff check --fix
	@.venv/bin/ruff format

# Run pyright type checker
type-check:
	@$(call print_bold, Formatting)
	@deactivate || true
	@. .venv/bin/activate && pyright .


# Start up developer version of API
run:
	@$(call print_bold,Running)
	@.venv/bin/fastapi run --port 8000 compass/api_backend/app.py --reload

test-unit:
	@$(call print_bold,Unit testing)
	@.venv/bin/pytest tests/unit
