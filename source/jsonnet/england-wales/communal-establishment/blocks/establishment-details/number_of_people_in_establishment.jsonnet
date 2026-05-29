local question = {
  id: 'number-of-people-in-establishment-question',
  title: 'How many people are currently living in this establishment?',
  type: 'General',
  guidance: {
    contents: [
      {
        description: '<strong>Include</strong> everyone from the groups you selected for the previous question',
      },
      {
        description: '<strong>Do not include</strong> visitors who have another UK address, or usually live outside the UK and intend to stay in the UK for 3 months or less',
      },
    ],
  },
  answers: [{
    id: 'number-of-people-in-establishment-answer',
    label: 'Number of residents',
    mandatory: false,
    type: 'Number',
    minimum: {
      value: 0,
    },
  }],
};

local questionWithExclusive = {
  id: 'number-of-people-in-establishment-question',
  title: 'How many people are currently living in this establishment?',
  type: 'MutuallyExclusive',
  mandatory: false,
  guidance: {
    contents: [
      {
        description: '<strong>Do not include</strong> visitors who have another UK address, or usually live outside the UK and intend to stay in the UK for 3 months or less',
      },
    ],
  },
  answers: [
    {
      id: 'number-of-people-in-establishment-answer',
      label: 'Number of residents',
      mandatory: false,
      type: 'Number',
      minimum: {
        value: 0,
      },
    },
    {
      id: 'number-of-people-in-establishment-answer-exclusive',
      type: 'Checkbox',
      mandatory: false,
      options: [
        {
          label: 'No one is living in this establishment',
          value: 'No one is living in this establishment',
        },
      ],
    },
  ],
};

{
  type: 'Question',
  id: 'number-of-people-in-establishment',
  page_title: 'Number of people who live in this establishment',
  question_variants: [
    {
      question: question,
      when: {
        '!=': [
          {
              source: 'answers',
              identifier: 'people-in-establishment-answer',
          },
          null
        ],
      },
    },
    {
      question: questionWithExclusive,
      when: {
        '!=': [
          {
              source: 'answers',
              identifier: 'people-in-establishment-exclusive',
          },
          null
        ],
      },
    },
    {
      question: questionWithExclusive,
      when: {
        '==': [
          {
              source: 'answers',
              identifier: 'people-in-establishment-answer',
          },
          null
        ],
      },
    },
  ],
}
