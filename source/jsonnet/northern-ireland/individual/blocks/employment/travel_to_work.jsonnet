local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title, description) = {
  title: title,
  id: 'travel-to-work-question',
  description: [
    description,
  ],
  type: 'General',
  answers: [
    {
      id: 'travel-to-work-answer',
      mandatory: false,
      options: [
        {
          label: 'Driving a car or van',
          value: 'Driving a car or van',
        },
        {
          label: 'Passenger in a car or van',
          value: 'Passenger in a car or van',
        },
        {
          label: 'Car or van pool, sharing driving',
          value: 'Car or van pool, sharing driving',
        },
        {
          label: 'Bus, minibus or coach',
          value: 'Bus, minibus or coach',
          description: 'This could be public or private',
        },
        {
          label: 'Taxi',
          value: 'Taxi',
        },
        {
          label: 'Train',
          value: 'Train',
        },
        {
          label: 'Motorcycle, scooter or moped',
          value: 'Motorcycle, scooter or moped',
        },
        {
          label: 'Bicycle',
          value: 'Bicycle',
        },
        {
          label: 'On foot',
          value: 'On foot',
        },
        {
          label: 'Other',
          value: 'Other',
        },
      ],
      type: 'Radio',
    },
  ],
};

local nonProxyTitleWork = 'How do you usually travel to your main place of <strong>work</strong>?';
local proxyTitleWork = {
  text: 'How does <strong>{person_name}</strong> usually travel to their main place of <strong>work</strong>?',
  placeholders: [
    placeholders.personName(),
  ],
};

local pastNonProxyTitleWork = 'How did you usually travel to your main place of <strong>work</strong>?';
local pastProxyTitleWork = {
  text: 'How did <strong>{person_name}</strong> usually travel to their main place of <strong>work</strong>?',
  placeholders: [
    placeholders.personName(),
  ],
};

local nonProxyDescriptionWork = 'Answer for the longest part, by distance, of your usual journey to work';
local proxyDescriptionWork = 'Answer for the longest part, by distance, of their usual journey to work';

{
  type: 'Question',
  id: 'travel-to-work',
  page_title: 'Travel to work',
  question_variants: [
    {
      question: question(nonProxyTitleWork, nonProxyDescriptionWork),
      when: { and: [rules.isNotProxy, rules.mainJob] },
    },
    {
      question: question(proxyTitleWork, proxyDescriptionWork),
      when: { and: [rules.isProxy, rules.mainJob] },
    },
    {
      question: question(pastNonProxyTitleWork, nonProxyDescriptionWork),
      when: rules.isNotProxy,
    },
    {
      question: question(pastProxyTitleWork, proxyDescriptionWork),
      when: rules.isProxy,
    },
  ],
  routing_rules: [
    {
        section: 'End',
    },
  ],
}
