defmodule WebPurifex do
  def get_base_url(), do: "http://api1.webpurify.com/services/rest/"
  def get_api_key() do[]
    Application.get_env(:web_purifex, :api_key)
  end
end
