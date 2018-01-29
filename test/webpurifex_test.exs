defmodule WebpurifexTest do
  use ExUnit.Case
  doctest Webpurifex

  @tag :integration
  test "adds a word to blacklist" do
    response =  Webpurifex.add_to_blacklist(":profanity:")
    assert response["rsp"]["success"] == "1"
    assert response["rsp"]["method"] == "webpurify.live.addtoblacklist"
  end
end
