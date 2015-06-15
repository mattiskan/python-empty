venv = venv/bin

.PHONY: build, test, clean

build: .build

test: .build-test
	$(venv)/py.test

clean:
	rm -rf venv/
	rm -f .hooks
	find . -name "*.pyc" -delete
	find . -name "__pycache__" -delete

install-hooks:
	rm .hooks
	make .hooks

# === build commands: ===
.build: .hooks $(venv) requirements.txt
	$(venv)/pip install -r requirements.txt
	touch $@

.build-test: .build requirements-dev.txt
	$(venv)/pip install -r requirements-dev.txt
	touch $@

$(venv):
	test -d venv || virtualenv venv

.hooks: hooks
	ln -s -f ../../hooks/* .git/hooks/
	touch $@

.SILENT: install-hooks
