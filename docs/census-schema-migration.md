# Census Schema Migration

Since the Census in 2021 the EQ questionnaire schema has moved on. This document identifies the elements of the census schemas affected and what needs to change to align with the new schema.

## `Summary` blocks

- Summary blocks have been removed
- Runner change: <https://github.com/ONSdigital/eq-questionnaire-runner/pull/606>
- Documentation: <https://github.com/ONSdigital/eq-questionnaire-validator/pull/90>
- The old census schemas finish with a section (and group) containing a `Summary` block
- **Action:** Remove the summary section

```json
{
    "groups": [
        {
            "blocks": [
                {
                    "id": "summary",
                    "type": "Summary"
                }
            ],
            "id": "submit-group",
            "title": "Submit answers"
        }
    ],
    "id": "submit-answers-section",
    "title": "Submit answers"
}
```

### `questionnaire_flow`

- As part of the `Summary` block removal, a new `questionnaire_flow` element has been added at top level.
- **Action:** Add the `questionnaire_flow` element as follows

For individual:

```json
"questionnaire_flow": {
    "type": "Linear",
    "options": {
        "summary": {
            "collapsible": false
        }
    }
}
```

For household:

```json
"questionnaire_flow": {
    "type": "Hub",
    "options": {
        "required_completed_sections": [
            "section-id-1",
            "section-id-2",
            "..."
        ]
    }
}
```

## `submission.confirmation_email` and `submission.feedback`

- These elements have been moved into a new `post_submission` object
- **Action:** Remove the properties from the `submission` object and create a new `post_submission` object with them in

Old:

```json
"submission": {
    "feedback": true,
    "confirmation_email": true
}
```

New:

```json
"post_submission": {
    "feedback": true,
    "confirmation_email": true
}
```

## `survey`

- The `survey` property has been removed
- **Action:** Delete the `survey` property from the schema.

## `theme`

- The `census` theme no longer exists in new runner.
- **Action:** Change `theme` to `social` (for now).

## `<em></em>` strings

- The text highlighting (use for highlighting placeholders) has been updated to use `<strong>` in place of `<em>`
- Runner change: <https://github.com/ONSdigital/eq-questionnaire-runner/pull/1327>
- **Action:** Replace all occurrences of `<em></em>` in schema strings with `<strong></strong>`

## `id_selector`

- Used in `contains`, `list_has_items` and `concatenate_list` transforms, and some `when` rules
- Has been renamed to `selector`
- **Action:** Rename `id_selector` to `selector` throughout the schemas

Old:

```json
{
    "arguments": {
        "list_to_check": {
            "id_selector": "same_name_items",
            "identifier": "household",
            "source": "list"
        },
        "value": {
            "identifier": "list_item_id",
            "source": "location"
        }
    },
    "transform": "contains"
}
```

New:

```json
{
    "arguments": {
        "list_to_check": {
            "selector": "same_name_items",
            "identifier": "household",
            "source": "list"
        },
        "value": {
            "identifier": "list_item_id",
            "source": "location"
        }
    },
    "transform": "contains"
}
```

## `list_item_selector`

- Used to select an answer from the answer store for a specific list item
- Used in the `format_name` transform
- **Action:** Rename `id` to `identifier` throughout the schemas
- **Action:** Rename `id_selector` to `selector` throughout the schemas

Old (location source):

```json
{
    "first_name": {
        "id": "first-name",
        "list_item_selector": {
            "id": "to_list_item_id",
            "source": "location"
        },
        "source": "answers"
    }
}
```

New (location source):

```json
{
    "first_name": {
        "identifier": "first-name",
        "list_item_selector": {
            "identifier": "to_list_item_id",
            "source": "location"
        },
        "source": "answers"
    }
}
```

Old (list source):

```json
{
    "first_name": {
        "identifier": "first-name",
        "list_item_selector": {
            "id": "household",
            "id_selector": "first",
            "source": "list"
        },
        "source": "answers"
    }
}
```

New (list source):

```json
{
    "first_name": {
        "identifier": "first-name",
        "list_item_selector": {
            "identifier": "household",
            "selector": "first",
            "source": "list"
        },
        "source": "answers"
    }
}
```

## `list_to_concatenate`

- Used in the `concatenate_list` transform
- Across all schemas, this is only used to concatenate first name and last name
- Value is now a list of answer sources
- Runner change: <https://github.com/ONSdigital/eq-questionnaire-runner/pull/617>
- **Action:** Update `list_to_concatenate` to be a list of answer sources

Old:

```json
{
    "arguments": {
        "delimiter": " ",
        "list_to_concatenate": {
            "identifier": [
                "first-name",
                "last-name"
            ],
            "source": "answers"
        }
    },
    "transform": "concatenate_list"
}
```

New:

```json
{
    "arguments": {
        "delimiter": " ",
        "list_to_concatenate": [
            {
                "source": "answers",
                "identifier": "first-name"
            },
            {
                "source": "answers",
                "identifier": "last-name"
            }
        ]
    },
    "transform": "concatenate_list"
}
```

