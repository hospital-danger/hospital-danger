state_information_flags = [
  reports_HAI = [
    0: null,
    1: "Hospitals are not required to track and report information about hospital-acquired infections.",
    2: "Hospitals are required to track and report information about hospital-acquired infections."
  ],
  reports_adverse_events = [
    0: null,
    1: "Hospitals are not required to track and report information about adverse events.",
    2: "Hospitals are required to track and report information about adverse events."
  ]
  audits_HAI: = [
    0: null,
    1: "The state does not make a strong effort to verify hospitals&rsquo; self-reported infection numbers.",
    2: "The state makes an effort to verify hospitals&rsquo; self-reported infection numbers."
  ]
  audits_adverse_events: = [
    0: null,
    1: "The state does not make a strong effort to verify hospitals&rsquo; self-reported infections numbers.",
    2: "The state makes an effort to verify hospitals&rsquo; self-reported adverse event numbers."
  ]
  reports_HAI_per_hospital: = [
    0: null,
    1: "Infections numbers by hospital are not publicly available.",
    2: "Infection numbers at each hospital are publicly available."
  ]
  reports_adverse_events_per_hospital: = [
    0: null,
    1: "Adverse events numbers by hospital are not publicly available.",
    2: "Adverse events numbers at each hospital are publicly available."
  ]
]

