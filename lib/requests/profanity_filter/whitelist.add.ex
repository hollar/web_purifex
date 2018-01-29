defmodule Webpurifex.Requests.ProfanityFilter.Whitelist.Add do
  defstruct [:form_data]

  @method "webpurify.live.addtowhitelist"

  def build_request(word) do
    %__MODULE__{
      form_data: [
        {"method", @method},
        {"word", word}
      ]
    }
  end
end
