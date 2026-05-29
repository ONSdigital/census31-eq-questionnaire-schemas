local firstNameSource(source, listName) = (
  if source == 'first_list_item' then {
    source: 'answers',
    identifier: 'first-name',
    list_item_selector: {
      identifier: listName,
      selector: 'first',
      source: 'list',
    },
  } else if source == 'to_list_item' then {
    source: 'answers',
    identifier: 'first-name',
    list_item_selector: {
      source: 'location',
      identifier: 'to_list_item_id',
    },
  } else {
    source: 'answers',
    identifier: 'first-name',
  }
);

local middleNamesSource(source, listName) = (
  if source == 'first_list_item' then {
    source: 'answers',
    identifier: 'middle-names',
    list_item_selector: {
      identifier: listName,
      selector: 'first',
      source: 'list',
    },
  } else if source == 'to_list_item' then {
    source: 'answers',
    identifier: 'middle-names',
    list_item_selector: {
      source: 'location',
      identifier: 'to_list_item_id',
    },
  }
  else {
    source: 'answers',
    identifier: 'middle-names',
  }
);

local lastNameSource(source, listName) = (
  if source == 'first_list_item' then {
    source: 'answers',
    identifier: 'last-name',
    list_item_selector: {
      identifier: listName,
      selector: 'first',
      source: 'list',
    },
  } else if source == 'to_list_item' then {
    source: 'answers',
    identifier: 'last-name',
    list_item_selector: {
      source: 'location',
      identifier: 'to_list_item_id',
    },
  }
  else {
    source: 'answers',
    identifier: 'last-name',
  }
);

local formatPersonName(source='', listName='household') = {
  transform: 'format_name',
  arguments: {
    include_middle_names: {
      source: 'previous_transform',
    },
    first_name: firstNameSource(source, listName),
    middle_names: middleNamesSource(source, listName),
    last_name: lastNameSource(source, listName),
  },
};

local formatPossessive = {
  transform: 'format_possessive',
  arguments: {
    string_to_format: {
      source: 'previous_transform',
    },
  },
};

local isSameName(source='', listName='household') = (
  local valueSource = if source == 'first_list_item' then {
    source: 'list',
    selector: 'first',
    identifier: listName,
  } else {
    source: 'location',
    identifier: 'list_item_id',
  };

  {
    transform: 'contains',
    arguments: {
      list_to_check: {
        source: 'list',
        selector: 'same_name_items',
        identifier: listName,
      },
      value: valueSource,
    },
  }
);

local listHasSameNameItems = {
  transform: 'list_has_items',
  arguments: {
    list_to_check: {
      source: 'list',
      selector: 'same_name_items',
      identifier: 'household',
    },
  },
};

local concatenateNames = {
  transform: 'concatenate_list',
  arguments: {
    list_to_concatenate: [
      {
        source: 'answers',
        identifier: 'first-name',
      },
      {
        source: 'answers',
        identifier: 'last-name',
      },
    ],
    delimiter: ' ',
  },
};

local concatenateVisitorNames = {
  transform: 'concatenate_list',
  arguments: {
    list_to_concatenate: [
      {
        source: 'answers',
        identifier: 'visitor-first-name',
      },
      {
        source: 'answers',
        identifier: 'visitor-last-name',
      },
    ],
    delimiter: ' ',
  },
};

{
  formatPersonName: formatPersonName,
  formatPossessive: formatPossessive,
  isSameName: isSameName,
  listHasSameNameItems: listHasSameNameItems,
  concatenateNames: concatenateNames,
  concatenateVisitorNames: concatenateVisitorNames,
}
