.PHONY: all
all: workstation.json bootstrap

workstation.json: workstation.jsonnet
	jsonnet -e 'std.manifestYamlStream([(import "$<")])' -S > $@

bootstrap: venv/bin/ansible-playbook
	$< --vault-password-file password.txt workstation.json

venv/bin/ansible-playbook:
	rm -rf ./venv
	python -m venv --copies ./venv
	./venv/bin/pip install --upgrade --quiet pip
	./venv/bin/pip install --quiet ansible

.PHONY: clean
clean:
	rm -rf ./venv
