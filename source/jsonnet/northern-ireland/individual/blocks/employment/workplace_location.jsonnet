local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local anotherCountryAnswerOption = 'No, it is in another country';
local pastAnotherCountryAnswerOption = 'No, it was in another country';

local question(title, anotherCountry) = {
  id: 'workplace-location-question',
  title: title,
  type: 'General',
  answers: [
    {
      id: 'workplace-location-answer',
      mandatory: false,
      options: [
        {
          label: 'Yes',
          value: 'Yes',
        },
        {
          label: anotherCountry,
          value: anotherCountry,
        },
      ],
      type: 'Radio',
    },
  ],
};

local nonProxyTitle = 'Is your main place of <strong>work</strong> in the UK?';
local proxyTitle = {
  text: 'Is <strong>{person_name_possessive}</strong> main place of <strong>work</strong> in the UK?',
  placeholders: [
    placeholders.personNamePossessive,
  ],
};

local pastNonProxyTitle = 'Was your main place of <strong>work</strong> in the UK?';
local pastProxyTitle = {
  text: 'Was <strong>{person_name_possessive}</strong> main place of <strong>work</strong> in the UK?',
  placeholders: [
    placeholders.personNamePossessive,
  ],
};

{
  type: 'Question',
  id: 'workplace-location',
  page_title: 'Main place of work in the UK',
  question_variants: [
    {
      question: question(nonProxyTitle, anotherCountryAnswerOption),
      when: { and: [rules.isNotProxy, rules.mainJob] },
    },
    {
      question: question(proxyTitle, anotherCountryAnswerOption),
      when: { and: [rules.isProxy, rules.mainJob] },
    },
    {
      question: question(pastNonProxyTitle, pastAnotherCountryAnswerOption),
      when: rules.isNotProxy,
    },
    {
      question: question(pastProxyTitle, pastAnotherCountryAnswerOption),
      when: rules.isProxy,
    },
  ],
  routing_rules: [
    {
      block: 'workplace-country',
      when: {
        'in': [
          {
            source: 'answers',
            identifier: 'workplace-location-answer',
          },
          ['No, it is in another country', 'No, it was in another country'],
        ],
      },
    },
    {
      block: 'workplace-address',
    },
  ],
}
