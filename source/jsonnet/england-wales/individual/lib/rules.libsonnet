local common_rules = import '../../lib/common_rules.libsonnet';

local isProxy = {
  '==': [
    {
      source: 'answers',
      identifier: 'confirm-who-is-answering-answer',
    },
    'For someone else',
  ],
};

local isNotProxy = {
  '==': [
    {
      source: 'answers',
      identifier: 'confirm-who-is-answering-answer',
    },
    'For myself',
  ],
};

{
  isProxy: isProxy,
  isNotProxy: isNotProxy,
  isEligibleForFurtherContact: {
    and: [
      isNotProxy,
      common_rules.isAdult,
    ],
  },
} + common_rules