Old (with list):

```json
{
    "arguments": {
    "delimiter": " ",
    "list_to_concatenate": {
        "identifier": [
            "first-name",
            "last-name"
        ],
        "list_item_selector": {
            "id": "visitors",
            "id_selector": "first",
            "source": "list"
        },
        "source": "answers"
    }
    },
    "transform": "concatenate_list"
}
```

New (with list):

```json
{
    "arguments": {
        "delimiter": " ",
        "list_to_concatenate": [
            {
                "source": "answers",
                "identifier": "first-name",
                "list_item_selector": {
                    "source": "list",
                    "identifier": "visitors",
                    "selector": "first"
                }
            },
            {
                "source": "answers",
                "identifier": "last-name",
                "list_item_selector": {
                    "source": "list",
                    "identifier": "visitors",
                    "selector": "first"
                }
            }
        ]
    },
    "transform": "concatenate_list"
}
```

## `add` transform

- The `add` transform is used to add a number to a list count
- Previously a list value source without an id selector would return the list count
- Now the value source without a selector returns the list itself
- **Action:** Insert a new `list_item_count` transform before the `add` transform and use `previous_transform` to reference it in the `add` transform

Old:

```json
{
    "arguments": {
        "lhs": {
            "identifier": "household",
            "source": "list"
        },
        "rhs": {
            "value": 1
        }
    },
    "transform": "add"
}
```

New:

```json
{
    "transform": "list_item_count",
    "arguments": {
        "list_to_count": {
            "source": "list",
            "identifier": "household"
        }
    }
},
{
    "arguments": {
        "lhs": {
            "source": "previous_transform"
        },
        "rhs": {
            "value": 1
        }
    },
    "transform": "add"
}
```

## `routing_rules`

- The `goto` element has been removed
- **Action:** Remove `goto` property and collapse contents into it's parent

Old:

```json
"routing_rules": [
    {
        "goto": {
            "group": "identity-and-health-group",
            "when": [
                {
                "condition": "greater than",
                "date_comparison": {
                    "offset_by": {
                        "years": -5
                    },
                    "value": "2021-03-21"
                },
                "id": "date-of-birth-answer"
                }
            ]
        }
    },
    {
        "goto": {
            "block": "in-education"
        }
    }
]
```

New:

```json
"routing_rules": [
    {
        "group": "identity-and-health-group",
        "when": [
            {
            "condition": "greater than",
            "date_comparison": {
                "offset_by": {
                    "years": -5
                },
                "value": "2021-03-21"
            },
            "id": "date-of-birth-answer"
            }
        ]
    },
    {
        "block": "in-education"
    }
]
```

## `enabled`

- Used to enable a section based on a when rule
- This has been changed from an array of objects to just an object
- **Action:** Remove the array wrapping the when rule

Old:

```json
"enabled": [
    {
        "when": [
            {
                "condition": "greater than",
                "list": "household",
                "value": 1
            }
        ]
    }
]
```

New:

```json
"enabled": {
    "when": [
        {
            "condition": "greater than",
            "list": "household",
            "value": 1
        }
    ]
}
```

## When rules

- This is where the biggest change has happened
- Runner change (useful to see mapping from old to new): <https://github.com/ONSdigital/eq-questionnaire-runner/pull/1016>
- The top level of a `when` rule is now an object rather than an array. The change required differs depending on whether it is a single or multiple when rule.

### Single when rule

- **Action:** Replace the array syntax with the object syntax (the rule migration is covered following this)

Old:

```json
"when": [
    {
        "condition": "equals",
        "id": "confirm-who-is-answering-answer",
        "value": "For myself"
    }
]
```

New:

```json
"when": {
    "condition": "equals",
    "id": "confirm-who-is-answering-answer",
    "value": "For myself"
}
```

### Multiple when rule

- Previously multiple when rules were an implicit logical `and`
- The new rules make this `and` explicit
- **Action:** Add a new `and` property within the `when` rule that has an array wrapping the rules  (the rule migration is covered following this)

Old:

```json
"when": [
    {
        "condition": "contains any",
        "id": "passports-answer",
        "values": [
            "United Kingdom",
            "Ireland"
        ]
    },
    {
        "condition": "contains",
        "id": "passports-answer",
        "value": "Other"
    }
]
```

New:

```json
"when": {
    "and": [
        {
            "condition": "contains any",
            "id": "passports-answer",
            "values": [
                "United Kingdom",
                "Ireland"
            ]
        },
        {
            "condition": "contains",
            "id": "passports-answer",
            "value": "Other"
        }
    ]
}
```

### The rules

The following `when` rules are used in the census schemas:

- set
- not set
- equals
- not equals
- greater than
- less than or equal to
- contains any
- contains
- equals any

The rest of this document covers the changes required for each of these (including variations).

#### `set`

Old:

```json
{
    "condition": "set",
    "id": "gcse-answer"
}
```

New:

```json
{
    "!=": [
        {
            "source": "answers",
            "identifier": "gcse-answer"
        },
        null
    ]
}
```

