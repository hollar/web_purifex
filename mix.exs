defmodule WebPurifex.Mixfile do
  use Mix.Project

  def project do
    [
      app: :web_purifex,
      version: "0.1.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpoison, "~> 0.8"},
      {:poison, "~> 3.1"},
      {:exvcr, "~> 0.8", only: :test},
      {:mix_test_watch, "~> 0.5", only: :dev, runtime: false}
    ]
  end
end
