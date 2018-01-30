defmodule WebPurifex.Parser do
  @moduledoc """
  This module is responsible for parsing responses from the WebPurifex API and coercing them into
  their respsective structs.
  """

  @type result :: {:ok, any} | {:error, WebPurifex.Error.t()}

  def parse({:ok, response}, action) do
    response.body
    |> Poison.decode!()
    |> parse(action)
  end

  def parse({:error, error_response}, _action), do: build_client_error(error_response)

  def parse(response, _action) do
    status =
      response
      |> get_in(["rsp", "@attributes", "stat"])
      |> String.to_atom

    found =
      response
      |> get_in(["rsp", "found"])
      |> Kernel.||("0")
      |> String.to_integer

    {:ok, %WebPurifex.Response{status: status, found: found}}
  end

  defp build_client_error(error) do
    error_messages =
      error.body
      |> Poison.decode!()
      |> Map.take(["error", "detail"])

    message = "#{error_messages["error"]}. #{error_messages["detail"]}"

    {:error, %WebPurifex.Error{code: error.status_code, message: message}}
  end
end
