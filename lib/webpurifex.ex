defmodule Webpurifex do
  alias Webpurifex.Requests

  def blacklist(word) do
    word
    |> Requests.ProfanityFilter.Blacklist.Add.build_request
    |> post
  end

  def get_blacklist() do
    post Requests.ProfanityFilter.Blacklist.GetList.build_request
  end

  def check_text(text) do
    text
    |> Requests.ProfanityFilter.CheckText.build_request
    |> post
  end

  def whitelist(word) do
    word
    |> Requests.ProfanityFilter.Whitelist.Add.build_request
    |> post
  end

  defp post(%{form_data: form_data}) do
    body =  build_form_body(form_data)
    {:ok, response} = HTTPoison.post(get_base_url(), body)
    Poison.Parser.parse!(response.body)
  end

  defp build_form_body(form_data) do
    form_data = form_data ++ [
      {"api_key", get_api_key()},
      {"format", "json"}
    ]
    {:form, form_data}
  end

  defp get_base_url(), do: "http://api1.webpurify.com/services/rest/"
  defp get_api_key() do[]
    Application.get_env(:webpurifex, :api_key)
  end
end
