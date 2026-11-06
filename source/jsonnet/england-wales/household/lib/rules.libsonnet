local common_rules = import '../../lib/common_rules.libsonnet';

local listIsEmpty(listName) = {
  '==': [
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
};

local listIsNotEmpty(listName) = {
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
};

local isFirstPersonInList(listName) = {
  '==': [
    {
      identifier: listName,
      source: 'list',
      selector: 'first',
    },
    {
      source: 'location',
      identifier: 'list_item_id',
    },
  ],
};

local isNotFirstPersonInList(listName) = {
  '!=': [
    {
      identifier: listName,
      source: 'list',
      selector: 'first',
    },
    {
      source: 'location',
      identifier: 'list_item_id',
    },
  ],
};

local isProxy = {
  '==': [
    {
      source: 'answers',
      identifier: 'confirm-who-is-answering-answer',
    },
    'No, I am answering on their behalf',
  ],
};

local isNotProxy = {
  '==': [
    {
      source: 'answers',
      identifier: 'confirm-who-is-answering-answer',
    },
    'Yes, I am',
  ],
};

{
  isProxy: isProxy,
  isNotProxy: isNotProxy,
  listIsEmpty: listIsEmpty,
  listIsNotEmpty: listIsNotEmpty,
  isFirstPersonInList: isFirstPersonInList,
  isNotFirstPersonInList: isNotFirstPersonInList,
  isEligibleForFurtherContact: {
    and: [
      isNotProxy,
      common_rules.isAdult,
    ],
  },
} + common_rules
