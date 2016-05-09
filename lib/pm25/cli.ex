defmodule PM25.CLI do
  import PM25.Service, only: [fetch: 1]
  import PM25.ASCII, only: [pretty_print: 1]

  def main(argv) do
    argv
    |> parse_args
    |> process
    |> pretty_print
  end

  def parse_args(argv) do
    parse = OptionParser.parse(argv,
      switches: [help: :boolean],
      aliases: [h: :help])
    case parse do
      {[help: true], _, _} -> :help
      {_, [city], _} -> %{city: String.downcase(city)}
      {_, _, _} -> :help
    end
  end

  def process(:help) do
    IO.puts """
    Usage: pm25 <city_name>
    """
    System.halt(0)
  end

  def process(%{city: city}) when is_binary(city) do
    fetch city
  end
  def process(%{city: city}), do: %{city: to_string(city)}
end
