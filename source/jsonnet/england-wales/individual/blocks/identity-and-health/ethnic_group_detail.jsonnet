local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local nonProxyTitle = 'Selecting all that apply, how would you describe your ethnic group? Question 2 of 2';
local proxyTitle = {
  text: 'Selecting all that apply, how would <strong>{person_name}</strong> describe their ethnic group? Question 2 of 2',
  placeholders: [
    placeholders.personName(),
  ],
};

local nonProxyGuidance = 'Why your answer is important';
local proxyGuidance = 'Why their answer is important';

local nonProxyDescription = 'Your answer will provide a better understanding of your community and help to support equality and fairness. For example, councils and government use information on ethnic group to make sure they';
local proxyDescription = 'Their answer will provide a better understanding of their community and help to support equality and fairness. For example, councils and government use information on ethnic group to make sure they';

local question(title, guidance, description) = (
  {
    id: 'ethnic-group-detail-question',
    title: title,
    type: 'General',
    answers: [
      {
        guidance: {
          show_guidance: guidance,
          hide_guidance: guidance,
          contents: [
            {
              description: description,
              list: [
                'provide services and share funding fairly',
                'understand and represent everyone’s interests',
              ],
            },
          ],
        },
        id: 'ethnic-group-detail-answer',
        mandatory: false,
        options: [
          {
            label: 'African',
            value: 'African',
          },
          {
            label: 'Arab',
            value: 'Arab',
          },
          {
            label: 'Bangladeshi',
            value: 'Bangladeshi',
          },
          {
            label: 'British',
            value: 'British',
          },
          {
            label: 'Caribbean',
            value: 'Caribbean',
          },
          {
            label: 'Chinese',
            value: 'Chinese',
          },
          {
            label: 'English',
            value: 'English',
          },
          {
            label: 'Gypsy or Irish Traveller',
            value: 'Gypsy or Irish Traveller',
          },
          {
            label: 'Indian',
            value: 'Indian',
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
            label: 'Pakistani',
            value: 'Pakistani',
          },
          {
            label: 'Roma',
            value: 'Roma',
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
            label: 'Any other ethnic group',
            value: 'Any other ethnic group',
          },
        ],
        type: 'Checkbox',
      },
    ],
  }
);

{
  type: 'Question',
  id: 'ethnic-group-detail',
  page_title: 'Ethnic Group Detail',
  question_variants: [
    {
      question: question(nonProxyTitle, nonProxyGuidance, nonProxyDescription),
      when: rules.isNotProxy,
    },
    {
      question: question(proxyTitle, proxyGuidance, proxyDescription),
      when: rules.isProxy,
    },
  ],
  routing_rules: [
    {
      block: 'ethnic-group-african',
      when: {
        'in': [
          'African',
          {
            identifier: 'ethnic-group-detail-answer',
            source: 'answers',
          },
        ],
      },
    },
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
