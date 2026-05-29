local placeholders = import '../../../lib/placeholders.libsonnet';

{
  type: 'Question',
  id: 'detention-establishment',
  page_title: 'Type of detention establishment',
  question: {
    id: 'detention-establishment-question',
    title: {
      text: 'What type of detention establishment is <strong>{household_address}</strong>?',
      placeholders: [
        placeholders.address,
      ],
    },
    type: 'General',
    answers: [{
      id: 'detention-establishment-answer',
      mandatory: false,
      options: [
        {
          label: 'Prison service establishment',
          value: 'Prison service establishment',
          description: 'Including young offender institutions',
        },
        {
          label: 'Approved premises',
          value: 'Approved premises',
          description: 'Probation or bail hostel',
        },
        {
          label: 'Detention centre',
          value: 'Detention centre',
        },
        {
          label: 'Other detention establishment',
          value: 'Other detention establishment',
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
