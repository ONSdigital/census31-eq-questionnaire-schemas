clean:
	rm -rf schemas

build-schemas:
	./scripts/build_schemas.sh

build: build-schemas translate-schemas 

run-validator: validator-check
	./scripts/run_validator.sh

lint:
	poetry run ./scripts/run_lint_python.sh
	./scripts/lint_jsonnet.sh

format:
	./scripts/format_jsonnet.sh
	poetry run isort .
	poetry run black .

validator-check:
	poetry run python -m scripts.eq_validator_check

validate-schemas: validator-check
	poetry run python -m scripts.validate_schemas

translations-check:
	poetry run python -m scripts.eq_translations_check

translation-templates: translations-check
	poetry run python -m scripts.extract_translation_templates

test-translation-templates: translations-check
	poetry run python -m scripts.extract_translation_templates --test

translate-schemas: translations-check
	poetry run python -m scripts.translate_schemas

resolve-suggestions-urls:
	poetry run python -m scripts.resolve_suggestions_urls
