local placeholders = import '../../../lib/placeholders.libsonnet';

{
  type: 'Question',
  id: 'medical-establishment',
  page_title: 'Type of medical or care establishment',
  question: {
    id: 'medical-establishment-question',
    title: {
      text: 'What type of medical or care establishment is <strong>{household_address}</strong>?',
      placeholders: [
        placeholders.address,
      ],
    },
    type: 'General',
    answers: [{
      id: 'medical-establishment-answer',
      mandatory: false,
      options: [
        {
          label: 'Care home without nursing',
          value: 'Care home without nursing',
        },
        {
          label: 'Care home with nursing',
          value: 'Care home with nursing',
        },
        {
          label: 'Children’s home',
          value: 'Children’s home',
          description: 'Including secure units',
        },
        {
          label: 'General hospital',
          value: 'General hospital',
        },
        {
          label: 'Mental health hospital or unit',
          value: 'Mental health hospital or unit',
          description: 'Including secure units',
        },
        {
          label: 'Other hospital',
          value: 'Other hospital',
        },
        {
          label: 'Other medical or care establishment',
          value: 'Other medical or care establishment',
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
