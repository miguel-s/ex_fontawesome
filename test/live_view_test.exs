defmodule FontAwesome.LiveViewTest do
  use FontAwesome.ConnCase, async: true
  import Phoenix.LiveView.Helpers

  alias FontAwesome.LiveView

  test "renders icon" do
    assigns = %{}

    html =
      rendered_to_string(~H"""
      <LiveView.icon name="address-book" type="regular" />
      """)

    assert html =~ "<svg"
  end

  test "renders icon with class" do
    assigns = %{}

    html =
      rendered_to_string(~H"""
      <LiveView.icon name="address-book" type="regular" class="h-4 w-4" />
      """)

    assert html =~ ~s(<svg class="h-4 w-4")
  end

  test "renders icon with opts" do
    assigns = %{}

    html =
      rendered_to_string(~H"""
      <LiveView.icon name="address-book" type="regular" opts={[aria_hidden: true]} />
      """)

    assert html =~ ~s(<svg aria-hidden="true")
  end

  test "class prop overrides opts prop" do
    assigns = %{}

    html =
      rendered_to_string(~H"""
      <LiveView.icon name="address-book" type="regular" class="hello" opts={[class: "world"]} />
      """)

    assert html =~ ~s(<svg class="hello")
  end

  test "raises if icon name does not exist" do
    assigns = %{}
    msg = ~s(icon "hello" with type "regular" does not exist.)

    assert_raise ArgumentError, msg, fn ->
      rendered_to_string(~H"""
      <LiveView.icon name="hello" type="regular" />
      """)
    end
  end

  test "raises if type is missing" do
    assigns = %{}
    msg = ~s(type prop is required if default type is not configured.)

    assert_raise ArgumentError, msg, fn ->
      rendered_to_string(~H"""
      <LiveView.icon name="hello" />
      """)
    end
  end

  test "raises if icon type does not exist" do
    assigns = %{}
    msg = ~s(expected type to be one of #{inspect(FontAwesome.types())}, got: "world")

    assert_raise ArgumentError, msg, fn ->
      rendered_to_string(~H"""
      <LiveView.icon name="address-book" type="world" />
      """)
    end
  end
end

defmodule FontAwesome.LiveViewConfigTest do
  use FontAwesome.ConnCase
  import Phoenix.LiveView.Helpers

  alias FontAwesome.LiveView

  test "renders icon with default type" do
    Application.put_env(:ex_fontawesome, :type, "regular")

    assigns = %{}

    html =
      rendered_to_string(~H"""
      <LiveView.icon name="address-book" />
      """)

    assert html =~ "<svg"
  end

  test "raises if default icon type does not exist" do
    Application.put_env(:ex_fontawesome, :type, "world")

    assigns = %{}
    msg = ~s(expected default type to be one of #{inspect(FontAwesome.types())}, got: "world")

    assert_raise ArgumentError, msg, fn ->
      rendered_to_string(~H"""
      <LiveView.icon name="address-book" />
      """)
    end
  end
end
