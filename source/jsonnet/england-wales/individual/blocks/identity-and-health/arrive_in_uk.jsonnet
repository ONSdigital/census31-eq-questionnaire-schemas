local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local questionTitle(isProxy) = (
  if isProxy then {
    text: 'When did <strong>{person_name}</strong> most recently arrive to live in the United Kingdom?',
    placeholders: [
      placeholders.personName(),
    ],
  }
  else 'When did you most recently arrive to live in the United Kingdom?'
);

local errorMessage(isProxy) = (
  if isProxy then 'Enter a date of arrival that is after their date of birth'
  else 'Enter a date of arrival that is after your date of birth'
);

local question(isProxy) = {
  id: 'arrive-in-uk-question',
  title: questionTitle(isProxy),
  type: 'General',
  description: [
    'Do not count short visits away from the UK',
  ],
  answers: [
    {
      id: 'arrive-in-uk-answer',
      mandatory: false,
      type: 'MonthYearDate',
      minimum: {
        value: {
          source: 'answers',
          identifier: 'date-of-birth-answer',
        },
      },
      maximum: {
        value: 'now',
      },
      validation: {
        messages: {
          INVALID_DATE: 'Enter a valid date of arrival',
          SINGLE_DATE_PERIOD_TOO_EARLY: errorMessage(isProxy),
          SINGLE_DATE_PERIOD_TOO_LATE: 'Enter a date of arrival that is in the past',
        },
      },
    },
  ],
};

function(region_code, census_month_year_date) {
  type: 'Question',
  id: 'arrive-in-uk',
  page_title: 'Arrived to live in the UK',
  question_variants: [
    {
      question: question(isProxy=false),
      when: rules.isNotProxy,
    },
    {
      question: question(isProxy=true),
      when: rules.isProxy,
    },
  ],
  routing_rules: [
    {
      block: 'length-of-stay-in-uk',
      when: rules.under1,
    },
    {
      block: 'length-of-stay-in-uk',
      when: {
        '>': [
          {
            date: [
              {
                identifier: 'arrive-in-uk-answer',
                source: 'answers',
              },
            ],
          },
          {
            date: [census_month_year_date, { years: -1 }],
          },
        ],
      },
    },
    {
      block: 'when-arrive-in-uk',
      when: {
        '==': [
          {
            source: 'answers',
            identifier: 'arrive-in-uk-answer',
          },
          null,
        ],
      },
    },
    {
      block: 'when-arrive-in-uk',
      when: {
        '==': [
          {
            date: [
              {
                identifier: 'arrive-in-uk-answer',
                source: 'answers',
              },
            ],
          },
          {
            date: [census_month_year_date, { years: -1 }],
          },
        ],
      },
    },
    {
      block: 'location-one-year-ago',
    },
  ],
}
