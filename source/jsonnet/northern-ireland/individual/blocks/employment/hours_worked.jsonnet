local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local questionTitle(isProxy, isEmployed) = (
  local employedTitle = (
    if isProxy then
      {
        text: 'In <strong>{person_name_possessive}</strong> main job, how many hours a week do they usually work?',
        placeholders: [
          placeholders.personNamePossessive,
        ],
      }
    else 'In your main job, how many hours a week do you usually work?'
  );
  local unemployedTitle = (
    if isProxy then
      {
        text: 'In <strong>{person_name_possessive}</strong> main job, how many hours a week did they usually work?',
        placeholders: [
          placeholders.personNamePossessive,
        ],
      }
    else 'In your main job, how many hours a week did you usually work?'
  );

  if isEmployed then employedTitle else unemployedTitle
);

local questionDescription(isProxy, isEmployed) = (
  local employedDescription = (
    if isProxy then
      ['If the <strong>coronavirus</strong> pandemic has affected their working hours, select the answer that best describes their <strong>current circumstances</strong>']
    else
      ['If the <strong>coronavirus</strong> pandemic has affected your working hours, select the answer that best describes your <strong>current circumstances</strong>']
  );

  if isEmployed then employedDescription else []
);

local question(isProxy, isEmployed) = {
  title: questionTitle(isProxy, isEmployed),
  id: 'hours-worked-question',
  guidance: {
    contents: [
      {
        description: 'Include paid and unpaid overtime',
      },
    ],
  },
  type: 'General',
  description: questionDescription(isProxy, isEmployed),
  answers: [
    {
      id: 'hours-worked-answer',
      mandatory: false,
      options: [
        {
          label: '0 to 15 hours a week',
          value: '0 to 15 hours a week',
        },
        {
          label: '16 to 30 hours a week',
          value: '16 to 30 hours a week',
        },
        {
          label: '31 to 48 hours a week',
          value: '31 to 48 hours a week',
        },
        {
          label: '49 hours or more a week',
          value: '49 hours or more a week',
        },
      ],
      type: 'Radio',
    },
  ],
};

{
  type: 'Question',
  id: 'hours-worked',
  page_title: 'Hours worked',
  question_variants: [
    {
      question: question(isProxy=false, isEmployed=true),
      when: { and: [rules.isNotProxy, rules.mainJob] },
    },
    {
      question: question(isProxy=true, isEmployed=true),
      when: { and: [rules.isProxy, rules.mainJob] },
    },
    {
      question: question(isProxy=false, isEmployed=false),
      when: { and: [rules.isNotProxy, rules.lastMainJob] },
    },
    {
      question: question(isProxy=true, isEmployed=false),
      when: { and: [rules.isProxy, rules.lastMainJob] },
    },
  ],
  routing_rules: [
    {
      group: 'school-group',
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
      group: 'school-group',
      when: {
        'in': [
          'Studying',
          {
            source: 'answers',
            identifier: 'not-employed-status-last-seven-days-answer',
          },
        ],
      },
    },
    {
      block: 'workplace-type',
    },
  ],
}
