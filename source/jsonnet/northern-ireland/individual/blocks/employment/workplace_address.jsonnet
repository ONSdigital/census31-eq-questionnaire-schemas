local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title) = {
  id: 'workplace-address-question',
  type: 'General',
  title: title,
  answers: [
    {
      id: 'workplace-address-answer',
      mandatory: true,
      type: 'Address',
      lookup_options: {
        address_type: 'Workplace',
        region_code: std.extVar('region_code'),
      },
    },
  ],
};

local nonProxyTitleWork = 'What is the address of your main place of <strong>work</strong>?';
local proxyTitleWork = {
  text: 'What is the address of <strong>{person_name_possessive}</strong> main place of <strong>work</strong>?',
  placeholders: [
    placeholders.personNamePossessive,
  ],
};

local pastNonProxyTitleWork = 'What was the address of your main place of <strong>work</strong>?';
local pastProxyTitleWork = {
  text: 'What was the address of <strong>{person_name_possessive}</strong> main place of <strong>work</strong>?',
  placeholders: [
    placeholders.personNamePossessive,
  ],
};


{
  type: 'Question',
  id: 'workplace-address',
  page_title: 'Workplace address',
  question_variants: [
    {
      question: question(nonProxyTitleWork),
      when: { and: [rules.isNotProxy, rules.mainJob] },
    },
    {
      question: question(proxyTitleWork),
      when: { and: [rules.isProxy, rules.mainJob] },
    },
    {
      question: question(pastNonProxyTitleWork),
      when: rules.isNotProxy,
    },
    {
      question: question(pastProxyTitleWork),
      when: rules.isProxy,
    },
  ],
}
