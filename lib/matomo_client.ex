defmodule MatomoClient do
  @moduledoc """
  Documentation for `MatomoClient`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> MatomoClient.hello()
      :world

  """

  def track_event(data) do
    MatomoClient.Connection.send_request(data)
  end

  def track_event_async(data) do
    Task.start(MatomoClient.Connection, :send_request, [data])
  end

end
