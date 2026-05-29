local transforms = import 'transforms.libsonnet';

local getListOrdinality(listName) = {
  placeholder: 'ordinality',
  transforms: [
    {
      transform: 'list_item_count',
      arguments: {
        list_to_count: { source: 'list', identifier: listName },
      },
    },
    {
      transform: 'add',
      arguments: {
        lhs: { source: 'previous_transform' },
        rhs: { value: 1 },
      },
    },
    {
      arguments: {
        number_to_format: {
          source: 'previous_transform',
        },
        determiner: {
          value: 'a_or_an',
        },
      },
      transform: 'format_ordinal',
    },
  ],
};

local getListOrdinalityWithoutDeterminer(listName) = {
  placeholder: 'ordinality',
  transforms: [
    {
      transform: 'list_item_count',
      arguments: {
        list_to_count: { source: 'list', identifier: listName },
      },
    },
    {
      transform: 'add',
      arguments: {
        lhs: { source: 'previous_transform' },
        rhs: { value: 1 },
      },
    },
    {
      arguments: {
        number_to_format: {
          source: 'previous_transform',
        },
      },
      transform: 'format_ordinal',
    },
  ],
};

local getListCardinality(listName) = {
  placeholder: 'cardinality',
  transforms: [
    {
      transform: 'list_item_count',
      arguments: {
        list_to_count: { source: 'list', identifier: listName },
      },
    },
    {
      transform: 'add',
      arguments: {
        lhs: { source: 'previous_transform' },
        rhs: { value: 0 },
      },
    },
  ],
};

local firstPersonNameForList(listName) = {
  placeholder: 'first_person',
  transforms: [
    {
      arguments: {
        delimiter: ' ',
        list_to_concatenate: [
          {
            source: 'answers',
            identifier: 'first-name',
            list_item_selector: {
              source: 'list',
              identifier: listName,
              selector: 'first',
            },
          },
          {
            source: 'answers',
            identifier: 'last-name',
            list_item_selector: {
              source: 'list',
              identifier: listName,
              selector: 'first',
            },
          },
        ],
      },
      transform: 'concatenate_list',
    },
  ],
};

local firstPersonNamePossessiveForList(listName) = {
  placeholder: 'first_person_possessive',
  transforms: [
    transforms.isSameName(source='first_list_item', listName=listName),
    transforms.formatPersonName(source='first_list_item', listName=listName),
    transforms.formatPossessive,
  ],
};

local personName(includeMiddleNames='') = (
  if includeMiddleNames == 'if_is_same_name' then
    {
      placeholder: 'person_name',
      transforms: [transforms.isSameName(), transforms.formatPersonName()],
    }
  else if includeMiddleNames == 'if_same_names_exist' then
    {
      placeholder: 'person_name',
      transforms: [transforms.listHasSameNameItems, transforms.formatPersonName()],
    }
  else
    {
      placeholder: 'person_name',
      transforms: [transforms.concatenateNames],
    }
);

local visitorPersonName() = {
  placeholder: 'person_name',
  transforms: [transforms.concatenateVisitorNames],
};

{
  personName: personName,
  personNamePossessive: {
    placeholder: 'person_name_possessive',
    transforms: [transforms.concatenateNames, transforms.formatPossessive],
  },
  visitorPersonName: visitorPersonName,
  visitorPersonNamePossessive: {
    placeholder: 'person_name_possessive',
    transforms: [transforms.concatenateVisitorNames, transforms.formatPossessive],
  },
  address: {
    placeholder: 'household_address',
    value: {
      identifier: 'display_address',
      source: 'metadata',
    },
  },
  censusDate: {
    placeholder: 'census_date',
    transforms: [{
      transform: 'format_date',
      arguments: {
        date_to_format: {
          value: std.extVar('census_date'),
        },
        date_format: 'd MMMM yyyy',
      },
    }],
  },
  yearBeforeCensusDate: {
    placeholder: 'year_before_census_date',
    transforms: [{
      transform: 'format_date',
      arguments: {
        date_to_format: {
          value: '2020-03-21',
        },
        date_format: 'd MMMM yyyy',
      },
    }],
  },
  getListOrdinality: getListOrdinality,
  getListOrdinalityWithoutDeterminer: getListOrdinalityWithoutDeterminer,
  getListCardinality: getListCardinality,
  firstPersonNameForList: firstPersonNameForList,
  firstPersonNamePossessiveForList: firstPersonNamePossessiveForList,
}
