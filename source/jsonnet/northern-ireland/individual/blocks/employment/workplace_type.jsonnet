local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title, description) = {
  title: title,
  id: 'workplace-type-question',
  description: [
    description,
  ],
  type: 'General',
  answers: [
    {
      id: 'workplace-type-answer',
      mandatory: true,
      options: [
        {
          label: 'At a workplace',
          value: 'At a workplace',
        },
        {
          label: 'At or from home',
          value: 'At or from home',
        },
        {
          label: 'No fixed place',
          value: 'No fixed place',
        },
      ],
      type: 'Radio',
    },
  ],
};


  local nonProxyTitleWork = 'Where is your main place of <strong>work</strong>?';
local proxyTitleWork = {
  text: 'Where is <strong>{person_name_possessive}</strong> main place of <strong>work</strong>?',
  placeholders: [
    placeholders.personNamePossessive,
  ],
};
  local nonProxyTitleDidWork = 'Where did you mainly <strong>work</strong>?';
local proxyTitleDidWork = {
  text: 'Where did <strong>{person_name}</strong> mainly <strong>work</strong>?',
  placeholders: [
    placeholders.personName(),
  ],
};

local nonProxyDescriptionWork = 'Answer for the place where you spend the most time. Even if ill, on maternity leave, holiday or temporarily laid off provide details of your main place of work.';
  local proxyDescriptionWork = {
  text: 'Answer for the place where <strong>{person_name}</strong> spends the most time. Even if ill, on maternity leave, holiday or temporarily laid off provide details of their main place of work.',
  placeholders: [
    placeholders.personName(),
  ],
};

local nonProxyDescriptionDidWork = 'Answer for the place where you spent the most time.';
local proxyDescriptionDidWork = {
  text: 'Answer for the place where <strong>{person_name}</strong> spent the most time.',
  placeholders: [
    placeholders.personName(),
  ],
};

{
  type: 'Question',
  id: 'workplace-type',
  page_title: 'Type of workplace',
  question_variants: [
    {
      question: question(nonProxyTitleWork, nonProxyDescriptionWork),
      when: { and: [rules.isNotProxy, rules.mainJob] },
    },
    {
      question: question(proxyTitleWork, proxyDescriptionWork),
      when: { and: [rules.isProxy, rules.mainJob] },
    },
    {
      question: question(nonProxyTitleDidWork, nonProxyDescriptionDidWork),
      when: rules.isNotProxy,
    },
    {
      question: question(proxyTitleDidWork, proxyDescriptionDidWork),
      when: rules.isProxy,
    },
  ],
  routing_rules: [
    {
      block: 'workplace-location',
      when: {
        '==': [
          {
            source: 'answers',
            identifier: 'workplace-type-answer',
          },
          'At a workplace',
        ],
      },
    },
    {
      block: 'travel-to-work',
      when: {
        '==': [
          {
            source: 'answers',
            identifier: 'workplace-type-answer',
          },
          'No fixed place',
        ],
      },
    },
    {
      section: 'End',
    },
  ],
}
