local placeholders = import '../../../lib/placeholders.libsonnet';
local transforms = import '../../../lib/transforms.libsonnet';
local rules = import 'rules.libsonnet';

local firstPersonPlaceholder = {
  placeholder: 'first_person_name',
  transforms: [transforms.listHasSameNameItems, transforms.formatPersonName()],
};

local secondPersonPlaceholder = {
  placeholder: 'second_person_name',
  transforms: [transforms.listHasSameNameItems, transforms.formatPersonName(source='to_list_item')],
};

local firstPersonNamePossessivePlaceholder = {
  placeholder: 'first_person_name_possessive',
  transforms: [
    transforms.listHasSameNameItems,
    transforms.formatPersonName(),
    transforms.formatPossessive,
  ],
};

local unrelatedQuestionTitle(isPrimary) = (
  if isPrimary then 'Are any of these people related to you?'
  else {
    text: 'Are any of these people related to <strong>{person_name}</strong>?',
    placeholders: [
      placeholders.personName(includeMiddleNames='if_same_names_exist'),
    ],
  }
);

local unrelatedNoOption(isPrimary) = (
  if isPrimary then {
    label: 'No, none of these people are related to me',
    value: 'No, none of these people are related to me',
    action: {
      type: 'AddUnrelatedRelationships',
    },
  } else {
    label: {
      text: 'No, none of these people are related to {person_name}',
      placeholders: [
        placeholders.personName(includeMiddleNames='if_same_names_exist'),
      ],
    },
    value: 'No, none of these people are related to {person_name}',
    action: {
      type: 'AddUnrelatedRelationships',
    },
  }
);

local unrelatedQuestion(isPrimary) = {
  id: 'related-to-anyone-else-question',
  type: 'General',
  title: unrelatedQuestionTitle(isPrimary),
  guidance: {
    contents: [
      {
        description: 'Remember to include partners, step-parents and stepchildren as related',
      },
    ],
  },
  answers: [
    {
      id: 'related-to-anyone-else-answer',
      mandatory: true,
      type: 'Radio',
      options: [
        {
          label: 'Yes',
          value: 'Yes',
          action: {
            type: 'RemoveUnrelatedRelationships',
          },
        },
        unrelatedNoOption(isPrimary),
      ],
    },
  ],
};


