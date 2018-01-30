defmodule WebPurifex.Response do
  defstruct [:status, :found]

  @type t :: %__MODULE__{}
end
