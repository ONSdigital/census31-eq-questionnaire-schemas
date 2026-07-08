local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title) = {
  id: 'marital-or-civil-partnership-status-question',
  title: title,
  type: 'General',
  answers: [
    {
      id: 'marital-or-civil-partnership-status-answer',
      mandatory: false,
      options: [
        {
          label: 'Never married and never registered a civil partnership',
          value: 'Never married and never registered a civil partnership',
        },
        {
          label: 'Married',
          value: 'Married',
        },
        {
          label: 'In a registered civil partnership',
          value: 'In a registered civil partnership',
        },
        {
          label: 'Separated, but still legally married',
          value: 'Separated, but still legally married',
        },
        {
          label: 'Separated, but still legally in a civil partnership',
          value: 'Separated, but still legally in a civil partnership',
        },
        {
          label: 'Divorced',
          value: 'Divorced',
        },
        {
          label: 'Formerly in a civil partnership which is now legally dissolved',
          value: 'Formerly in a civil partnership which is now legally dissolved',
        },
        {
          label: 'Widowed',
          value: 'Widowed',
        },
        {
          label: 'Surviving partner from a registered civil partnership',
          value: 'Surviving partner from a registered civil partnership',
        },
      ],
      type: 'Radio',
    },
  ],
};

local routingRule(blockId, whenValue) = {
  block: blockId,
  when: {
    '==': [
      {
        source: 'answers',
        identifier: 'marital-or-civil-partnership-status-answer',
      },
      whenValue,
    ],
  },
};

local nonProxyTitle = {
  text: 'On {census_date}, what is your legal marital or registered civil partnership status?',
  placeholders: [
    placeholders.censusDate,
  ],
};
local proxyTitle = {
  text: 'On {census_date}, what is <strong>{person_name_possessive}</strong> legal marital or registered civil partnership status?',
  placeholders: [
    placeholders.censusDate,
    placeholders.personNamePossessive,
  ],
};

{
  type: 'Question',
  id: 'marital-or-civil-partnership-status',
  page_title: 'Legal marital or registered civil partnership status',
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
    routingRule('another-address', 'Never married and never registered a civil partnership'),
    routingRule('sex-of-current-spouse', 'Married'),
    routingRule('sex-of-current-partner', 'In a registered civil partnership'),
    routingRule('sex-of-current-spouse', 'Separated, but still legally married'),
    routingRule('sex-of-current-partner', 'Separated, but still legally in a civil partnership'),
    routingRule('sex-of-previous-spouse', 'Divorced'),
    routingRule('sex-of-previous-partner', 'Formerly in a civil partnership which is now legally dissolved'),
    routingRule('sex-of-previous-spouse', 'Widowed'),
    routingRule('sex-of-previous-partner', 'Surviving partner from a registered civil partnership'),
    {
      block: 'another-address',
    },
  ],
}
