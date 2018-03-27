defmodule WebPurifex.Response do
  defstruct [:status, :found, :expletive]

  @type t :: %__MODULE__{}
end
