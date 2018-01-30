defmodule WebPurifex do
  @base_url "http://api1.webpurify.com/services/rest/"

  alias WebPurifex.{HTTP, Parser}
  def request(%{form_data: form_data}) do
    form_data
    |> build_form_body()
    |> do_request
    |> parse
  end

  defp do_request(body) do
    HTTP.request(:post, @base_url, body)
  end

  defp parse(result) do
    Parser.parse(result, :any_action)
  end

  defp build_form_body(form_data) do
    form_data = form_data ++ [
      {"api_key", get_api_key()},
      {"format", "json"}
    ]
    {:form, form_data}
  end

  defp get_api_key() do[]
    Application.get_env(:web_purifex, :api_key)
  end
end
