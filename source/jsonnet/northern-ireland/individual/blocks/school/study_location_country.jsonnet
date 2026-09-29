local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title) = {
  id: 'study-location-country-question',
  title: title,
  type: 'General',
  answers: [
    {
      id: 'study-location-country-answer',
      label: 'Current name of country',
      description: 'Enter your own answer or select from suggestions',
      suggestions: { url: '{suggestions_url_root}/countries-of-birth.json' },
      mandatory: false,
      type: 'TextField',
    },
  ],
};

{
  type: 'Question',
  id: 'study-location-country',
  page_title: 'Country of study',
  question_variants: [
    {
      question: question('In which country is your course of <strong>study</strong>, including school?'),
      when: rules.isNotProxy,
    },
    {
      question: question({
        text: 'In which country is <strong>{person_name_possessive}</strong> course of <strong>study</strong>, including school?',
        placeholders: [
          placeholders.personNamePossessive,
        ],
      }),
      when: rules.isProxy,
    },
  ],
  routing_rules: [
    {
      block: 'travel-to-study-location',
    },
  ],
}
