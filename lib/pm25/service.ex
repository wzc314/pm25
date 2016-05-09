defmodule PM25.Service do
  @pm25_api Application.get_env(:pm25, :pm25_api)

  def fetch(city) do
    city
    |> pm25_url
    |> HTTPoison.get
    |> parse_response
    |> scan_data
  end

  def pm25_url(city) do
    "#{@pm25_api}&city=#{city}"
  end

  def parse_response({:ok, %HTTPoison.Response{status_code: 200, body: body}}) do
    Poison.Parser.parse!(body)
  end

  def parse_response({:error, %HTTPoison.Error{reason: reason}}) do
    IO.puts "parse_response error: #{reason}"
    System.halt(2)
  end

  def extract_aqi([%{"citynow" => %{"AQI" => aqi}}]) do
    aqi
  end

  def scan_data(%{"resultcode" => "200", "result" => result}) do
    result
    |> extract_aqi
  end

  def scan_data(%{"resultcode" => resultcode, "error_code" => error_code, "reason" => reason}) do
    IO.puts "resultcode: #{resultcode}\nerrorcode: #{error_code}\nreason: #{reason}"
    System.halt(2)
  end

end
