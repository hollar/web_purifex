defmodule WebPurifex.Error do
  defstruct [:code, :message]

  @type t :: %__MODULE__{}
end
