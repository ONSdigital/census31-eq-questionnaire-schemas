{
  over19: {
    '<=': [
      {
        date: [
          {
            identifier: 'date-of-birth-answer',
            source: 'answers',
          },
        ],
      },
      {
        date: [std.extVar('census_date'), { years: -19 }],
      },
    ],
  },
  over16: {
    '<=': [
      {
        date: [
          {
            identifier: 'date-of-birth-answer',
            source: 'answers',
          },
        ],
      },
      {
        date: [std.extVar('census_date'), { years: -16 }],
      },
    ],
  },
  under16: {
    '>': [
      {
        date: [
          {
            identifier: 'date-of-birth-answer',
            source: 'answers',
          },
        ],
      },
      {
        date: [std.extVar('census_date'), { years: -16 }],
      },
    ],
  },
  over15: {
    '<=': [
      {
        date: [
          {
            identifier: 'date-of-birth-answer',
            source: 'answers',
          },
        ],
      },
      {
        date: [std.extVar('census_date'), { years: -15 }],
      },
    ],
  },
  under5: {
    '>': [
      {
        date: [
          {
            identifier: 'date-of-birth-answer',
            source: 'answers',
          },
        ],
      },
      {
        date: [std.extVar('census_date'), { years: -5 }],
      },
    ],
  },
  under4: {
    '>': [
      {
        date: [
          {
            identifier: 'date-of-birth-answer',
            source: 'answers',
          },
        ],
      },
      {
        date: [std.extVar('census_date'), { years: -4 }],
      },
    ],
  },
  under3: {
    '>': [
      {
        date: [
          {
            identifier: 'date-of-birth-answer',
            source: 'answers',
          },
        ],
      },
      {
        date: [std.extVar('census_date'), { years: -3 }],
      },
    ],
  },
  under1: {
    '>': [
      {
        date: [
          {
            identifier: 'date-of-birth-answer',
            source: 'answers',
          },
        ],
      },
      {
        date: [std.extVar('census_date'), { years: -1 }],
      },
    ],
  },
  mainJob: {
    '==': [
      {
        source: 'answers',
        identifier: 'employment-status-last-seven-days-answer-exclusive',
      },
      null,
    ],
  },
  lastMainJob: {
    'in': [
      'None of these apply',
      {
        identifier: 'employment-status-last-seven-days-answer-exclusive',
        source: 'answers',
      },
    ],
  },
  accommodationIsHouse: {
    '==': [
      {
        source: 'answers',
        identifier: 'accommodation-type-answer',
      },
      'Whole house or bungalow',
    ],
  },
  accommodationIsFlat: {
    '==': [
      {
        source: 'answers',
        identifier: 'accommodation-type-answer',
      },
      'Flat, maisonette or apartment',
    ],
  },
  accomodationNotAnswered: {
    '==': [
      {
        source: 'answers',
        identifier: 'accomodation-type-answer',
      },
      null,
    ],
  },
  isPrimary: {
    '==': [
      {
        source: 'list',
        identifier: 'household',
        selector: 'primary_person',
      },
      {
        source: 'location',
        identifier: 'list_item_id',
      },
    ],
  },
  isNotPrimary: {
    '!=': [
      {
        identifier: 'household',
        source: 'list',
        selector: 'primary_person',
      },
      {
        source: 'location',
        identifier: 'list_item_id',
      },
    ],
  },
  hasPrimary: {
    '==': [
      {
        source: 'answers',
        identifier: 'do-you-usually-live-here-answer',
      },
      'Yes, I usually live here',
    ],
  },
  hasNoPrimary: {
    '==': [
      {
        source: 'answers',
        identifier: 'do-you-usually-live-here-answer',
      },
      'No, I don’t usually live here',
    ],
  },
  listIsNotEmpty(listName): {
    '>': [
      {
        count: [
          {
            source: 'list',
            identifier: listName,
          },
        ],
      },
      0,
    ],
  },
}