#### `not set`

Old:

```json
{
    "condition": "not set",
    "id": "another-address-answer"
}
```

New:

```json
{
    "==": [
        {
            "source": "answers",
            "identifier": "another-address-answer"
        },
        null
    ]
}
```

#### `equals` with value

Old:

```json
{
    "condition": "equals",
    "id": "confirm-who-is-answering-answer",
    "value": "For myself"
}
```

New:

```json
{
    "==": [
        {
            "source": "answers",
            "identifier": "confirm-who-is-answering-answer"
        },
        "For myself"
    ]
}
```

#### `equals` with list

Old:

```json
{
    "comparison": {
        "id": "list_item_id",
        "source": "location"
    },
    "condition": "equals",
    "id_selector": "primary_person",
    "list": "household"
}

```

New:

```json
{
    "==": [
        {
            "source": "list",
            "identifier": "household",
            "selector": "primary_person"
        },
        {
            "source": "location",
            "identifier": "list_item_id"
        }
    ]
}
```

#### `equals` with list count

Old:

```json
{
    "condition": "equals",
    "list": "household",
    "value": 0
}
```

New:

```json
{
    "==": [
        {
            "count": [
                {
                    "source": "list",
                    "identifier": "household"
                }
            ]
        },
        0
    ]
}
```

#### `equals` with date

Old:

```json
{
    "condition": "equals",
    "date_comparison": {
        "offset_by": {
            "years": -1
        },
        "value": "2021-03-21"
    },
    "id": "arrive-in-uk-answer"
}
```

New:

```json
{
    "==": [
        {
            "date": [
                {
                    "identifier": "arrive-in-uk-answer",
                    "source": "answers"
                }
            ]
        },
        {
            "date": ["2021-03-21", { "years": -1 }]
        }
    ]
}
```

#### `not equals` with value

Old:

```json
{
    "condition": "not equals",
    "id": "mainly-work-in-uk-answer",
    "value": "No"
}
```

New:

```json
{
    "!=": [
        {
            "source": "answers",
            "identifier": "mainly-work-in-uk-answer"
        },
        "No"
    ]
}
```

#### `not equals` with list

Old:

```json
{
    "comparison": {
        "id": "list_item_id",
        "source": "location"
    },
    "condition": "not equals",
    "id_selector": "primary_person",
    "list": "household"
}
```

New:

```json
{
    "!=": [
        {
            "identifier": "household",
            "source": "list",
            "selector": "primary_person"
        },
        {
            "source": "location",
            "identifier": "list_item_id"
        }
    ]
}
```

#### `greater than` with value (list count)

Old:

```json
{
    "condition": "greater than",
    "list": "household",
    "value": 0
}
```

New:

```json
{
    ">": [
        {
            "count": [
                {
                    "source": "list",
                    "identifier": "household"
                }
            ]
        },
        0
    ]
}
```

#### `greater than` with date

Old:

```json
{
    "condition": "greater than",
    "date_comparison": {
        "offset_by": {
            "years": -5
        },
        "value": "2021-03-21"
    },
    "id": "date-of-birth-answer"
}
```

New:

```json
{
    ">": [
        {
            "date": [
                {
                    "identifier": "date-of-birth-answer",
                    "source": "answers"
                }
            ]
        },
        {
            "date": ["2021-03-21", { "years": -5 }]
        }
    ]
}
```

#### `less than or equal to` with date

Old:

```json
{
    "condition": "less than or equal to",
    "date_comparison": {
        "offset_by": {
            "years": -15
        },
        "value": "2021-03-21"
    },
    "id": "date-of-birth-answer"
}
```

New:

```json
{
    "<=": [
        {
            "date": [
                {
                    "identifier": "date-of-birth-answer",
                    "source": "answers"
                }
            ]
        },
        {
            "date": ["2021-03-21", { "years": -15 }]
        }
    ]
}
```

#### `contains`

Old:

```json
{
    "condition": "contains",
    "id": "national-identity-answer",
    "value": "Other"
}
```

New:

```json
{
    "in": [
        "Other",
        {
            "identifier": "national-identity-answer",
            "source": "answers"
        }
    ]
}
```

#### `contains any`

Old:

```json
{
    "condition": "contains any",
    "id": "passports-answer",
    "values": [
        "United Kingdom",
        "Ireland"
    ]
}
```

New:

```json
{
    "any-in": [
        ["United Kingdom", "Ireland"],
        {
            "identifier": "national-identity-answer",
            "source": "answers"
        }
    ]
}
```

#### `equals any`

Old:

```json
{
    "condition": "equals any",
    "id": "confirm-age-answer",
    "values": [
        "No, I need to correct their date of birth",
        "No, I need to correct my date of birth"
    ]
}
```

New:

```json
{
    "in": [
        {
            "identifier": "confirm-age-answer",
            "source": "answers"
        },
        [
            "No, I need to correct their date of birth",
            "No, I need to correct my date of birth"
        ]
    ]
}
```
