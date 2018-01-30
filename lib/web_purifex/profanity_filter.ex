defmodule WebPurifex.ProfanityFilter do
  alias WebPurifex.ProfanityFilter

  def blacklist(word) do
    ProfanityFilter.Blacklist.Add.build_request(word)
  end

  def get_blacklist() do
    ProfanityFilter.Blacklist.GetList.build_request
  end

  def check_text(text) do
    ProfanityFilter.CheckText.build_request(text)
  end

  def whitelist(word) do
    ProfanityFilter.Whitelist.Add.build_request(word)
  end
end
