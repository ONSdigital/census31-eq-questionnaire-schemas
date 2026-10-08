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

{
  isNotProxy: {
    '==': [
      {
        source: 'answers',
        identifier: 'confirm-who-is-answering-answer',
      },
      'Yes, I am',
    ],
  },
  isProxy: {
    '==': [
      {
        source: 'answers',
        identifier: 'confirm-who-is-answering-answer',
      },
      'No, I am answering on their behalf',
    ],
  },
  listIsEmpty: listIsEmpty,
  listIsNotEmpty: listIsNotEmpty,
  isFirstPersonInList: isFirstPersonInList,
  isNotFirstPersonInList: isNotFirstPersonInList,
} + common_rules
