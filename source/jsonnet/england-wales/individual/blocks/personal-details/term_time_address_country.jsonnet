{
  type: 'Question',
  id: 'term-time-address-country',
  page_title: 'Term-time address country',
  question: {
    id: 'term-time-address-country-question',
    title: 'Is this address in the UK?',
    type: 'General',
    answers: [
      {
        id: 'term-time-address-country-answer',
        mandatory: false,
        options: [
          {
            label: 'Yes',
            value: 'Yes',
          },
          {
            label: 'No',
            value: 'No',
          },
        ],
        type: 'Radio',
      },
    ],
  },
  routing_rules: [
    {
      block: 'term-time-address-uk',
      when: {
        '==': [
          {
            source: 'answers',
            identifier: 'term-time-address-country-answer',
          },
          'Yes',
        ],
      },
    },
    {
      block: 'term-time-address-country-outside-uk',
      when: {
        '==': [
          {
            source: 'answers',
            identifier: 'term-time-address-country-answer',
          },
          'No',
        ],
      },
    },
    {
      section: 'End',

    },
  ],
}