states = [
  { state_title: "Alabama",        state_abbreviation: "AL", reports_HAI: 2, reports_adverse_events: 1, audits_HAI: 2, audits_adverse_events: 0, reports_HAI_per_hospital: 2, reports_adverse_events_per_hospital: 0, score: 2 }
  { state_title: "Alaska",         state_abbreviation: "AK", reports_HAI: 1, reports_adverse_events: 1, audits_HAI: 0, audits_adverse_events: 0, reports_HAI_per_hospital: 0, reports_adverse_events_per_hospital: 0, score: 1 }
  { state_title: "Arizona",        state_abbreviation: "AZ", reports_HAI: 1, reports_adverse_events: 1, audits_HAI: 0, audits_adverse_events: 0, reports_HAI_per_hospital: 0, reports_adverse_events_per_hospital: 0, score: 1 }
  { state_title: "Arkansas",       state_abbreviation: "AR", reports_HAI: 2, reports_adverse_events: 1, audits_HAI: 1, audits_adverse_events: 0, reports_HAI_per_hospital: 1, reports_adverse_events_per_hospital: 0, score: 2 }
  { state_title: "California",     state_abbreviation: "CA", reports_HAI: 2, reports_adverse_events: 2, audits_HAI: 1, audits_adverse_events: 2, reports_HAI_per_hospital: 2, reports_adverse_events_per_hospital: 2, score: 2 }
  { state_title: "Colorado",       state_abbreviation: "CO", reports_HAI: 2, reports_adverse_events: 1, audits_HAI: 2, audits_adverse_events: 0, reports_HAI_per_hospital: 2, reports_adverse_events_per_hospital: 0, score: 2 }
  { state_title: "Connecticut",    state_abbreviation: "CT", reports_HAI: 2, reports_adverse_events: 2, audits_HAI: 2, audits_adverse_events: 2, reports_HAI_per_hospital: 2, reports_adverse_events_per_hospital: 2, score: 3 }
  { state_title: "Delaware",       state_abbreviation: "DE", reports_HAI: 2, reports_adverse_events: 1, audits_HAI: 2, audits_adverse_events: 0, reports_HAI_per_hospital: 2, reports_adverse_events_per_hospital: 0, score: 2 }
  { state_title: "Florida",        state_abbreviation: "FL", reports_HAI: 2, reports_adverse_events: 2, audits_HAI: 1, audits_adverse_events: 1, reports_HAI_per_hospital: 2, reports_adverse_events_per_hospital: 2, score: 2 }
  { state_title: "Georgia",        state_abbreviation: "GA", reports_HAI: 1, reports_adverse_events: 2, audits_HAI: 0, audits_adverse_events: 1, reports_HAI_per_hospital: 0, reports_adverse_events_per_hospital: 1, score: 2 }
  { state_title: "Hawaii",         state_abbreviation: "HI", reports_HAI: 2, reports_adverse_events: 1, audits_HAI: 1, audits_adverse_events: 0, reports_HAI_per_hospital: 2, reports_adverse_events_per_hospital: 0, score: 2 }
  { state_title: "Idaho",          state_abbreviation: "ID", reports_HAI: 1, reports_adverse_events: 1, audits_HAI: 0, audits_adverse_events: 0, reports_HAI_per_hospital: 0, reports_adverse_events_per_hospital: 0, score: 1 }
  { state_title: "Illinois",       state_abbreviation: "IL", reports_HAI: 2, reports_adverse_events: 2, audits_HAI: 2, audits_adverse_events: 1, reports_HAI_per_hospital: 2, reports_adverse_events_per_hospital: 2, score: 2 }
  { state_title: "Indiana",        state_abbreviation: "IN", reports_HAI: 2, reports_adverse_events: 2, audits_HAI: 1, audits_adverse_events: 1, reports_HAI_per_hospital: 2, reports_adverse_events_per_hospital: 2, score: 2 }
  { state_title: "Iowa",           state_abbreviation: "IA", reports_HAI: 1, reports_adverse_events: 1, audits_HAI: 0, audits_adverse_events: 0, reports_HAI_per_hospital: 0, reports_adverse_events_per_hospital: 0, score: 1 }
  { state_title: "Kansas",         state_abbreviation: "KS", reports_HAI: 1, reports_adverse_events: 1, audits_HAI: 0, audits_adverse_events: 0, reports_HAI_per_hospital: 0, reports_adverse_events_per_hospital: 0, score: 1 }
  { state_title: "Kentucky",       state_abbreviation: "KY", reports_HAI: 1, reports_adverse_events: 1, audits_HAI: 0, audits_adverse_events: 0, reports_HAI_per_hospital: 0, reports_adverse_events_per_hospital: 0, score: 1 }
  { state_title: "Louisiana",      state_abbreviation: "LA", reports_HAI: 1, reports_adverse_events: 1, audits_HAI: 0, audits_adverse_events: 0, reports_HAI_per_hospital: 0, reports_adverse_events_per_hospital: 0, score: 1 }
  { state_title: "Maine",          state_abbreviation: "ME", reports_HAI: 2, reports_adverse_events: 2, audits_HAI: 2, audits_adverse_events: 2, reports_HAI_per_hospital: 1, reports_adverse_events_per_hospital: 1, score: 2 }
  { state_title: "Maryland",       state_abbreviation: "MD", reports_HAI: 2, reports_adverse_events: 2, audits_HAI: 2, audits_adverse_events: 1, reports_HAI_per_hospital: 2, reports_adverse_events_per_hospital: 1, score: 2 }
  { state_title: "Massachusetts",  state_abbreviation: "MA", reports_HAI: 2, reports_adverse_events: 2, audits_HAI: 0, audits_adverse_events: 1, reports_HAI_per_hospital: 2, reports_adverse_events_per_hospital: 2, score: 2 }
  { state_title: "Michigan",       state_abbreviation: "MI", reports_HAI: 1, reports_adverse_events: 1, audits_HAI: 0, audits_adverse_events: 0, reports_HAI_per_hospital: 0, reports_adverse_events_per_hospital: 0, score: 1 }
  { state_title: "Minnesota",      state_abbreviation: "MN", reports_HAI: 1, reports_adverse_events: 2, audits_HAI: 0, audits_adverse_events: 1, reports_HAI_per_hospital: 0, reports_adverse_events_per_hospital: 2, score: 2 }
  { state_title: "Mississippi",    state_abbreviation: "MS", reports_HAI: 1, reports_adverse_events: 1, audits_HAI: 0, audits_adverse_events: 0, reports_HAI_per_hospital: 0, reports_adverse_events_per_hospital: 0, score: 1 }
  { state_title: "Missouri",       state_abbreviation: "MO", reports_HAI: 2, reports_adverse_events: 1, audits_HAI: 2, audits_adverse_events: 0, reports_HAI_per_hospital: 2, reports_adverse_events_per_hospital: 0, score: 2 }
  { state_title: "Montana",        state_abbreviation: "MT", reports_HAI: 1, reports_adverse_events: 1, audits_HAI: 0, audits_adverse_events: 0, reports_HAI_per_hospital: 0, reports_adverse_events_per_hospital: 0, score: 1 }
  { state_title: "Nebraska",       state_abbreviation: "NE", reports_HAI: 2, reports_adverse_events: 2, audits_HAI: 1, audits_adverse_events: 1, reports_HAI_per_hospital: 1, reports_adverse_events_per_hospital: 1, score: 2 }
  { state_title: "Nevada",         state_abbreviation: "NV", reports_HAI: 2, reports_adverse_events: 2, audits_HAI: 2, audits_adverse_events: 2, reports_HAI_per_hospital: 2, reports_adverse_events_per_hospital: 2, score: 3 }
  { state_title: "New Hampshire",  state_abbreviation: "NH"  reports_HAI: 2, reports_adverse_events: 2, audits_HAI: 2, audits_adverse_events: 0, reports_HAI_per_hospital: 2, reports_adverse_events_per_hospital: 2, score: 2 }
  { state_title: "New Jersey",     state_abbreviation: "NJ"  reports_HAI: 2, reports_adverse_events: 2, audits_HAI: 2, audits_adverse_events: 2, reports_HAI_per_hospital: 2, reports_adverse_events_per_hospital: 2, score: 3 }
  { state_title: "New Mexico",     state_abbreviation: "NM"  reports_HAI: 1, reports_adverse_events: 1, audits_HAI: 0, audits_adverse_events: 0, reports_HAI_per_hospital: 0, reports_adverse_events_per_hospital: 0, score: 1 }
  { state_title: "New York",       state_abbreviation: "NY"  reports_HAI: 2, reports_adverse_events: 2, audits_HAI: 2, audits_adverse_events: 2, reports_HAI_per_hospital: 2, reports_adverse_events_per_hospital: 1, score: 2 }
  { state_title: "North Carolina", state_abbreviation: "NC"  reports_HAI: 2, reports_adverse_events: 1, audits_HAI: 2, audits_adverse_events: 0, reports_HAI_per_hospital: 2, reports_adverse_events_per_hospital: 0, score: 2 }
  { state_title: "North Dakota",   state_abbreviation: "ND"  reports_HAI: 1, reports_adverse_events: 1, audits_HAI: 0, audits_adverse_events: 0, reports_HAI_per_hospital: 0, reports_adverse_events_per_hospital: 0, score: 1 }
  { state_title: "Ohio",           state_abbreviation: "OH", reports_HAI: 2, reports_adverse_events: 2, audits_HAI: 1, audits_adverse_events: 1, reports_HAI_per_hospital: 2, reports_adverse_events_per_hospital: 2, score: 2 }
  { state_title: "Oklahoma",       state_abbreviation: "OK", reports_HAI: 2, reports_adverse_events: 2, audits_HAI: 1, audits_adverse_events: 1, reports_HAI_per_hospital: 2, reports_adverse_events_per_hospital: 2, score: 2 }
  { state_title: "Oregon",         state_abbreviation: "OR", reports_HAI: 2, reports_adverse_events: 1, audits_HAI: 2, audits_adverse_events: 0, reports_HAI_per_hospital: 2, reports_adverse_events_per_hospital: 0, score: 2 }
  { state_title: "Pennsylvania",   state_abbreviation: "PA", reports_HAI: 2, reports_adverse_events: 2, audits_HAI: 2, audits_adverse_events: 2, reports_HAI_per_hospital: 2, reports_adverse_events_per_hospital: 1, score: 2 }
  { state_title: "Rhode Island",   state_abbreviation: "RI"  reports_HAI: 2, reports_adverse_events: 2, audits_HAI: 1, audits_adverse_events: 1, reports_HAI_per_hospital: 2, reports_adverse_events_per_hospital: 1, score: 2 }
  { state_title: "South Carolina", state_abbreviation: "SC"  reports_HAI: 2, reports_adverse_events: 2, audits_HAI: 1, audits_adverse_events: 1, reports_HAI_per_hospital: 2, reports_adverse_events_per_hospital: 1, score: 2 }
  { state_title: "South Dakota",   state_abbreviation: "SD"  reports_HAI: 1, reports_adverse_events: 2, audits_HAI: 0, audits_adverse_events: 2, reports_HAI_per_hospital: 0, reports_adverse_events_per_hospital: 1, score: 2 }
  { state_title: "Tennessee",      state_abbreviation: "TN", reports_HAI: 2, reports_adverse_events: 2, audits_HAI: 2, audits_adverse_events: 2, reports_HAI_per_hospital: 2, reports_adverse_events_per_hospital: 1, score: 2 }
  { state_title: "Texas",          state_abbreviation: "TX", reports_HAI: 2, reports_adverse_events: 2, audits_HAI: 1, audits_adverse_events: 1, reports_HAI_per_hospital: 2, reports_adverse_events_per_hospital: 2, score: 2 }
  { state_title: "Utah",           state_abbreviation: "UT", reports_HAI: 2, reports_adverse_events: 2, audits_HAI: 1, audits_adverse_events: 2, reports_HAI_per_hospital: 2, reports_adverse_events_per_hospital: 1, score: 2 }
  { state_title: "Vermont",        state_abbreviation: "VT", reports_HAI: 2, reports_adverse_events: 2, audits_HAI: 0, audits_adverse_events: 2, reports_HAI_per_hospital: 2, reports_adverse_events_per_hospital: 1, score: 2 }
  { state_title: "Virginia",       state_abbreviation: "VA", reports_HAI: 2, reports_adverse_events: 1, audits_HAI: 1, audits_adverse_events: 0, reports_HAI_per_hospital: 2, reports_adverse_events_per_hospital: 0, score: 2 }
  { state_title: "Washington",     state_abbreviation: "WA", reports_HAI: 2, reports_adverse_events: 2, audits_HAI: 1, audits_adverse_events: 1, reports_HAI_per_hospital: 2, reports_adverse_events_per_hospital: 2, score: 2 }
  { state_title: "West",           state_abbreviation: "WV"  reports_HAI: 2, reports_adverse_events: 1, audits_HAI: 0, audits_adverse_events: 0, reports_HAI_per_hospital: 1, reports_adverse_events_per_hospital: 0, score: 2 }
  { state_title: "Wisconsin",      state_abbreviation: "WI", reports_HAI: 1, reports_adverse_events: 1, audits_HAI: 0, audits_adverse_events: 0, reports_HAI_per_hospital: 0, reports_adverse_events_per_hospital: 0, score: 1 }
  { state_title: "Wyoming",        state_abbreviation: "WY", reports_HAI: 1, reports_adverse_events: 1, audits_HAI: 0, audits_adverse_events: 0, reports_HAI_per_hospital: 0, reports_adverse_events_per_hospital: 0, score: 1 }
]