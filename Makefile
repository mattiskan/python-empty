venv = venv/bin

.PHONY: test

test: $(venv)
	$(venv)/py.test

$(venv): requirements.txt
	test -d venv || virtualenv venv
	$(venv)/pip install -r requirements.txt
