defmodule MatomoClientTest do
  use ExUnit.Case
  doctest MatomoClient

  test "greets the world" do
    assert MatomoClient.hello() == :world
  end
end
