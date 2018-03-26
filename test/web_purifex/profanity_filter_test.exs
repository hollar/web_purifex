defmodule WebPurifex.ProfanityFilterTest do
  use ExUnit.Case, async: true
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  doctest WebPurifex

  alias  WebPurifex.{ProfanityFilter, Response, Error}

  setup_all do
    HTTPoison.start
  end

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

  describe "returning expletives" do
    test "returns single string considered profanity" do
      use_cassette "return_single_profanity" do
        {:ok, response} =
          "profanity"
          |> ProfanityFilter.return_text
          |> WebPurifex.request

        assert %Response{status: :ok, found: 1, expletive: "profanity"} = response
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

  describe "error handling" do
    test "without an API key returns an error" do
      use_cassette "invalid_api_key" do
        {:error, response} =
          "profanity"
          |> ProfanityFilter.check_text
          |> WebPurifex.request

        assert %Error{code: "100", message: "Invalid API Key"} = response
      end
    end

    test "an 404 HTTP error returns an error" do
      use_cassette "http_error" do
        {:error, response} =
          "profanity"
          |> ProfanityFilter.check_text
          |> WebPurifex.request(endpoint: "http://api1.webpurify.com/services/restx/")

        assert %Error{code: "unknown", message: "HTTP Status Code: 404"} = response
      end
    end

    test "an HTTP failure returns an error" do
      {:error, response} =
        "profanity"
        |> ProfanityFilter.check_text
        |> WebPurifex.request(endpoint: "http://doesnotexist.org")

      assert %Error{code: "unknown", message: "Network Error"} = response
    end
  end
end