{
  type: 'RelationshipCollector',
  id: 'relationships',
  title: 'Household relationships',
  page_title: 'How Person {list_item_position} is related to Person {to_list_item_position}',
  for_list: 'household',
  question_variants: [
    {
      question: {
        id: 'relationship-question',
        type: 'General',
        title: {
          text: '{second_person_name} is your <strong>…</strong>',
          placeholders: [secondPersonPlaceholder],
        },
        description: [
          'Complete the sentence by selecting the appropriate relationship.',
        ],
        answers: [
          {
            id: 'relationship-answer',
            mandatory: false,
            type: 'Relationship',
            playback: {
              text: '{second_person_name} is your <strong>…</strong>',
              placeholders: [secondPersonPlaceholder],
            },
            options: [
              {
                label: 'Husband or wife',
                playback: {
                  text: '{second_person_name} is your <strong>husband or wife</strong>',
                  placeholders: [secondPersonPlaceholder],
                },
                title: {
                  text: '{second_person_name} is your <strong>husband or wife</strong>',
                  placeholders: [secondPersonPlaceholder],
                },
                value: 'Husband or wife',
              },
              {
                label: 'Civil partner',
                playback: {
                  text: '{second_person_name} is your <strong>civil partner</strong>',
                  placeholders: [secondPersonPlaceholder],
                },
                title: {
                  text: '{second_person_name} is your <strong>civil partner</strong>',
                  placeholders: [secondPersonPlaceholder],
                },
                value: 'Civil partner',
              },
              {
                label: 'Partner',
                playback: {
                  text: '{second_person_name} is your <strong>partner</strong>',
                  placeholders: [secondPersonPlaceholder],
                },
                title: {
                  text: '{second_person_name} is your <strong>partner</strong>',
                  placeholders: [secondPersonPlaceholder],
                },
                value: 'Partner',
              },
              {
                label: 'Son or daughter',
                playback: {
                  text: '{second_person_name} is your <strong>son or daughter</strong>',
                  placeholders: [secondPersonPlaceholder],
                },
                title: {
                  text: '{second_person_name} is your <strong>son or daughter</strong>',
                  placeholders: [secondPersonPlaceholder],
                },
                value: 'Son or daughter',
              },
              {
                label: 'Step-child',
                playback: {
                  text: '{second_person_name} is your <strong>step-child</strong>',
                  placeholders: [secondPersonPlaceholder],
                },
                title: {
                  text: '{second_person_name} is your <strong>step-child</strong>',
                  placeholders: [secondPersonPlaceholder],
                },
                value: 'Step-child',
              },
              {
                description: 'Including half-brother or half-sister',
                label: 'Brother or sister',
                playback: {
                  text: '{second_person_name} is your <strong>brother or sister</strong>',
                  placeholders: [secondPersonPlaceholder],
                },
                title: {
                  text: '{second_person_name} is your <strong>brother or sister</strong>',
                  placeholders: [secondPersonPlaceholder],
                },
                value: 'Brother or sister',
              },
              {
                label: 'Step-brother or step-sister',
                playback: {
                  text: '{second_person_name} is your <strong>step-brother or step-sister</strong>',
                  placeholders: [secondPersonPlaceholder],
                },
                title: {
                  text: '{second_person_name} is your <strong>step-brother or step-sister</strong>',
                  placeholders: [secondPersonPlaceholder],
                },
                value: 'Step-brother or step-sister',
              },
              {
                label: 'Mother or father',
                playback: {
                  text: '{second_person_name} is your <strong>mother or father</strong>',
                  placeholders: [secondPersonPlaceholder],
                },
                title: {
                  text: '{second_person_name} is your <strong>mother or father</strong>',
                  placeholders: [secondPersonPlaceholder],
                },
                value: 'Mother or father',
              },
              {
                label: 'Step-mother or step-father',
                playback: {
                  text: '{second_person_name} is your <strong>step-mother or step-father</strong>',
                  placeholders: [secondPersonPlaceholder],
                },
                title: {
                  text: '{second_person_name} is your <strong>step-mother or step-father</strong>',
                  placeholders: [secondPersonPlaceholder],
                },
                value: 'Step-mother or step-father',
              },
              {
                label: 'Grandchild',
                playback: {
                  text: '{second_person_name} is your <strong>grandchild</strong>',
                  placeholders: [secondPersonPlaceholder],
                },
                title: {
                  text: '{second_person_name} is your <strong>grandchild</strong>',
                  placeholders: [secondPersonPlaceholder],
                },
                value: 'Grandchild',
              },
              {
                label: 'Grandparent',
                playback: {
                  text: '{second_person_name} is your <strong>grandparent</strong>',
                  placeholders: [secondPersonPlaceholder],
                },
                title: {
                  text: '{second_person_name} is your <strong>grandparent</strong>',
                  placeholders: [secondPersonPlaceholder],
                },
                value: 'Grandparent',
              },
              {
                label: 'Other relation',
                playback: {
                  text: '{second_person_name} is your <strong>other relation</strong>',
                  placeholders: [secondPersonPlaceholder],
                },
                title: {
                  text: '{second_person_name} is your <strong>other relation</strong>',
                  placeholders: [secondPersonPlaceholder],
                },
                value: 'Other relation',
              },
              {
                description: 'Including foster child',
                label: 'Unrelated',
                playback: {
                  text: '{second_person_name} is <strong>unrelated</strong> to you',
                  placeholders: [secondPersonPlaceholder],
                },
                title: {
                  text: '{second_person_name} is <strong>unrelated</strong> to you',
                  placeholders: [secondPersonPlaceholder],
                },
                value: 'Unrelated',
              },
            ],
          },
        ],
      },
      when: rules.isPrimary,
    },
    {
      question: {
        id: 'relationship-question',
        type: 'General',
        title: {
          text: 'Thinking about {first_person_name}, {second_person_name} is their <strong>…</strong>',
          placeholders: [firstPersonPlaceholder, secondPersonPlaceholder],
        },
        description: [
          'Complete the sentence by selecting the appropriate relationship.',
        ],
        answers: [
          {
            id: 'relationship-answer',
            mandatory: false,
            type: 'Relationship',
            playback: {
              text: '{second_person_name} is {first_person_name_possessive} <strong>…</strong>',
              placeholders: [secondPersonPlaceholder, firstPersonNamePossessivePlaceholder],
            },
            options: [
              {
                label: 'Husband or wife',
                playback: {
                  text: '{second_person_name} is {first_person_name_possessive} <strong>husband or wife</strong>',
                  placeholders: [secondPersonPlaceholder, firstPersonNamePossessivePlaceholder],
                },
                title: {
                  text: 'Thinking about {first_person_name}, {second_person_name} is their <strong>husband or wife</strong>',
                  placeholders: [firstPersonPlaceholder, secondPersonPlaceholder],
                },
                value: 'Husband or wife',
              },
              {
                label: 'Civil partner',
                playback: {
                  text: '{second_person_name} is {first_person_name_possessive} <strong>civil partner</strong>',
                  placeholders: [secondPersonPlaceholder, firstPersonNamePossessivePlaceholder],
                },
                title: {
                  text: 'Thinking about {first_person_name}, {second_person_name} is their <strong>civil partner</strong>',
                  placeholders: [firstPersonPlaceholder, secondPersonPlaceholder],
                },
                value: 'Civil partner',
              },
              {
                label: 'Partner',
                playback: {
                  text: '{second_person_name} is {first_person_name_possessive} <strong>partner</strong>',
                  placeholders: [secondPersonPlaceholder, firstPersonNamePossessivePlaceholder],
                },
                title: {
                  text: 'Thinking about {first_person_name}, {second_person_name} is their <strong>partner</strong>',
                  placeholders: [firstPersonPlaceholder, secondPersonPlaceholder],
                },
                value: 'Partner',
              },
              {
                label: 'Son or daughter',
                playback: {
                  text: '{second_person_name} is {first_person_name_possessive} <strong>son or daughter</strong>',
                  placeholders: [secondPersonPlaceholder, firstPersonNamePossessivePlaceholder],
                },
                title: {
                  text: 'Thinking about {first_person_name}, {second_person_name} is their <strong>son or daughter</strong>',
                  placeholders: [firstPersonPlaceholder, secondPersonPlaceholder],
                },
                value: 'Son or daughter',
              },
              {
                label: 'Step-child',
                playback: {
                  text: '{second_person_name} is {first_person_name_possessive} <strong>step-child</strong>',
                  placeholders: [secondPersonPlaceholder, firstPersonNamePossessivePlaceholder],
                },
                title: {
                  text: 'Thinking about {first_person_name}, {second_person_name} is their <strong>step-child</strong>',
                  placeholders: [firstPersonPlaceholder, secondPersonPlaceholder],
                },
                value: 'Step-child',
              },
              {
                description: 'Including half-brother or half-sister',
                label: 'Brother or sister',
                playback: {
                  text: '{second_person_name} is {first_person_name_possessive} <strong>brother or sister</strong>',
                  placeholders: [secondPersonPlaceholder, firstPersonNamePossessivePlaceholder],
                },
                title: {
                  text: 'Thinking about {first_person_name}, {second_person_name} is their <strong>brother or sister</strong>',
                  placeholders: [firstPersonPlaceholder, secondPersonPlaceholder],
                },
                value: 'Brother or sister',
              },
              {
                label: 'Step-brother or step-sister',
                playback: {
                  text: '{second_person_name} is {first_person_name_possessive} <strong>step-brother or step-sister</strong>',
                  placeholders: [secondPersonPlaceholder, firstPersonNamePossessivePlaceholder],
                },
                title: {
                  text: 'Thinking about {first_person_name}, {second_person_name} is their <strong>step-brother or step-sister</strong>',
                  placeholders: [firstPersonPlaceholder, secondPersonPlaceholder],
                },
                value: 'Step-brother or step-sister',
              },
              {
                label: 'Mother or father',
                playback: {
                  text: '{second_person_name} is {first_person_name_possessive} <strong>mother or father</strong>',
                  placeholders: [secondPersonPlaceholder, firstPersonNamePossessivePlaceholder],
                },
                title: {
                  text: 'Thinking about {first_person_name}, {second_person_name} is their <strong>mother or father</strong>',
                  placeholders: [firstPersonPlaceholder, secondPersonPlaceholder],
                },
                value: 'Mother or father',
              },
              {
                label: 'Step-mother or step-father',
                playback: {
                  text: '{second_person_name} is {first_person_name_possessive} <strong>step-mother or step-father</strong>',
                  placeholders: [secondPersonPlaceholder, firstPersonNamePossessivePlaceholder],
                },
                title: {
                  text: 'Thinking about {first_person_name}, {second_person_name} is their <strong>step-mother or step-father</strong>',
                  placeholders: [firstPersonPlaceholder, secondPersonPlaceholder],
                },
                value: 'Step-mother or step-father',
              },
              {
                label: 'Grandchild',
                playback: {
                  text: '{second_person_name} is {first_person_name_possessive} <strong>grandchild</strong>',
                  placeholders: [secondPersonPlaceholder, firstPersonNamePossessivePlaceholder],
                },
                title: {
                  text: 'Thinking about {first_person_name}, {second_person_name} is their <strong>grandchild</strong>',
                  placeholders: [firstPersonPlaceholder, secondPersonPlaceholder],
                },
                value: 'Grandchild',
              },
              {
                label: 'Grandparent',
                playback: {
                  text: '{second_person_name} is {first_person_name_possessive} <strong>grandparent</strong>',
                  placeholders: [secondPersonPlaceholder, firstPersonNamePossessivePlaceholder],
                },
                title: {
                  text: 'Thinking about {first_person_name}, {second_person_name} is their <strong>grandparent</strong>',
                  placeholders: [firstPersonPlaceholder, secondPersonPlaceholder],
                },
                value: 'Grandparent',
              },
              {
                label: 'Other relation',
                playback: {
                  text: '{second_person_name} is {first_person_name_possessive} <strong>other relation</strong>',
                  placeholders: [secondPersonPlaceholder, firstPersonNamePossessivePlaceholder],
                },
                title: {
                  text: 'Thinking about {first_person_name}, {second_person_name} is their <strong>other relation</strong>',
                  placeholders: [firstPersonPlaceholder, secondPersonPlaceholder],
                },
                value: 'Other relation',
              },
              {
                description: 'Including foster child',
                label: 'Unrelated',
                playback: {
                  text: '{second_person_name} is <strong>unrelated</strong> to {first_person_name}',
                  placeholders: [secondPersonPlaceholder, firstPersonPlaceholder],
                },
                title: {
                  text: 'Thinking about {first_person_name}, {second_person_name} is <strong>unrelated</strong> to {first_person_name}',
                  placeholders: [firstPersonPlaceholder, secondPersonPlaceholder, firstPersonPlaceholder],
                },
                value: 'Unrelated',
              },
            ],
          },
        ],
      },
      when: rules.isNotPrimary,
    },
  ],
  unrelated_block: {
    type: 'UnrelatedQuestion',
    id: 'related-to-anyone-else',
    page_title: 'How person {list_item_position} is related to anyone else',
    title: 'Related to anyone else',
    list_summary: {
      for_list: 'household',
      summary: {
        item_title: {
          text: '{person_name}',
          placeholders: [
            placeholders.personName(includeMiddleNames='if_same_names_exist'),
          ],
        },
      },
    },
    question_variants: [
      {
        question: unrelatedQuestion(isPrimary=true),
        when: rules.isPrimary,
      },
      {
        question: unrelatedQuestion(isPrimary=false),
        when: rules.isNotPrimary,
      },
    ],
  },
}
