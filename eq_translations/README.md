# eq_translations

Scripts for translating census31-eq-questionnaire-runner schemas. This package was merged in from the [census31-eq-translations](https://github.com/ONSdigital/census31-eq-translations) repo.

## Basic library Usage

The library exports a `eq_translations.SurveySchema` class and `eq_translations.SchemaTranslation` class. These classes can be used directly to perform translations, or there are some helper methods available in `eq_translations.entrypoints`:

`extract_template(schema_path, output_directory)`

`translate_schema(schema_path, translation_path, output_directory)`

`handle_compare_schemas(source_schema, target_schema)`

## Usage

Extract translatable text from an eQ schema with:

```shell
poetry run python -m eq_translations.cli.extract_template <schema_file> <output_directory>
```

This will output the translatable text to an POT file.

After the text has been translated, create a new translated schema with:

```shell
poetry run python -m eq_translations.cli.translate_schema <schema_file> <translation_path> <output_directory>
```

To compare two schemas for differences in structure:

```shell
poetry run python -m eq_translations.cli.compare_schemas <path_to_source_schema> <path_to_target_schema>
```

## Naming conventions

Translation files should be the name of the schema to translate followed by the [country code](https://en.wikipedia.org/wiki/ISO_3166-1) of the translations and a `.po` extension e.g.

```shell
<schema_name>_gb_wls.po
```

## Managing translations

When `gettext` is installed there are a number of command line utilities that can help with managing translations.

To merge the translations from an already translated schema into another one, you can use `msgmerge`. For example `msgmerge <translated_schema>-cy.po <target_schema>.pot -o <target_schema>-cy.po` will merge matching Welsh translations from the translated schema into the not yet translated target schema.

To add the content of translation files together, you can use `msgcat`. For example `msgcat <schema_name>.pot <schema_name>-gb.pot -o <schema_name>.pot` will add unique messages from each input template file to create an output template for both schema versions.
