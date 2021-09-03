defmodule ExFontawesome.MixProject do
  use Mix.Project

  @version "0.3.1"

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
      {:phoenix_html, "~> 2.14 or ~> 3.0"},
      {:ex_doc, "~> 0.24", only: :dev, runtime: false},
      {:floki, ">= 0.30.0", only: :test},
      {:surface, "~> 0.5", optional: true}
    ]
  end

  defp docs do
    [
      main: "FontAwesome",
      source_ref: "v#{@version}",
      source_url: "https://github.com/miguel-s/ex_fontawesome",
      groups_for_modules: [
        Components: ~r/FontAwesome.Component/
      ],
      nest_modules_by_prefix: [
        FontAwesome.Components
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
