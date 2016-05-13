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
    body
    |> Poison.Parser.parse!
  end

  def parse_response({:error, %HTTPoison.Error{reason: reason}}) do
    IO.puts "parse_response error: #{reason}"
    System.halt(2)
  end

  def scan_data(%{"showapi_res_code" => 0, "showapi_res_body" => body}) do
    body
    |> extract_aqi
  end

  def scan_data(%{"showapi_res_code" => res_code, "showapi_res_error" => res_error}) do
    IO.puts "showapi_res_code: #{res_code}\nshowapi_res_error: #{res_error}"
    System.halt(2)
  end
  
  def extract_aqi(%{"pm" => %{"aqi" => aqi}}) do
    "#{aqi}"
  end

  def extract_aqi(%{"error_info" => error_info}) do
    IO.puts error_info
    System.halt(2)
  end

end
