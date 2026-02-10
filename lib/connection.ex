defmodule MatomoClient.Connection do
  require Logger
  @server_url Application.get_env(:matomo_client, :server_url)
  @site_id Application.get_env(:matomo_client, :site_id)

  def request(data) do
    uuid = data["uuid"]
    action = data["action"]

    params = %{idsite: @site_id, rec: 1, apiv: 1, uid: uuid, action_name: action} |> Map.put(:_id, uuid_to_id(uuid))
    Logger.info("params: #{inspect(params)}")
    url_params = Enum.map(Map.keys(params), fn(key) -> "#{key}=#{params[key]}" end) |> Enum.join("&")

    url = @server_url <> "/matomo.php?" <> url_params

    case :hackney.request(:get, url, headers(), [], [recv_timeout: :infinity]) do
      {:ok, 200, _headers, ref} ->
        {:ok, body} = :hackney.body(ref)
      {:ok, status, _headers, ref} ->
        {:ok, body} = :hackney.body(ref)
        {:error, status, body}
      {:error, :closed} ->
        {:error, "Connection closed"}
    end
  end


  def uuid_to_id(uuid) do
    crc = Crc64.calculate(uuid)
    String.slice(to_string(crc), 0..15)
  end

  def headers, do: []


end
