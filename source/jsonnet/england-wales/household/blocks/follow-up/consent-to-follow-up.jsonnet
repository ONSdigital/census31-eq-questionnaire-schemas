local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

{
  type: 'Question',
  id: 'consent-to-follow-up',
  page_title: 'Consent to follow up',
  question: {
    type: 'General',
    id: 'consent-to-follow-up-question',
    title: 'Thank you for taking part in the Census Test, your section is now complete.',
    description: [
        'To improve the future design of the Census, the Office for National Statistics may contact you within the next four months to take part in research about your experience of completing this survey.',
        'Are you willing to be contacted for this purpose?',
    ],
    guidance: {
      contents: [
        {
          description: 'Providing your contact details and your participation in future research is voluntary.',
        },
      ],
    },
    answers: [
      {
        guidance: {
          show_guidance: 'How long will my data be kept?',
          hide_guidance: 'How long will my data be kept?',
          contents: [
            {
              description: 'The contact details you provide here will only be used to contact you about future research on the development of the 2031 Census. These details will be kept until the end of the research period, which will end in December 2027. There is no guarantee you will be chosen for future research.</br>As with all data collected by the ONS, your details will be held securely and in confidence. Further information about how we collect and use your data can be found in the Census Test privacy notice or on the main ONS website.',
            },
          ],
        },
      id: 'consent-to-follow-up-answer',
      mandatory: false,
      options: [
        {
          label: 'Yes, I am willing to be contacted',
          value: 'Yes, I am willing to be contacted',
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
      block: 'consent-contact-type',
      when: {
        '==': [
          {
            source: 'answers',
            identifier: 'consent-to-follow-up-answer',
          },
          'Yes, I am willing to be contacted',
        ],
      },
    },
    {
      section: 'End',
    },
  ],
}
