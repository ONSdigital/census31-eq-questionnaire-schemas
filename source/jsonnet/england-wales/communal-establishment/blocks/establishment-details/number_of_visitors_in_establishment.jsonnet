local placeholders = import '../../../lib/placeholders.libsonnet';

local question = {
  id: 'number-of-visitors-in-establishment-question',
  title: {
    text: 'How many visitors are staying overnight in this establishment on {census_date}?',
    placeholders: [
      placeholders.censusDate,
    ],
  },
  type: 'General',
  guidance: {
    contents: [{
      description: '<strong>Include</strong> everyone from the groups you selected for the previous question',
    }],
  },
  answers: [
    {
      id: 'number-of-visitors-in-establishment-answer',
      label: 'Number of visitors',
      mandatory: false,
      type: 'Number',
      minimum: {
        value: 0,
      },
    },
  ],
};

local questionWithExclusive = {
  id: 'number-of-visitors-in-establishment-question',
  title: {
    text: 'How many visitors are staying overnight in this establishment on {census_date}?',
    placeholders: [
      placeholders.censusDate,
    ],
  },
  type: 'MutuallyExclusive',
  mandatory: false,
  answers: [
    {
      id: 'number-of-visitors-in-establishment-answer',
      label: 'Number of visitors',
      mandatory: false,
      type: 'Number',
      minimum: {
        value: 0,
      },
    },
    {
      id: 'number-of-visitors-in-establishment-answer-exclusive',
      type: 'Checkbox',
      mandatory: false,
      options: [
        {
          label: 'No visitors are staying overnight',
          value: 'No visitors are staying overnight',
        },
      ],
    },
  ],
};

{
  type: 'Question',
  id: 'number-of-visitors-in-establishment',
  page_title: 'Number of visitors staying in this establishment',
  question_variants: [
    {
      question: questionWithExclusive,
      when: {
        '!=': [
          {
              source: 'answers',
              identifier: 'visitors-in-establishment-exclusive',
          },
          null
        ],
      },
    },
    {
      question: question,
      when: {
        '!=': [
          {
              source: 'answers',
              identifier: 'visitors-in-establishment-answer',
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
              identifier: 'visitors-in-establishment-answer',
          },
          null
        ],
      },
    },
  ],
}
