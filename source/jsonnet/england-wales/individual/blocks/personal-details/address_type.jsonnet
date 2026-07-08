local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title) = {
  id: 'address-type-question',
  title: title,
  type: 'General',
  answers: [
    {
      id: 'address-type-answer',
      mandatory: false,
      options: [
        {
          label: 'Armed forces base address',
          value: 'Armed forces base address',
        },
        {
          label: 'Another address when working away from home',
          value: 'Another address when working away from home',
        },
        {
          label: 'Student’s home address',
          value: 'Student’s home address',
        },
        {
          label: 'Student’s term-time address',
          value: 'Student’s term-time address',
        },
        {
          label: 'Another parent or guardian’s address',
          value: 'Another parent or guardian’s address',
        },
        {
          label: 'Partner’s address',
          value: 'Partner’s address',
        },
        {
          label: 'Holiday home',
          value: 'Holiday home',
        },
        {
          label: 'Other',
          value: 'Other',
        },
      ],
      type: 'Checkbox',
    },
  ],
};

local ukAddressTitle = {
  text: 'What type of address is <strong>{household_address}</strong>?',
  placeholders: [
    {
      placeholder: 'household_address',
      value: {
        identifier: 'other-address-uk-answer',
        source: 'answers',
        selector: 'line1',
      },
    },
  ],
};
local nonProxyNonUkAddressTitle = {
  text: 'What type of address is your address in <strong>{country}</strong>?',
  placeholders: [
    {
      placeholder: 'country',
      value: {
        source: 'answers',
        identifier: 'another-address-outside-uk-answer',
      },
    },
  ],
};
local proxyNonUkAddressTitle = {
  text: 'What type of address is <strong>{person_name_possessive}</strong> address in {country}?',
  placeholders: [
    placeholders.personNamePossessive,
    {
      placeholder: 'country',
      value: {
        source: 'answers',
        identifier: 'another-address-outside-uk-answer',
      },
    },
  ],
};

{
  type: 'Question',
  id: 'address-type',
  page_title: 'Type of address',
  question_variants: [
    {
      question: question(ukAddressTitle),
      when: {
        '==': [
          {
            source: 'answers',
            identifier: 'another-address-answer',
          },
          'Yes, an address within the UK',
        ],
      },
    },
    {
      question: question(nonProxyNonUkAddressTitle),
      when: rules.isNotProxy,
    },
    {
      question: question(proxyNonUkAddressTitle),
      when: rules.isProxy,
    },
  ],
  routing_rules: [
    {
      group: 'identity-and-health-group',
      when: rules.under5,
    },
    {
      block: 'in-education',
    },
  ],
}
