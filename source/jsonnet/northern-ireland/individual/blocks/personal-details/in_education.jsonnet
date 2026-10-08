local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title) = {
  id: 'in-education-question',
  title: title,
  type: 'General',
  answers: [
    {
      id: 'in-education-answer',
      mandatory: true,
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


local nonProxyUnder16Title = 'Are you a schoolchild or student in full-time education?';
local proxyUnder16Title = {
  text: 'Is <strong>{person_name}</strong> a schoolchild or student in full-time education?',
  placeholders: [
    placeholders.personName(),
  ],
};
local nonProxyOver16Title = 'Are you a student in full-time education?';
local proxyOver16Title = {
  text: 'Is <strong>{person_name}</strong> a student in full-time education?',
  placeholders: [
    placeholders.personName(),
  ],
};

{
  type: 'Question',
  id: 'in-education',
  page_title: 'Student in full-time education',
  question_variants: [
    {
      question: question(nonProxyOver16Title),
      when: { and: [rules.isNotProxy, rules.over16] },
    },
    {
      question: question(proxyOver16Title),
      when: { and: [rules.isProxy, rules.over16] },
    },
    {
      question: question(nonProxyOver16Title),
      when: { and: [rules.isNotProxy, rules.lastBirthdayAgeOver(16)] },
    },
    {
      question: question(proxyOver16Title),
      when: { and: [rules.isProxy, rules.lastBirthdayAgeOver(16)] },
    },
    {
      question: question(nonProxyUnder16Title),
      when: rules.isNotProxy,
    },
    {
      question: question(proxyUnder16Title),
      when: rules.isProxy,
    },
  ],
  routing_rules: [
    {
      block: 'term-time-location',
      when: {
        '==': [
          {
            source: 'answers',
            identifier: 'in-education-answer',
          },
          'Yes',
        ],
      },
    },
    {
      group: 'identity-and-health-group',
    },
  ],
}
