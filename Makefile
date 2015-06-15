HOOKS = $(wildcard hooks/*)
venv = venv/bin

.PHONY: build, test, clean

build: .build

test: .build-test
	$(venv)/py.test
	@echo "Checking syntax "
	$(venv)/flake8 --exclude=venv/ .

clean:
	rm -rf venv/
	find . -name "*.pyc" -delete
	find . -name "__pycache__" -delete

# === build commands: ===
.build: .hooks $(venv) requirements.txt
	$(venv)/pip install -r requirements.txt
	touch $@

.build-test: .build requirements-dev.txt
	$(venv)/pip install -r requirements-dev.txt
	touch $@ .build

$(venv):
	test -d venv || virtualenv venv

.hooks: $(HOOKS)
	ln -f $(HOOKS) .git/hooks
	touch $@

.SILENT: install-hooks
