local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local nonProxyTitle = 'What is your country of birth?';
local proxyTitle = {
  text: 'What is <strong>{person_name_possessive}</strong> country of birth?',
  placeholders: [
    placeholders.personNamePossessive,
  ],
};

local question(title, elsewhereDescription) = {
  id: 'country-of-birth-question',
  title: title,
  type: 'General',
  answers: [
    {
      id: 'country-of-birth-answer',
      mandatory: false,
      type: 'Radio',
      options: [
        {
          label: 'Northern Ireland',
          value: 'Northern Ireland',
        },
        {
          label: 'England',
          value: 'England',
        },
        {
          label: 'Scotland',
          value: 'Scotland',
        },
        {
          label: 'Wales',
          value: 'Wales',
        },
        {
          label: 'Republic of Ireland',
          value: 'Republic of Ireland',
        },
        {
          label: 'Elsewhere',
          value: 'Elsewhere',
          description: elsewhereDescription,
        },
      ],
    },
  ],
};

{
  type: 'Question',
  id: 'country-of-birth',
  page_title: 'Country of birth',
  question_variants: [
    {
      question: question(nonProxyTitle, 'You can enter your country of birth on the next question'),
      when: rules.isNotProxy,
    },
    {
      question: question(proxyTitle, 'You can enter their country of birth on the next question'),
      when: rules.isProxy,
    },
  ],
  routing_rules: [
    {
      block: 'country-of-birth-elsewhere',
      when: {
        '==': [
          {
            source: 'answers',
            identifier: 'country-of-birth-answer',
          },
          'Elsewhere',
        ],
      },
    },
    {
      block: 'passports',
      when: {
        and: [
          {
            '==': [
              {
                source: 'answers',
                identifier: 'country-of-birth-answer',
              },
              'Northern Ireland',
            ],
          },
          rules.under1,
        ],
      },
    },
    {
      block: 'passports',
      when: {
        and: [
          {
            '==': [
              {
                source: 'answers',
                identifier: 'country-of-birth-answer',
              },
              'Northern Ireland',
            ],
          },
          rules.lastBirthdayAgeLessThan(1),
        ],
      },
    },
    {
      block: 'passports',
      when: {
        and: [
          {
            '==': [
              {
                source: 'answers',
                identifier: 'country-of-birth-answer',
              },
              null,
            ],
          },
          rules.under1,
        ],
      },
    },
    {
      block: 'passports',
      when: {
        and: [
          {
            '==': [
              {
                source: 'answers',
                identifier: 'country-of-birth-answer',
              },
              null,
            ],
          },
          rules.lastBirthdayAgeLessThan(1),
        ],
      },
    },
    {
      block: 'location-one-year-ago',
      when: {
        '==': [
          {
            source: 'answers',
            identifier: 'country-of-birth-answer',
          },
          null,
        ],
      },
    },
    {
      block: 'arrive-in-country',
      when: {
        '!=': [
          {
            source: 'answers',
            identifier: 'country-of-birth-answer',
          },
          'Northern Ireland',
        ],
      },
    },
    {
      block: 'location-one-year-ago',
    },
  ],
}
