local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local nonProxyTitle = 'What religion, religious denomination or body were you <strong>brought up</strong> in?';
local proxyTitle = {
  text: 'What religion, religious denomination or body was {person_name} <strong>brought up</strong> in?',
  placeholders: [
    placeholders.personName(),
  ],
};

local question(title) = {
  id: 'childhood-religion-question',
  title: title,
  type: 'MutuallyExclusive',
  mandatory: false,
  answers: [
    {
      id: 'childhood-religion-answer',
      mandatory: false,
      options: [
        {
          label: 'Roman Catholic',
          value: 'Roman Catholic',
        },
        {
          label: 'Presbyterian Church in Ireland',
          value: 'Presbyterian Church in Ireland',
        },
        {
          label: 'Church of Ireland',
          value: 'Church of Ireland',
        },
        {
          label: 'Methodist Church in Ireland',
          value: 'Methodist Church in Ireland',
        },
        {
          label: 'Other',
          value: 'Other',
          description: 'You can enter the religion on the next question',
        },
      ],
      type: 'Checkbox',
    },
    {
      id: 'childhood-religion-answer-exclusive',
      type: 'Checkbox',
      mandatory: false,
      options: [
        {
          label: 'None',
          value: 'None',
        },
      ],
    },
  ],
};

{
  type: 'Question',
  id: 'childhood-religion',
  page_title: 'Childhood religion',
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
      block: 'childhood-religion-other',
      when: {
        'in': [
          'Other',
          {
            source: 'answers',
            identifier: 'childhood-religion-answer',
          },
        ],
      },
    },
    {
      block: 'health',
      when: rules.under3,
    },
    {
      block: 'health',
      when: rules.lastBirthdayAgeLessThan(3),
    },
    {
      block: 'main-language',
    },
  ],
}
