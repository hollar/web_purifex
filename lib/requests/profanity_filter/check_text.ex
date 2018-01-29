defmodule Webpurifex.Requests.ProfanityFilter.CheckText do
  defstruct [:form_data]

  @method "webpurify.live.check"

  def build_request(text) do
    %__MODULE__{
      form_data: [
        {"method", @method},
        {"text", text}
      ]
    }
  end
end
