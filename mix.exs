defmodule ExFontawesome.MixProject do
  use Mix.Project

  @version "0.7.3"

  def project do
    [
      app: :ex_fontawesome,
      version: @version,
      elixir: "~> 1.11",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      docs: docs(),
      description: description(),
      package: package(),
      source_url: "https://github.com/miguel-s/ex_fontawesome"
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp deps do
    [
      {:ex_doc, "~> 0.38", only: :dev, runtime: false},
      {:floki, "~> 0.37", only: :test},
      {:phoenix_html, "~> 4.2"},
      {:phoenix_live_view, "~> 1.0", optional: true},
      {:surface, "~> 0.12", optional: true}
    ]
  end

  defp docs do
    [
      main: "FontAwesome",
      source_ref: "v#{@version}",
      source_url: "https://github.com/miguel-s/ex_fontawesome",
      groups_for_modules: [
        Liveview: ~r/FontAwesome.LiveView/,
        Surface: ~r/FontAwesome.Surface/
      ],
      nest_modules_by_prefix: [
        FontAwesome.LiveView,
        FontAwesome.Surface
      ],
      extras: ["README.md"]
    ]
  end

  defp description() do
    """
    This package adds a convenient way of using Font Awesome SVGs with your Phoenix, Phoenix LiveView and Surface applications.
    """
  end

  defp package do
    %{
      files: ~w(lib node_modules .formatter.exs mix.exs README* LICENSE* CHANGELOG*),
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/miguel-s/ex_fontawesome"}
    }
  end
end
