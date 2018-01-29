defmodule WebpurifexTest do
  use ExUnit.Case
  doctest Webpurifex

  @tag :integration
  test "adds a word to blacklist" do
    response =  Webpurifex.add_to_blacklist(":profanity:")

    assert response["rsp"]["success"] == "1"
    assert response["rsp"]["method"] == "webpurify.live.addtoblacklist"
  end

  describe "checking a text" do
    test "checks text with profanity" do
      Webpurifex.add_to_blacklist("profanity")

      response =  Webpurifex.check_text("profanity")

      assert response["rsp"]["@attributes"]["stat"] == "ok"
      assert response["rsp"]["found"] == "1"
      assert response["rsp"]["method"] == "webpurify.live.check"
    end

    test "checks text without profanity" do
      response =  Webpurifex.check_text(":sane_word:")

      assert response["rsp"]["@attributes"]["stat"] == "ok"
      assert response["rsp"]["found"] == "0"
      assert response["rsp"]["method"] == "webpurify.live.check"
    end
  end
end
