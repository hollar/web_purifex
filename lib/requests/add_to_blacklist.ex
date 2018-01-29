defmodule Webpurifex.Requests.AddToBlacklist do
  defstruct [:form_data]

  @method "webpurify.live.addtoblacklist"

  def build_request(word) do
    %__MODULE__{
      form_data: [
        {"method", @method},
        {"word", word}
      ]
    }
  end
end
