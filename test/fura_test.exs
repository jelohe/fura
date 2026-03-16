defmodule FuraTest do
  use ExUnit.Case
  import Mox
  import ExUnit.CaptureIO

  setup :verify_on_exit!

  defp prepare_mock() do
    stub(Fura.MockTcp, :connect, fn (_host, port, _options, _timeout) ->
      if (port == 20 or port == 80) do
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
    assert Fura.probe("www.example.com", 33) == {33, :closed}
  end

  test "scans a range of ports" do
    prepare_mock()
    expected_scan = [{20, :open},{80, :open}]
    assert Fura.scan_range("www.example.com", 1..100) == expected_scan
  end

  test "provides a human readable report" do
    prepare_mock()
    expected_report = """
    20 tcp/open
    80 tcp/open
    """

    assert capture_io(fn ->
      Fura.scan("www.example.com", 1..100)
    end) == expected_report
  end
end
