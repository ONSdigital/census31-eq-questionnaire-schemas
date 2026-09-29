{
  lastBirthdayAgeOver(age): {
    '>=': [
      {
        source: 'answers',
        identifier: 'age-last-birthday-answer',
      },
      age,
    ],
  },
  lastBirthdayAgeLessThan(age): {
    '<': [
      {
        source: 'answers',
        identifier: 'age-last-birthday-answer',
      },
      age,
    ],
  },
  over16: {
    '<=': [
      {
        date: [
          {
            source: 'answers',
            identifier: 'date-of-birth-answer',
          },
        ],
      },
      {
        date: [std.extVar('census_date'), { years: -16 }],
      },
    ],
  },
  over5: {
    '<=': [
      {
        date: [
          {
            source: 'answers',
            identifier: 'date-of-birth-answer',
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
            source: 'answers',
            identifier: 'date-of-birth-answer',
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
            source: 'answers',
            identifier: 'date-of-birth-answer',
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
            source: 'answers',
            identifier: 'date-of-birth-answer',
          },
        ],
      },
      {
        date: [std.extVar('census_date'), { years: -1 }],
      },
    ],
  },
  schoolYearUnder4: {
    '>': [
      {
        date: [
          {
            source: 'answers',
            identifier: 'date-of-birth-answer',
          },
        ],
      },
      {
        date: ['2020-06-30', { years: -4 }],
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
        source: 'answers',
        identifier: 'employment-status-last-seven-days-answer-exclusive',
      },
    ],
  },
  hasWorked: {
    and: [
      {
        '!=': [
          {
            source: 'answers',
            identifier: 'ever-worked-answer',
          },
          'No, has never worked',
        ],
      },
      {
        '!=': [
          {
            source: 'answers',
            identifier: 'ever-worked-answer',
          },
          'No, have never worked',
        ],
      },
      {
        '!=': [
          {
            source: 'answers',
            identifier: 'ever-worked-answer',
          },
          null,
        ],
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
}
