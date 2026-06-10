local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local title(isProxy) = (
  if isProxy then
    {
      text: 'During term time, where does <strong>{person_name}</strong> usually live?',
      placeholders: [
        placeholders.personName(),
      ],
    }
  else 'During term time, where do you usually live?'
);

local answerDescription(isProxy) = (
  if isProxy then
    'Their answer helps us produce an accurate count of the population during term time. These figures can be used to plan services such as healthcare and transport. This is particularly important in areas with large universities and student populations.'
  else 'Your answer helps us produce an accurate count of the population during term time. These figures can be used to plan services such as healthcare and transport. This is particularly important in areas with large universities and student populations.'
);

local question(options, isProxy) = {
  id: 'term-time-location-question',
  type: 'General',
  title: title(isProxy),
  answers: [
    {
      id: 'term-time-location-answer',
      mandatory: true,
      type: 'Radio',
      guidance: {
        show_guidance: 'Why we ask for term-time address',
        hide_guidance: 'Why we ask for term-time address',
        contents: [
          {
            description: answerDescription(isProxy),
          },
        ],
      },
    } + options,
  ],
};

local noOtherAddressOptions = {
  options: [
    {
      label: {
        text: '{household_address}',
        placeholders: [
          placeholders.address,
        ],
      },
      value: '{household_address}',
    },
    {
      label: 'Another address',
      value: 'Another address',
    },
  ],
};

local otherUkAddressOptions = {
  options: [
    {
      label: {
        text: '{household_address}',
        placeholders: [
          placeholders.address,
        ],
      },
      value: '{household_address}',
    },
    {
      label: {
        text: '{thirty_day_address}',
        placeholders: [
          {
            placeholder: 'thirty_day_address',
            value: {
              identifier: 'other-address-uk-answer',
              source: 'answers',
              selector: 'line1',
            },
          },
        ],
      },
      value: '{thirty_day_address}',
    },
    {
      label: 'Another address',
      value: 'Another address',
    },
  ],
};

local otherNonUkAddressOptions = {
  options: [
    {
      label: {
        text: '{household_address}',
        placeholders: [
          placeholders.address,
        ],
      },
      value: '{household_address}',
    },
    {
      label: {
        text: 'The address in {thirty_day_address_country}',
        placeholders: [
          {
            placeholder: 'thirty_day_address_country',
            value: {
              source: 'answers',
              identifier: 'another-address-outside-uk-answer',
            },
          },
        ],
      },
      value: 'The address in {thirty_day_address_country}',
    },
    {
      label: 'Another address',
      value: 'Another address',
    },
  ],
};

{
  type: 'Question',
  id: 'term-time-location',
  page_title: 'Term-time location',
  question_variants: [
    {
      question: question(otherNonUkAddressOptions, isProxy=false),
      when: {
        and: [
          rules.isNotProxy,
          {
            '==': [
              {
                source: 'answers',
                identifier: 'another-address-answer',
              },
              'Yes, an address outside the UK',
            ],
          },
        ],
      },
    },
    {
      question: question(otherNonUkAddressOptions, isProxy=true),
      when: {
        and: [
          rules.isProxy,
          {
            '==': [
              {
                source: 'answers',
                identifier: 'another-address-answer',
              },
              'Yes, an address outside the UK',
            ],
          },
        ],
      },
    },
    {
      question: question(otherUkAddressOptions, isProxy=false),
      when: {
        and: [
          rules.isNotProxy,
          {
            '==': [
              {
                source: 'answers',
                identifier: 'another-address-answer',
              },
              'Yes, an address within the UK',
            ],
          },
        ],
      },
    },
    {
      question: question(otherUkAddressOptions, isProxy=true),
      when: {
        and: [
          rules.isProxy,
          {
            '==': [
              {
                source: 'answers',
                identifier: 'another-address-answer',
              },
              'Yes, an address within the UK',
            ],
          },
        ],
      },
    },
    {
      question: question(noOtherAddressOptions, isProxy=false),
      when: rules.isNotProxy,
    },
    {
      question: question(noOtherAddressOptions, isProxy=true),
      when: rules.isProxy,
    },
  ],
  routing_rules: [
    {
      group: 'identity-and-health-group',
      when: {
        '==': [
          {
            source: 'answers',
            identifier: 'term-time-location-answer',
          },
          '{household_address}',
        ],
      },
    },
    {
      section: 'End',
      when: {
        'in': [
          {
            identifier: 'term-time-location-answer',
            source: 'answers',
          },
          [
            '{thirty_day_address}',
            'The address in {thirty_day_address_country}',
          ],
        ],
      },
    },
    {
      block: 'term-time-address-country',
      when: {
        and: [
          {
            '==': [
              {
                source: 'answers',
                identifier: 'another-address-answer',
              },
              'No',
            ],
          },
          {
            '==': [
              {
                source: 'answers',
                identifier: 'term-time-location-answer',
              },
              'Another address',
            ],
          },
        ],
      },
    },
    {
      block: 'term-time-address-country',
      when: {
        and: [
          {
            '==': [
              {
                source: 'answers',
                identifier: 'another-address-answer',
              },
              null,
            ],
          },
          {
            '==': [
              {
                source: 'answers',
                identifier: 'term-time-location-answer',
              },
              'Another address',
            ],
          },
        ],
      },
    },
    {
      section: 'End',
      when: {
        and: [
          {
            '==': [
              {
                source: 'answers',
                identifier: 'term-time-location-answer',
              },
              'Another address',
            ],
          },
          {
            '==': [
              {
                source: 'answers',
                identifier: 'another-address-answer',
              },
              'Yes, an address within the UK',
            ],
          },
        ],
      },
    },
    {
      section: 'End',
      when: {
        and: [
          {
            '==': [
              {
                source: 'answers',
                identifier: 'term-time-location-answer',
              },
              'Another address',
            ],
          },
          {
            '==': [
              {
                source: 'answers',
                identifier: 'another-address-answer',
              },
              'Yes, an address outside the UK',
            ],
          },
        ],
      },
    },
    {
      group: 'identity-and-health-group',
    },
  ],
}
