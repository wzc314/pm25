defmodule PM25.CLITest do
  use ExUnit.Case
  import PM25.CLI

  test "parses -h as help" do
    assert parse_args(["-h", "anything"]) == :help
    assert parse_args(["--help", "anything"]) == :help
    assert parse_args([]) == :help
  end

  test "accepts the city name" do
    assert parse_args(["changsha"]) == %{city: "changsha"}
    assert parse_args(["Changsha"]) == %{city: "changsha"}
  end

end
