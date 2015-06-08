venv = venv/bin

.PHONY: test, clean

test: $(venv)
	$(venv)/py.test

clean:
	rm -rf venv/
	find . -name "*.pyc" -delete
	find . -name "__pycache__" -delete


$(venv): requirements.txt
	test -d venv || virtualenv venv
	$(venv)/pip install -r requirements.txt
