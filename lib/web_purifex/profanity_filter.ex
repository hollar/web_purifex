defmodule WebPurifex.ProfanityFilter do
  alias WebPurifex.ProfanityFilter

  def blacklist(word) do
    ProfanityFilter.Blacklist.Add.new(word)
  end

  def get_blacklist() do
    ProfanityFilter.Blacklist.GetList.new
  end

  def check_text(text) do
    ProfanityFilter.CheckText.new(text)
  end

  def whitelist(word) do
    ProfanityFilter.Whitelist.Add.new(word)
  end
end
