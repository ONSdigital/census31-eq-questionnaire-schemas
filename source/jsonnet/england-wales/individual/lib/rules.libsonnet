local common_rules = import '../../lib/common_rules.libsonnet';

{
  isNotProxy: {
    '==': [
      {
        source: 'answers',
        identifier: 'confirm-who-is-answering-answer',
      },
      'For myself',
    ],
  },
  isProxy: {
    '==': [
      {
        source: 'answers',
        identifier: 'confirm-who-is-answering-answer',
      },
      'For someone else',
    ],
  },
} + common_rules
