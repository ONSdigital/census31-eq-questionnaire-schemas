local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local nonProxyTitle = 'What is your main language?';
local proxyTitle = {
  text: 'What is <strong>{person_name_possessive}</strong> main language?',
  placeholders: [
    placeholders.personNamePossessive,
  ],
};

local nonProxyDefinitionDescription = 'Main language is your first or preferred language.';
local proxyDefinitionDescription = 'Main language is their first or preferred language.';

local question(title, definitionDescription) = {
  id: 'main-language-question',
  title: title,
  type: 'General',
  definitions: [{
    title: 'What we mean by “main language”',
    contents: [
      {
        description: definitionDescription,
      },
    ],
  }],
  answers: [
    {
      id: 'main-language-answer',
      mandatory: false,
      type: 'Radio',
      options: [
        {
          label: 'English',
          value: 'English',
        },
        {
          label: 'Other, including British or Irish Sign Language',
          value: 'Other, including British or Irish Sign Language',
          description: 'You can enter your main language on the next question',
        },
      ],
    },
  ],
};

{
  type: 'Question',
  id: 'main-language',
  page_title: 'Main language',
  question_variants: [
    {
      question: question(nonProxyTitle, nonProxyDefinitionDescription),
      when: rules.isNotProxy,
    },
    {
      question: question(proxyTitle, proxyDefinitionDescription),
      when: rules.isProxy,
    },
  ],
  routing_rules: [
    {
      block: 'other-main-language',
      when: {
        '==': [
          {
            source: 'answers',
            identifier: 'main-language-answer',
          },
          'Other, including British or Irish Sign Language',
        ],
      },
    },
    {
      block: 'understand-irish',
      when: {
        '==': [
          {
            source: 'answers',
            identifier: 'main-language-answer',
          },
          'English',
        ],
      },
    },
    {
      block: 'level-of-spoken-english',
    },
  ],
}
