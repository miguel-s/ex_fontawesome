defmodule FontAwesome.Surface.IconTest do
  use FontAwesome.ConnCase, async: true

  alias FontAwesome.Surface.Icon

  test "renders icon" do
    html =
      render_surface do
        ~F"""
        <Icon name="address-book" type="regular" />
        """
      end

    assert html =~ "<svg"
  end

  test "renders icon with class" do
    html =
      render_surface do
        ~F"""
        <Icon name="address-book" type="regular" class="h-4 w-4" />
        """
      end

    assert html =~ ~s(<svg class="h-4 w-4")
  end

  test "renders icon with opts" do
    html =
      render_surface do
        ~F"""
        <Icon name="address-book" type="regular" opts={aria_hidden: true} />
        """
      end

    assert html =~ ~s(<svg aria-hidden="true")
  end

  test "class prop overrides opts prop" do
    html =
      render_surface do
        ~F"""
        <Icon name="address-book" type="regular" class="hello" opts={class: "world"} />
        """
      end

    assert html =~ ~s(<svg class="hello")
  end

  test "raises if icon name does not exist" do
    msg = ~s(icon "hello" with type "regular" does not exist.)

    assert_raise ArgumentError, msg, fn ->
      render_surface do
        ~F"""
        <Icon name="hello" type="regular" />
        """
      end
    end
  end

  test "raises if type is missing" do
    msg = ~s(type prop is required if default type is not configured.)

    assert_raise ArgumentError, msg, fn ->
      render_surface do
        ~F"""
        <Icon name="hello" />
        """
      end
    end
  end

  test "raises if icon type does not exist" do
    msg = ~s(expected type to be one of #{inspect(FontAwesome.types())}, got: "world")

    assert_raise ArgumentError, msg, fn ->
      render_surface do
        ~F"""
        <Icon name="address-book" type="world" />
        """
      end
    end
  end
end

defmodule FontAwesome.Surface.IconConfigTest do
  use FontAwesome.ConnCase

  alias FontAwesome.Surface.Icon

  test "renders icon with default type" do
    Application.put_env(:ex_fontawesome, :type, "regular")

    html =
      render_surface do
        ~F"""
        <Icon name="address-book" />
        """
      end

    assert html =~ "<svg"
  end

  test "raises if default icon type does not exist" do
    Application.put_env(:ex_fontawesome, :type, "world")

    msg = ~s(expected default type to be one of #{inspect(FontAwesome.types())}, got: "world")

    assert_raise ArgumentError, msg, fn ->
      render_surface do
        ~F"""
        <Icon name="address-book" />
        """
      end
    end
  end
end
