defmodule FontAwesomeTest do
  use ExUnit.Case, async: true
  doctest FontAwesome

  test "renders icon" do
    assert FontAwesome.icon("regular", "address-book")
           |> Phoenix.HTML.safe_to_string() =~ "<svg"
  end

  test "renders icon with attribute" do
    assert FontAwesome.icon("regular", "address-book", class: "h-4 w-4")
           |> Phoenix.HTML.safe_to_string() =~ ~s(<svg class="h-4 w-4")
  end

  test "converts opts to attributes" do
    assert FontAwesome.icon("regular", "address-book", aria_hidden: true)
           |> Phoenix.HTML.safe_to_string() =~ ~s(<svg aria-hidden="true")
  end

  test "raises if type or icon don't exist" do
    msg = ~s(icon of type "hello" with name "address-book" does not exist.)

    assert_raise ArgumentError, msg, fn ->
      FontAwesome.icon("hello", "address-book")
    end

    msg = ~s(icon of type "regular" with name "world" does not exist.)

    assert_raise ArgumentError, msg, fn ->
      FontAwesome.icon("regular", "world")
    end
  end
end
