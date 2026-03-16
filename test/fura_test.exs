defmodule FuraTest do
  use ExUnit.Case
  import Mox

  setup :verify_on_exit!

  defp prepare_mock() do
    stub(Fura.MockTcp, :connect, fn (_host, port, _options, _timeout) ->
      if port == 20 do
        {:ok, :fake_socket}
      else
        {:error, :closed}
      end
    end)
  end

  test "reports an open port" do
    prepare_mock()
    assert Fura.probe("www.example.com", 20) == {20, :open}
  end

  test "reports a closed port" do
    prepare_mock()
    assert Fura.probe("www.example.com", 80) == {80, :closed}
  end

  test "reports a range of ports" do
    prepare_mock()
    expected_scan = [{20, :open}]
    assert Fura.scan("www.example.com", 1..100) == expected_scan
  end
end
