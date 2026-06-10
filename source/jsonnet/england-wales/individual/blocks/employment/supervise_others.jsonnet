local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title) = {
  id: 'supervise-others-question',
  title: title,
  type: 'General',
  description: [
    'This could be remotely or in person',
  ],
  answers: [
    {
      id: 'supervise-others-answer',
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

local nonProxyTitle = 'Do you supervise or oversee the work of other employees on a day-to-day basis?';
local proxyTitle = {
  text: 'Does <strong>{person_name}</strong> supervise or oversee the work of other employees on a day-to-day basis?',
  placeholders: [
    placeholders.personName(),
  ],
};

local pastNonProxyTitle = 'Did you supervise or oversee the work of other employees on a day-to-day basis?';
local pastProxyTitle = {
  text: 'Did <strong>{person_name}</strong> supervise or oversee the work of other employees on a day-to-day basis?',
  placeholders: [
    placeholders.personName(),
  ],
};

{
  type: 'Question',
  id: 'supervise-others',
  page_title: 'Supervise other employees',
  question_variants: [
    {
      question: question(nonProxyTitle),
      when: { and: [rules.isNotProxy, rules.mainJob] },
    },
    {
      question: question(proxyTitle),
      when: { and: [rules.isProxy, rules.mainJob] },
    },
    {
      question: question(pastNonProxyTitle),
      when: { and: [rules.isNotProxy, rules.lastMainJob] },
    },
    {
      question: question(pastProxyTitle),
      when: { and: [rules.isProxy, rules.lastMainJob] },
    },
  ],
  routing_rules: [
    {
      section: 'End',
      when: rules.lastMainJob,
    },
    {
      block: 'hours-worked',
    },
  ],
}
