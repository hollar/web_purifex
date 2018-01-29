defmodule Webpurifex.Requests.ProfanityFilter.Blacklist.GetList do
  defstruct [:form_data]

  @method "webpurify.live.getblacklist"

  def build_request do
    %__MODULE__{
      form_data: [
        {"method", @method},
      ]
    }
  end
end