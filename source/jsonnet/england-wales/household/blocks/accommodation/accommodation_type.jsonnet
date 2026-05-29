local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

{
  type: 'Question',
  id: 'accommodation-type',
  page_title: 'Accommodation type',
  question: {
    id: 'accommodation-type-question',
    title: {
      text: 'What type of accommodation is <strong>{household_address}</strong>?',
      placeholders: [placeholders.address],
    },
    type: 'General',
    answers: [
      {
        id: 'accommodation-type-answer',
        mandatory: false,
        type: 'Radio',
        options: [
          {
            label: 'Whole house or bungalow',
            value: 'Whole house or bungalow',
          },
          {
            label: 'Flat, maisonette or apartment',
            value: 'Flat, maisonette or apartment',
            description: 'Including purpose-built flats and flats within converted buildings',
          },
          {
            label: 'Caravan or other mobile or temporary structure',
            value: 'Caravan or other mobile or temporary structure',
          },
        ],
      },
    ],
  },
  routing_rules: [
    {
      block: 'type-of-house',
      when: rules.accommodationIsHouse,
    },
    {
      block: 'type-of-flat',
      when: rules.accommodationIsFlat,
    },
    {
      block: 'rooms-shared-with-another-household',
    },
  ],
}
