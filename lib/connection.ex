defmodule MatomoClient.Connection do
  require Logger
  @server_url Application.get_env(:matomo_client, :server_url)
  @site_id Application.get_env(:matomo_client, :site_id)
  @token_auth Application.get_env(:matomo_client, :token_auth)


  def send_request(data) do
    params = %{idsite: @site_id, token_auth: @token_auth, rec: 1, apiv: 1} |> Map.put(:_id, uuid_to_id(data[:uid])) |> Map.merge(data)
    url = @server_url <> "/matomo.php?" <> URI.encode_query(params)

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
