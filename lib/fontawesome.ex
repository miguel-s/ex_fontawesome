defmodule FontAwesome do
  @moduledoc """
  This package adds a convenient way of using [Font Awesome](https://fontawesome.com) SVGs with your Phoenix, Phoenix LiveView and Surface applications.

  You can find the original docs [here](https://fontawesome.com) and repo [here](https://github.com/FortAwesome/Font-Awesome).

  ## Installation

  Add `ex_fontawesome` to the list of dependencies in `mix.exs`:

      def deps do
        [
          {:ex_fontawesome, "~> 0.1.1"}
        ]
      end

  Then run `mix deps.get`.

  ## Usage

  ### With Eex or Leex

      <%= Fontawesome.icon("regular", "address-book", class: "h-4 w-4") %>

  ### With Surface

      <Fontawesome.Components.Icon type="regular" name="address-book" class="h-4 w-4" />
  """

  alias __MODULE__.Icon

  icon_paths = "node_modules/@fortawesome/fontawesome-free/svgs/**/*.svg" |> Path.wildcard()

  icons =
    for icon_path <- icon_paths do
      @external_resource Path.relative_to_cwd(icon_path)
      Icon.parse!(icon_path)
    end

  @doc """
  Generates an icon.

  All options are forwarded to the underlying SVG tag as HTML attributes.

  ## Options

    * `:class` - the css class added to the SVG tag

  ## Examples

      icon("regular", "address-book", class: "h-4 w-4")
      #=> <svg class="h-4 w-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512">
            <!-- Font Awesome Free 5.15.3 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free (Icons: CC BY 4.0, Fonts: SIL OFL 1.1, Code: MIT License) -->
            <path d="M436 160c6.6 0 12-5.4 12-12v-40c0-6.6-5.4-12-12-12h-20V48c0-26.5-21.5-48-48-48H48C21.5 0 0 21.5 0 48v416c0 26.5 21.5 48 48 48h320c26.5 0 48-21.5 48-48v-48h20c6.6 0 12-5.4 12-12v-40c0-6.6-5.4-12-12-12h-20v-64h20c6.6 0 12-5.4 12-12v-40c0-6.6-5.4-12-12-12h-20v-64h20zm-68 304H48V48h320v416zM208 256c35.3 0 64-28.7 64-64s-28.7-64-64-64-64 28.7-64 64 28.7 64 64 64zm-89.6 128h179.2c12.4 0 22.4-8.6 22.4-19.2v-19.2c0-31.8-30.1-57.6-67.2-57.6-10.8 0-18.7 8-44.8 8-26.9 0-33.4-8-44.8-8-37.1 0-67.2 25.8-67.2 57.6v19.2c0 10.6 10 19.2 22.4 19.2z"/>
          </svg>
  """
  def icon(type, name, opts \\ [])

  for %Icon{type: type, name: name, file: file} <- icons do
    def icon(unquote(type), unquote(name), opts) do
      attrs = Icon.opts_to_attrs(opts)
      Icon.insert_attrs(unquote(file), attrs)
    end
  end

  def icon(type, name, _opts) do
    raise ArgumentError,
          "icon of type #{inspect(type)} with name #{inspect(name)} does not exist."
  end
end
