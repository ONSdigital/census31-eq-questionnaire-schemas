local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

{
  type: 'Question',
  id: 'consent-contact-type',
  page_title: 'Consent contact details',
  mandatory: true,
  question: {
    type: 'General',
    id: 'consent-contact-type-question',
    title: 'How would you prefer to be contacted to take part in future research?',
    description: ['Your contact details will not be used for any other purposes.'],
    answers: [
      {
        id: 'consent-contact-type-answer',
        mandatory: false,
        type: 'Checkbox',
        options: [
          {
            label: 'Email',
            value: 'Email',
            detail_answer: {
              id: 'consent-contact-type-answer-email-input',
              label: 'Email address',
              mandatory: false,
              visible: false,
              type: 'TextField',
              max_length: 100,
            },
          },
          {
            label: 'Telephone',
            value: 'Telephone',
            detail_answer: {
              id: 'consent-contact-type-answer-telephone-input',
              label: 'Telephone number',
              mandatory: false,
              visible: false,
              type: 'TextField',
              max_length: 100,
            },
          },
          {
            label: 'SMS text',
            value: 'SMS text',
            detail_answer: {
              id: 'consent-contact-type-answer-sms-input',
              label: 'Telephone number',
              mandatory: false,
              visible: false,
              type: 'TextField',
              max_length: 100,
            },
          },
        ],
      }
    ],
  },
  routing_rules: [
    {
      section: 'End',
    },
  ],
}