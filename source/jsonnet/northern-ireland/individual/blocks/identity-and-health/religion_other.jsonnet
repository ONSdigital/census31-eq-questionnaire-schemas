local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title) = {
  id: 'religion-other-question',
  title: title,
  type: 'General',
  answers: [
    {
      id: 'religion-other-answer',
      label: 'Religion',
      description: 'Enter your own answer or select from suggestions',
      max_length: 100,
      mandatory: false,
      suggestions: { url: '{suggestions_url_root}/religions.json' },
      type: 'TextField',
    },
  ],
};

{
  type: 'Question',
  id: 'religion-other',
  page_title: 'Other religion',
  question_variants: [
    {
      question: question('You selected “Other”. What religion, religious denomination or body do you belong to?'),
      when: rules.isNotProxy,
    },
    {
      question: question({
        text: 'You selected “Other”. What religion, religious denomination or body does <strong>{person_name}</strong> belong to?',
        placeholders: [
          placeholders.personName(),
        ],
      }),
      when: rules.isProxy,
    },
  ],
  routing_rules: [
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
