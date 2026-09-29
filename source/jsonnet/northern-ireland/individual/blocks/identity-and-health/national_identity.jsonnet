local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local nonProxyTitle = 'How would you describe your national identity?';
local proxyTitle = {
  text: 'How would <strong>{person_name}</strong> describe their national identity?',
  placeholders: [
    placeholders.personName(),
  ],
};

local question(title, otherDescription) = {
  id: 'national-identity-question',
  title: title,
  type: 'General',
  answers: [
    {
      id: 'national-identity-answer',
      mandatory: false,
      type: 'Checkbox',
      options: [
        {
          label: 'British',
          value: 'British',
        },
        {
          label: 'Irish',
          value: 'Irish',
        },
        {
          label: 'Northern Irish',
          value: 'Northern Irish',
        },
        {
          label: 'English',
          value: 'English',
        },
        {
          label: 'Scottish',
          value: 'Scottish',
        },
        {
          label: 'Welsh',
          value: 'Welsh',
        },
        {
          label: 'Other',
          value: 'Other',
          description: otherDescription,
        },
      ],
    },
  ],
};

{
  type: 'Question',
  id: 'national-identity',
  page_title: 'National identity',
  question_variants: [
    {
      question: question(nonProxyTitle, 'You can enter your national identity on the next question'),
      when: rules.isNotProxy,
    },
    {
      question: question(proxyTitle, 'You can enter their national identity on the next question'),
      when: rules.isProxy,
    },
  ],
  routing_rules: [
    {
      block: 'other-national-identities',
      when: {
        and: [
          {
            'any-in': [
              ['British', 'Irish', 'Northern Irish', 'English', 'Scottish', 'Welsh'],
              {
                source: 'answers',
                identifier: 'national-identity-answer',
              },
            ],
          },
          {
            'in': [
              'Other',
              {
                source: 'answers',
                identifier: 'national-identity-answer',
              },
            ],
          },
        ],
      },
    },
    {
      block: 'other-national-identity',
      when: {
        'in': [
          'Other',
          {
            source: 'answers',
            identifier: 'national-identity-answer',
          },
        ],
      },
    },
    {
      block: 'ethnic-group',
    },
  ],
}
