local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title) = {
  id: 'workplace-country-question',
  title: title,
  type: 'General',
  answers: [
    {
      id: 'workplace-country-answer',
      label: 'Current name of country',
      description: 'Enter your own answer or select from suggestions',
      suggestions: { url: '{suggestions_url_root}/countries-of-birth.json' },
      mandatory: false,
      type: 'TextField',
    },
  ],
};

local nonProxyTitle = 'In which country is your main place of <strong>work</strong>?';
local proxyTitle = {
  text: 'In which country is <strong>{person_name_possessive}</strong> main place of <strong>work</strong>?',
  placeholders: [
    placeholders.personNamePossessive,
  ],
};

local pastNonProxyTitle = 'In which country was your main place of <strong>work</strong>?';
local pastProxyTitle = {
  text: 'In which country was <strong>{person_name_possessive}</strong> main place of <strong>work</strong>?',
  placeholders: [
    placeholders.personNamePossessive,
  ],
};

{
  type: 'Question',
  id: 'workplace-country',
  page_title: 'Main place of work outside the UK',
  question_variants: [
    {
      question: question(nonProxyTitle),
      when: { and: [rules.isNotProxy, rules.mainJob] },
    },
    {
      question: question(proxyTitle),
      when: { and: [rules.isProxy, rules.mainJob] },
    },
    {
      question: question(pastNonProxyTitle),
      when: rules.isNotProxy,
    },
    {
      question: question(pastProxyTitle),
      when: rules.isProxy,
    },
  ],
  routing_rules: [
    {
      block: 'workplace-outside-northern-ireland',
      when: {
        'in': [
          {
            source: 'answers',
            identifier: 'workplace-country-answer',
          },
          [
            'Carlow',
            'Cavan',
            'Clare',
            'Connaught',
            'Cork',
            'Donegal',
            'Dublin',
            'Eire',
            'Galway',
            'Ireland',
            'Ireland (Republic)',
            'Ireland (Southern)',
            'Irish Free State',
            'Irish Republic',
            'Kerry',
            'Kildare',
            'Kilkenny',
            'Laois',
            'Leinster',
            'Leitrim',
            'Limerick',
            'Longford',
            'Louth',
            'Mayo',
            'Meath',
            'Monaghan',
            'Munster',
            'Offaly',
            'Republic of Ireland',
            'RoI',
            'Roscommon',
            'Sligo',
            'Southern Ireland',
            'Tipperary',
            'Waterford',
            'Westmeath',
            'Wexford',
            'Wicklow',
            'South of Ireland',
            'Ceatharlach',
            'An Cabhán',
            'An Clár',
            'Connachta',
            'Corcaigh',
            'Dún na nGall',
            'Baile Átha Cliath',
            'Éire',
            'Gaillimh',
            'Éire (Poblacht)',
            'Éire (Deisceart)',
            'Saorstát Éireann',
            'Poblacht na hÉireann',
            'Ciarraí',
            'Cill Dara',
            'Cill Chainnigh',
            'Laighin',
            'Liatroim',
            'Luimneach',
            'An Longfort',
            'An Lú',
            'Maigh Eo',
            'An Mhí',
            'Muineachán',
            'Mumhain',
            'Uíbh Fhailí',
            'Ros Comáin',
            'Sligeach',
            'Deisceart na hÉireann',
            'Tiobraid Árann',
            'Port Láirge',
            'An Iarmhí',
            'Loch Garman',
            'Cill Mhantáin',
            'Ulaidh',
          ],
        ],
      },
    },
    {
      block: 'travel-to-work',
    },
  ],
}
