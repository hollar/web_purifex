defmodule WebPurifex.ProfanityFilter.CheckText do
  defstruct [:form_data]

  @method "webpurify.live.check"

  def new(text) do
    %__MODULE__{
      form_data: [
        {"method", @method},
        {"text", text}
      ]
    }
  end
end
