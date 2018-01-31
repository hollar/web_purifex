defmodule WebPurifex.Parser do
  @moduledoc """
  This module is responsible for parsing responses from the WebPurifex API and coercing them into
  their respsective structs.
  """
  alias WebPurifex.{Error, Response}

  @type result :: {:ok, any} | {:error, Error.t()}

  def parse({:ok, response}, action) do
    response.body
    |> Poison.decode!()
    |> do_parse(action)
  end

  def parse({:error, error_response}, _action), do: build_client_error(error_response)

  defp do_parse(%{"rsp" => %{"@attributes" => %{"stat" => "fail"}}} = response_body, _action) do
     build_client_error(response_body["rsp"]["err"])
  end

  defp do_parse(%{"rsp" => %{"@attributes" => %{"stat" => "ok"}}} = response_body, _action) do
    status =
      response_body
      |> get_in(["rsp", "@attributes", "stat"])
      |> String.to_atom

    found =
      response_body
      |> get_in(["rsp", "found"])
      |> Kernel.||("0")
      |> String.to_integer

    {:ok, %Response{status: status, found: found}}
  end

  defp build_client_error(%{"@attributes" => %{"code" => code, "msg" => message}}) do
    {:error, %Error{code: code, message: message}}
  end
  defp build_client_error(%{status_code: status_code}) do
    {:error, %Error{code: "unknown", message: "HTTP Status Code: #{status_code}"}}
  end
  defp build_client_error(:network_error) do
    {:error, %Error{code: "unknown", message: "Network Error"}}
  end
end
