defmodule WebPurifex.ProfanityFilter.ReturnText do
  defstruct [:form_data]

  @method "webpurify.live.return"

  def new(text) do
    %__MODULE__{
      form_data: [
        {"method", @method},
        {"text", text}
      ]
    }
  end
end
