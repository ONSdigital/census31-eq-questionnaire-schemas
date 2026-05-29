{
  type: 'Question',
  id: 'nature-of-establishment',
  page_title: 'Type of establishment',
  question: {
    id: 'nature-of-establishment-question',
    title: 'What is the nature of this establishment?',
    type: 'General',
    answers: [{
      id: 'nature-of-establishment-answer',
      mandatory: true,
      options: [
        {
          label: 'Medical or care',
          value: 'Medical or care',
          description: 'For example, care homes, children’s homes or hospitals',
        },
        {
          label: 'Education',
          value: 'Education',
          description: 'Including halls of residence',
        },
        {
          label: 'Armed forces',
          value: 'Armed forces',
          description: 'Defence establishments, including ships',
        },
        {
          label: 'Detention',
          value: 'Detention',
          description: 'For example, prisons or approved premises',
        },
        {
          label: 'Travel or temporary accommodation',
          value: 'Travel or temporary accommodation',
          description: 'Includes shelters for homeless people',
        },
        {
          label: 'Religious establishment',
          value: 'Religious establishment',
        },
        {
          label: 'Staff or worker accommodation only',
          value: 'Staff or worker accommodation only',
        },
        {
          label: 'Other establishment',
          value: 'Other establishment',
        },
      ],
      type: 'Radio',
    }],
  },
  routing_rules: [
    {
        block: 'medical-establishment',
        when: {
          "==": [
              {
                  "source": "answers",
                  "identifier": "nature-of-establishment-answer"
              },
              "Medical or care"
          ]
        },
    },
    {
        block: 'education-establishment',
        when: {
          "==": [
              {
                  "source": "answers",
                  "identifier": "nature-of-establishment-answer"
              },
              "Education"
          ]
        },
    },
    {
        block: 'detention-establishment',
        when: {
          "==": [
              {
                  "source": "answers",
                  "identifier": "nature-of-establishment-answer"
              },
              "Detention"
          ]
        },
    },
    {
        block: 'travel-establishment',
        when: {
          "==": [
              {
                  "source": "answers",
                  "identifier": "nature-of-establishment-answer"
              },
              "Travel or temporary accommodation"
          ]
        },
    },
    {
        block: 'responsible-for-establishment',
    },
  ],
}
