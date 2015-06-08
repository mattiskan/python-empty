venv = venv/bin

.PHONY: build, test, clean

build: .hooks $(venv)

test: build
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
$(venv): requirements.txt
	test -d venv || virtualenv venv
	$(venv)/pip install -r requirements.txt

.hooks: hooks
	touch .hooks
	ln -s -f ../../hooks/* .git/hooks/

.SILENT: install-hooks
