defmodule WebPurifex.ProfanityFilter.Whitelist.Add do
  defstruct [:form_data]

  @method "webpurify.live.addtowhitelist"

  def new(word) do
    %__MODULE__{
      form_data: [
        {"method", @method},
        {"word", word}
      ]
    }
  end
end
