defmodule FontAwesome do
  @moduledoc """
  This package adds a convenient way of using [Font Awesome](https://fontawesome.com) SVGs with your Phoenix, Phoenix LiveView and Surface applications.

  You can find the original docs [here](https://fontawesome.com) and repo [here](https://github.com/FortAwesome/Font-Awesome).

  ## Installation

  Add `ex_fontawesome` to the list of dependencies in `mix.exs`:

      def deps do
        [
          {:ex_fontawesome, "~> 0.5.0"}
        ]
      end

  Then run `mix deps.get`.

  ## Usage

  #### With Eex or Leex

      <%= FontAwesome.icon("address-book", type: "regular", class: "h-4 w-4") %>

  #### With Heex

      <FontAwesome.LiveView.icon name="address-book" type="regular" class="h-4 w-4" />

  #### With Surface

      <FontAwesome.Surface.Icon name="address-book" type="regular" class="h-4 w-4" />

  ## Config

  Defaults can be set in the `FontAwesome` application configuration.

      config :ex_hfontawesome, type: "regular"

  """

  alias __MODULE__.Icon

  icon_paths = "node_modules/@fortawesome/fontawesome-free/svgs/**/*.svg" |> Path.wildcard()

  icons =
    for icon_path <- icon_paths do
      @external_resource Path.relative_to_cwd(icon_path)
      Icon.parse!(icon_path)
    end

  types = icons |> Enum.map(& &1.type) |> Enum.uniq()
  names = icons |> Enum.map(& &1.name) |> Enum.uniq()

  @types types
  @names names

  @doc "Returns a list of available icon types"
  @spec types() :: [String.t()]
  def types(), do: @types

  @doc "Returns a list of available icon names"
  @spec names() :: [String.t()]
  def names(), do: @names

  @doc false
  def default_type() do
    case Application.get_env(:ex_fontawesome, :type) do
      nil ->
        nil

      type when is_binary(type) ->
        if type in types() do
          type
        else
          raise ArgumentError,
                "expected default type to be one of #{inspect(types())}, got: #{inspect(type)}"
        end

      type ->
        raise ArgumentError,
              "expected default type to be one of #{inspect(types())}, got: #{inspect(type)}"
    end
  end

  @doc """
  Generates an icon.

  Options may be passed through to the SVG tag for custom attributes.

  ## Options

    * `:type` - the icon type. Accepted values are #{inspect(types)}. Required if default type is not configured.
    * `:class` - the css class added to the SVG tag

  ## Examples

      icon("address-book", type: "regular", class: "h-4 w-4")
      #=> <svg class="h-4 w-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512">
            <!-- Font Awesome Free 5.15.3 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free (Icons: CC BY 4.0, Fonts: SIL OFL 1.1, Code: MIT License) -->
            <path d="M436 160c6.6 0 12-5.4 12-12v-40c0-6.6-5.4-12-12-12h-20V48c0-26.5-21.5-48-48-48H48C21.5 0 0 21.5 0 48v416c0 26.5 21.5 48 48 48h320c26.5 0 48-21.5 48-48v-48h20c6.6 0 12-5.4 12-12v-40c0-6.6-5.4-12-12-12h-20v-64h20c6.6 0 12-5.4 12-12v-40c0-6.6-5.4-12-12-12h-20v-64h20zm-68 304H48V48h320v416zM208 256c35.3 0 64-28.7 64-64s-28.7-64-64-64-64 28.7-64 64 28.7 64 64 64zm-89.6 128h179.2c12.4 0 22.4-8.6 22.4-19.2v-19.2c0-31.8-30.1-57.6-67.2-57.6-10.8 0-18.7 8-44.8 8-26.9 0-33.4-8-44.8-8-37.1 0-67.2 25.8-67.2 57.6v19.2c0 10.6 10 19.2 22.4 19.2z"/>
          </svg>
  """
  @spec icon(String.t(), keyword) :: Phoenix.HTML.safe()
  def icon(name, opts \\ []) when is_binary(name) and is_list(opts) do
    {type, opts} = Keyword.pop(opts, :type, default_type())

    unless type do
      raise ArgumentError,
            "expected type in options, got: #{inspect(opts)}"
    end

    unless type in types() do
      raise ArgumentError,
            "expected type to be one of #{inspect(types())}, got: #{inspect(type)}"
    end

    icon(type, name, opts)
  end

  for %Icon{type: type, name: name, file: file} <- icons do
    defp icon(unquote(type), unquote(name), opts) do
      attrs = Icon.opts_to_attrs(opts)
      Icon.insert_attrs(unquote(file), attrs)
    end
  end

  defp icon(type, name, _opts) do
    raise ArgumentError,
          "icon #{inspect(name)} with type #{inspect(type)} does not exist."
  end
end
