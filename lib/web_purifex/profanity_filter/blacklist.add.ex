defmodule WebPurifex.ProfanityFilter.Blacklist.Add do
  defstruct [:form_data]

  @method "webpurify.live.addtoblacklist"

  def new(word) do
    %__MODULE__{
      form_data: [
        {"method", @method},
        {"word", word}
      ]
    }
  end
end
