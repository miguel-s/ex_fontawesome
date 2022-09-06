# FontAwesome

![CI](https://github.com/miguel-s/ex_fontawesome/actions/workflows/ci.yml/badge.svg)

This package adds a convenient way of using [Font Awesome](https://fontawesome.com) SVGs with your Phoenix, Phoenix LiveView and Surface applications.

You can find the original docs [here](https://fontawesome.com) and repo [here](https://github.com/FortAwesome/Font-Awesome).

Current FontAwesome version: 6.2.0

## Installation

Add `ex_fontawesome` to the list of dependencies in `mix.exs`:

    def deps do
      [
        {:ex_fontawesome, "~> 0.7.1"}
      ]
    end

Then run `mix deps.get`.

## Usage

#### With Eex or Leex

```elixir
<%= FontAwesome.icon("address-book", type: "regular", class: "h-4 w-4") %>
```

#### With Heex

```elixir
<FontAwesome.LiveView.icon name="address-book" type="regular" class="h-4 w-4" />
```

#### With Surface

```elixir
<FontAwesome.Surface.Icon name="address-book" type="regular" class="h-4 w-4" />
```

## Config

Defaults can be set in the `FontAwesome` application configuration.

```elixir
config :ex_fontawesome, type: "regular"
```

## License

MIT. See [LICENSE](https://github.com/miguel-s/ex_fontawesome/blob/master/LICENSE) for more details.
