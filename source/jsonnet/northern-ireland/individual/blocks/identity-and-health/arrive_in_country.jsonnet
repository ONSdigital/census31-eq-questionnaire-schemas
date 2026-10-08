local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title) = {
  id: 'arrive-in-country-question',
  title: title,
  type: 'General',
  answers: [
    {
      id: 'arrive-in-country-answer',
      mandatory: false,
      type: 'YearDate',
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
          SINGLE_DATE_PERIOD_TOO_EARLY: 'Enter a year of arrival after %(min)s',
          SINGLE_DATE_PERIOD_TOO_LATE: 'Enter a year of arrival before %(max)s',
        },
      },
    },
  ],
};

local nonProxyTitle = 'What year did you come to live in Northern Ireland?';
local proxyTitle = {
  text: 'What year did <strong>{person_name}</strong> come to live in Northern Ireland?',
  placeholders: [
    placeholders.personName(),
  ],
};

{
  type: 'Question',
  id: 'arrive-in-country',
  page_title: 'Arrived to live in Northern Ireland',
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
      block: 'passports',
      when: rules.under1,
    },
    {
      block: 'passports',
      when: rules.lastBirthdayAgeLessThan(1),
    },
    {
      block: 'location-one-year-ago',
    },
  ],
}
