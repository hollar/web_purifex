defmodule WebPurifex.ProfanityFilterTest do
  use ExUnit.Case, async: true
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  doctest WebPurifex

  alias  WebPurifex.{ProfanityFilter, Response}

  setup_all do
    HTTPoison.start
  end

  @tag :integration
  describe "blacklisting a word" do
    test "blacklisting a word" do
      use_cassette "add_to_blacklist" do
        {:ok, response} =
          ":profanity:"
          |> ProfanityFilter.blacklist
          |> WebPurifex.request

        assert %Response{status: :ok} = response
      end
    end

    test "list blacklisted words" do
      use_cassette "get_blacklist" do
        {:ok, response} = ProfanityFilter.get_blacklist |> WebPurifex.request

        assert %Response{status: :ok} = response
      end
    end
  end

  describe "checking a text" do
    test "checks text with profanity" do
      use_cassette "check_profanity" do
        {:ok, response} =
          "profanity"
          |> ProfanityFilter.check_text
          |> WebPurifex.request

        assert %Response{status: :ok, found: 1} = response
      end
    end

    test "checks text without profanity" do
      use_cassette "check_non_profanity" do
        {:ok, response} =
          ":sane_word:"
          |> ProfanityFilter.check_text
          |> WebPurifex.request

        assert %Response{status: :ok, found: 0} = response
      end
    end
  end

  describe "whitelisting a word" do
    test "adds a word to the whitelist" do
      use_cassette "whitelist_profanity" do
        {:ok, response} =
          "ok_profanity"
          |> ProfanityFilter.whitelist
          |> WebPurifex.request

        assert %Response{status: :ok} = response
      end
    end
  end
end
