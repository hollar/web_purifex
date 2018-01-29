defmodule Webpurifex do
  alias Webpurifex.Requests

  def add_to_blacklist(word) do
    word
    |> Requests.AddToBlacklist.build_request
    |> post
  end

  def check_text(text) do
    text
    |> Requests.CheckText.build_request
    |> post
  end

  defp post(%{form_data: form_data}) do
    form_data =  build_form_data(form_data)
    {:ok, response} = HTTPoison.post(get_base_url(), form_data)
    Poison.Parser.parse!(response.body)
  end

  defp build_form_body(data) do
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
