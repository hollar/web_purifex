use Mix.Config

config :exvcr, [
  filter_sensitive_data: [
    [pattern: "api_key=.+\&", placeholder: "API_KEY&"],
    [pattern: "\"api_key\":\".+\"", placeholder: "\"api_key\":\"API_KEY\""]
  ]
]
