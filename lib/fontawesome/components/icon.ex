if Code.ensure_loaded?(Surface) do
  defmodule FontAwesome.Components.Icon do
    @moduledoc """
    A Surface component for rendering Font Awesome icons.

    ## Examples

        <FontAwesome.Components.Icon type="regular" name="address-book" class="h-4 w-4" />
    """

    use Surface.Component

    @doc "The type of the icon"
    prop type, :string, values: ["brand", "regular", "solid"], required: true

    @doc "The name of the icon"
    prop name, :string, required: true

    @doc "The class of the icon"
    prop class, :css_class

    def render(assigns) do
      opts =
        case Map.get(assigns, :class) do
          nil -> []
          class -> [class: Surface.css_class(class)]
        end

      ~H"""
      {{ FontAwesome.icon(@type, @name, opts) }}
      """
    end
  end
end
