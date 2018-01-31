defmodule WebPurifex.HTTP do
  def request(method, url, data, headers \\ []) do
    if Application.get_env(:web_purifex, WebPurifex.Config, [])[:debug_requests] do
      require Logger
      Logger.debug("REQUEST_URL: #{url}")
      Logger.debug("REQUEST_METHOD: #{method}")
      Logger.debug("REQUEST_HEADERS: #{inspect(headers)}")
      Logger.debug("REQUEST_BODY: #{inspect(data)}")
    end

    case HTTPoison.request(method, url, data, headers) do
      {:ok, %{status_code: code}} = response when code in 200..299 or code == 304 ->
        response

      {:ok, %{status_code: code}} when code in 400..499 ->
        {:error, %{status_code: code}}

      {:ok, %{status_code: code}} when code >= 500 ->
        raise "TODO handle this"

      {:error, _reason} -> {:error, :network_error}
    end
  end
end
