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

  def track_event() do
    MatomoClient.Connection.send_request(data)
  end
end
