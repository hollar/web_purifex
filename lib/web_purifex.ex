defmodule WebPurifex do
  alias WebPurifex.ProfanityFilter

  def blacklist(word) do
    word
    |> ProfanityFilter.Blacklist.Add.build_request
    |> post
  end

  def get_blacklist() do
    post ProfanityFilter.Blacklist.GetList.build_request
  end

  def check_text(text) do
    text
    |> ProfanityFilter.CheckText.build_request
    |> post
  end

  def whitelist(word) do
    word
    |> ProfanityFilter.Whitelist.Add.build_request
    |> post
  end

  defp post(%{form_data: form_data}) do
    body =  build_form_body(form_data)
    {:ok, response} = WebPurifex.HTTP.request(:post, get_base_url(), body)
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
    Application.get_env(:web_purifex, :api_key)
  end
end
