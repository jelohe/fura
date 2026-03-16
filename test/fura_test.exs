defmodule FuraTest do
  use ExUnit.Case
  import Mox

  setup :verify_on_exit!

  # Hay que mirar como funciona socket.open y
  # mockearlo bien antes de ponerse con el codigo.
  expect(Fura.MockSocket, :open, fn port ->
    if (port == 20) do
      true
    else
      false
    end
  end)


  test "reports an open port" do
    assert Fura.probe(20) == true
  end

  test "reports a closed port" do
    assert Fura.probe(80) == false
  end
end
