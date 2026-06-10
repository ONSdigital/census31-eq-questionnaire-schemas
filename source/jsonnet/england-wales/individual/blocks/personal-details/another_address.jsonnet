local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title) = {
  id: 'another-address-question',
  title: title,
  type: 'General',
  definitions: [
    {
      title: 'What we mean by “another address”',
      contents: [
        {
          description: 'This is a single address that is different to the one at the start of this questionnaire. This might be another parent or guardian’s address, a term-time address, a partner’s address or a holiday home.',
        },
      ],
    },
  ],
  description: [
    'This should be a single address and could be more than 30 days in a row or divided across the year',
  ],
  answers: [
    {
      id: 'another-address-answer',
      mandatory: false,
      options: [
        {
          label: 'No',
          value: 'No',
        },
        {
          label: 'Yes, an address within the UK',
          value: 'Yes, an address within the UK',
        },
        {
          label: 'Yes, an address outside the UK',
          value: 'Yes, an address outside the UK',
        },
      ],
      type: 'Radio',
    },
  ],
};

local nonProxyTitle = 'Do you stay at another address for more than 30 days a year?';
local proxyTitle = {
  text: 'Does <strong>{person_name}</strong> stay at another address for more than 30 days a year?',
  placeholders: [
    placeholders.personName(),
  ],
};

{
  type: 'Question',
  id: 'another-address',
  page_title: 'Another address, more than 30 days a year',
  question_variants: [
    {
      question: question(nonProxyTitle),
      when: rules.isNotProxy,
    },
    {
      question: question(proxyTitle),
      when: rules.isProxy,
    },
  ],
  routing_rules: [
    {
      group: 'identity-and-health-group',
      when: {
        and: [
          {
            '==': [
              {
                source: 'answers',
                identifier: 'another-address-answer',
              },
              null,
            ],
          },
          rules.under5,
        ],
      },
    },
    {
      group: 'identity-and-health-group',
      when: {
        and: [
          {
            '==': [
              {
                source: 'answers',
                identifier: 'another-address-answer',
              },
              'No',
            ],
          },
          rules.under5,
        ],
      },
    },
    {
      block: 'in-education',
      when: {
        '==': [
          {
            source: 'answers',
            identifier: 'another-address-answer',
          },
          'No',
        ],
      },
    },
    {
      block: 'other-address-uk',
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
      block: 'another-address-outside-uk',
      when: {
        '==': [
          {
            source: 'answers',
            identifier: 'another-address-answer',
          },
          'Yes, an address outside the UK',
        ],
      },
    },
    {
      block: 'in-education',
    },
  ],
}
