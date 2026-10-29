local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local nonProxyTitle = 'What is your ethnic group?';
local proxyTitle = {
  text: 'How would <strong>{person_name}</strong> describe their ethnic group? Question 1 of 2',
  placeholders: [
    placeholders.personName(),
  ],
};

local nonProxyGuidance = 'Why your answer is important';
local proxyGuidance = 'Why their answer is important';

local nonProxyDescription = 'Your answer will provide a better understanding of your community and help to support equality and fairness. For example, councils and government use information on ethnic group to make sure they';
local proxyDescription = 'Their answer will provide a better understanding of their community and help to support equality and fairness. For example, councils and government use information on ethnic group to make sure they';


local question(title, description) = {
  id: 'ethnic-group-question',
  title: title,
  type: 'General',
  answers: [
    {
      id: 'ethnic-group-answer',
      mandatory: false,
      options: [
        {
          label: 'Asian',
          value: 'Asian',
        },
        {
          label: 'Black',
          value: 'Black',
        },
        {
          label: 'Mixed Asian and White',
          value: 'Mixed Asian and White',
        },
        {
          label: 'Mixed Black and White',
          value: 'Mixed Black and White',
        },
        {
          label: 'Mixed other',
          value: 'Mixed other',
        },
        {
          label: 'White, any country',
          value: 'White, any country',
        },
        {
          label: 'None of the above',
          value: 'None of the above',
        },
      ],
      type: 'Radio',
    },
  ],
};

{
  type: 'Question',
  id: 'ethnic-group',
  page_title: 'Ethnic group',
  question_variants: [
    {
      question: question(nonProxyTitle, nonProxyDescription),
      when: rules.isNotProxy,
    },
    {
      question: question(proxyTitle, proxyDescription),
      when: rules.isProxy,
    },
  ],
  routing_rules: [
    {
      block: 'ethnic-group-detail',
    },
  ],
}
