defmodule ElixirNeowsClient do

  @url Application.get_env :elixir_neows_client, :neows_url
  @api_key Application.get_env :elixir_neows_client, :api_key

  def fetch_from_nasa(from, to) do
    HTTPoison.get("#{@url}?start_date=#{from}&end_date=#{to}&api_key=#{@api_key}")
    |> process_response
    |> filter_response
  end

  defp process_response({:ok, %{status_code: 200, body: body}}), do: Poison.Parser.parse!(body)
  defp process_response({:ok, %{status_code: 400, body: body}}), do: Poison.Parser.parse!(body) |> Map.get("http_error")
  defp process_response({:error, _}), do: "Error in fetching informations from NASA ws."

  defp filter_response(response) do
    response
  end

end
