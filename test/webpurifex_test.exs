defmodule WebpurifexTest do
  use ExUnit.Case, async: true
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  doctest Webpurifex

  setup_all do
    HTTPoison.start
  end

  @tag :integration
  test "adds a word to blacklist" do
    use_cassette "add_to_blacklist" do
      response =  Webpurifex.add_to_blacklist(":profanity:")

      assert response["rsp"]["success"] == "1"
      assert response["rsp"]["method"] == "webpurify.live.addtoblacklist"
    end
  end

  describe "checking a text" do
    test "checks text with profanity" do
      use_cassette "check_profanity" do
        # Webpurifex.add_to_blacklist("profanity")

        response =  Webpurifex.check_text("profanity")

        assert response["rsp"]["@attributes"]["stat"] == "ok"
        assert response["rsp"]["found"] == "1"
        assert response["rsp"]["method"] == "webpurify.live.check"
      end
    end

    test "checks text without profanity" do
      use_cassette "check_non_profanity" do
        response =  Webpurifex.check_text(":sane_word:")

        assert response["rsp"]["@attributes"]["stat"] == "ok"
        assert response["rsp"]["found"] == "0"
        assert response["rsp"]["method"] == "webpurify.live.check"
      end
    end
  end
end
