local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title) = {
  id: 'study-location-question',
  title: title,
  type: 'General',
  answers: [
    {
      id: 'study-location-answer',
      mandatory: false,
      options: [
        {
          label: 'Yes',
          value: 'Yes',
        },
        {
          label: 'No, it is in another country',
          value: 'No, it is in another country',
        },
      ],
      type: 'Radio',
    },
  ],
};

{
  type: 'Question',
  id: 'study-location',
  page_title: 'Study location',
  question_variants: [
    {
      question: question('Is your place of <strong>study</strong> in Northern Ireland?'),
      when: rules.isNotProxy,
    },
    {
      question: question({
        text: 'Is <strong>{person_name_possessive}</strong> place of <strong>study</strong> in Northern Ireland?',
        placeholders: [
          placeholders.personNamePossessive,
        ],
      }),
      when: rules.isProxy,
    },
  ],
  routing_rules: [
    {
      block: 'study-location-country',
      when: {
        '==': [
          {
            source: 'answers',
            identifier: 'study-location-answer',
          },
          'No, it is in another country',
        ],
      },
    },
    {
      block: 'study-location-in-northern-ireland',
    },
  ],
}
