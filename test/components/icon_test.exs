defmodule FontAwesome.Components.IconTest do
  use ExUnit.Case, async: true
  use Surface.LiveViewTest

  alias FontAwesome.Components.Icon

  @endpoint Endpoint

  test "renders icon" do
    html =
      render_surface do
        ~H"""
        <Icon type="regular" name="address-book" />
        """
      end

    assert html =~ "<svg"
  end

  test "renders icon with class" do
    html =
      render_surface do
        ~H"""
        <Icon type="regular" name="address-book" class="h-4 w-4" />
        """
      end

    assert html =~ ~s(<svg class="h-4 w-4")
  end

  test "raises if type or icon don't exist" do
    msg = ~s(icon of type "hello" with name "address-book" does not exist.)

    assert_raise ArgumentError, msg, fn ->
      render_surface do
        ~H"""
        <Icon type="hello" name="address-book" />
        """
      end
    end

    msg = ~s(icon of type "regular" with name "world" does not exist.)

    assert_raise ArgumentError, msg, fn ->
      render_surface do
        ~H"""
        <Icon type="regular" name="world" />
        """
      end
    end
  end
end
