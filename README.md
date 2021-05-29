# FontAwesome

![CI](https://github.com/miguel-s/ex_fontawesome/actions/workflows/ci.yml/badge.svg)

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

```elixir
<%= Fontawesome.icon("regular", "address-book", class: "h-4 w-4") %>
```

### With Surface

```elixir
<Fontawesome.Components.Icon type="regular" name="address-book" class="h-4 w-4" />
```
