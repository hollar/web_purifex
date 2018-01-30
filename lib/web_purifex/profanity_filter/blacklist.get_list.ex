defmodule WebPurifex.ProfanityFilter.Blacklist.GetList do
  defstruct [:form_data]

  @method "webpurify.live.getblacklist"

  def new do
    %__MODULE__{
      form_data: [
        {"method", @method},
      ]
    }
  end
end
