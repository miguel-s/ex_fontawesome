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

    @doc "All options are forwarded to the underlying SVG tag as HTML attributes"
    prop opts, :keyword, default: []

    def render(assigns) do
      opts = class_to_opts(assigns) ++ assigns.opts

      ~H"""
      { FontAwesome.icon(@type, @name, opts) }
      """
    end

    defp class_to_opts(assigns) do
      case Map.get(assigns, :class) do
        nil -> []
        class -> [class: Surface.css_class(class)]
      end
    end
  end
end
