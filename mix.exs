defmodule MatomoClient.MixProject do
  use Mix.Project

  def project do
    [
      app: :matomo_client,
      version: "0.1.0",
      elixir: "~> 1.18",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :hackney]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:hackney, "~> 1.23"},
      {:poison, "~> 6.0"},
      {:crc_64, "~> 0.1.0"}
    ]
  end
end
