local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title) = {
  id: 'ethnic-group-african-question',
  title: title,
  type: 'General',
  answers: [
    {
      id: 'ethnic-group-african-answer',
      label: 'African ethnic group or background',
      description: 'Enter your own answer or select from suggestions',
      max_length: 100,
      mandatory: false,
      suggestions: { url: '{suggestions_url_root}/ethnic-groups.json' },
      type: 'TextField',
    },
  ],
};
{
  type: 'Question',
  id: 'ethnic-group-african',
  page_title: 'Other African ethnic group or background',
  question_variants: [
    {
      question: question('You selected ‘African’. How would you describe your African ethnic group, for example your tribe or country?'),
      when: rules.isNotProxy,
    },
    {
      question: question({
        text: 'You selected ‘African’. How would <strong>{person_name}</strong> describe their African ethnic group, for example their tribe or country?',
        placeholders: [
          placeholders.personName(),
        ],
      }),
      when: rules.isProxy,
    },
  ],
  routing_rules: [
    {
      block: 'ethnic-group-other',
      when: {
        'in': [
          'Any other ethnic group',
          {
            identifier: 'ethnic-group-detail-answer',
            source: 'answers',
          },
        ],
      },
    },
    {
      block: 'religion',
    },
  ],
}
