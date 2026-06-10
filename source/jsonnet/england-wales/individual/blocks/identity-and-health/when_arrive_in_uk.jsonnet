local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title) = {
  id: 'when-arrive-in-uk-question',
  title: title,
  type: 'General',
  answers: [
    {
      id: 'when-arrive-in-uk-answer',
      mandatory: false,
      options: [
        {
          label: 'Yes',
          value: 'Yes',
        },
        {
          label: 'No',
          value: 'No',
        },
      ],
      type: 'Radio',
    },
  ],
};

local nonProxyTitle = {
  text: 'Did you arrive in the UK on or after {year_before_census_date}?',
  placeholders: [
    placeholders.yearBeforeCensusDate,
  ],
};
local proxyTitle = {
  text: 'Did <strong>{person_name}</strong> arrive in the UK on or after {year_before_census_date}?',
  placeholders: [
    placeholders.personName(),
    placeholders.yearBeforeCensusDate,
  ],
};

function(region_code) {
  type: 'Question',
  id: 'when-arrive-in-uk',
  page_title: 'Arrived in the UK on or after 21 March 2020',
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
      block: 'length-of-stay-in-uk',
      when: {
        '==': [
          {
            source: 'answers',
            identifier: 'when-arrive-in-uk-answer',
          },
          'Yes',
        ],
      },
    },
    {
      block: 'location-one-year-ago',
      when: {
        '==': [
          {
            source: 'answers',
            identifier: 'when-arrive-in-uk-answer',
          },
          'No',
        ],
      },
    },
    {
      block: 'length-of-stay-in-uk',
    },
  ],
}
