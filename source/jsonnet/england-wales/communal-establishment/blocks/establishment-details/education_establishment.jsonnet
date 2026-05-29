local placeholders = import '../../../lib/placeholders.libsonnet';

{
  type: 'Question',
  id: 'education-establishment',
  page_title: 'Type of education establishment',
  question: {
    id: 'education-establishment-question',
    title: {
      text: 'What type of education establishment is <strong>{household_address}</strong>?',
      placeholders: [
        placeholders.address,
      ],
    },
    type: 'General',
    answers: [{
      id: 'education-establishment-answer',
      mandatory: false,
      options: [
        {
          label: 'School',
          value: 'School',
        },
        {
          label: 'University',
          value: 'University',
          description: 'For example, hall of residence',
        },
        {
          label: 'Other education establishment',
          value: 'Other education establishment',
        },
      ],
      type: 'Radio',
    }],
  },
  routing_rules: [
    {
        block: 'responsible-for-establishment',
    },
  ],
}
