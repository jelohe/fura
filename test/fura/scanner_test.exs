defmodule ScannerTest do
  use ExUnit.Case
  import Mox

  setup :verify_on_exit!

  test "reports an open port" do
    Fura.Test.Stub.setup()
    assert Fura.Scanner.probe("www.example.com", 20) == {20, :open}
  end

  test "reports a closed port" do
    Fura.Test.Stub.setup()
    assert Fura.Scanner.probe("www.example.com", 33) == {33, :closed}
  end

  test "scans a range of ports" do
    Fura.Test.Stub.setup()
    expected_scan = [{20, :open},{80, :open}]
    assert Fura.Scanner.scan_range("www.example.com", 1..100) == expected_scan
  end

  test "closes the connection for open ports" do
    Fura.Test.Stub.setup()
    expected_closed_conn = 2
    expect(Fura.MockTcp, :close, expected_closed_conn, fn (_socket) -> :ok end)
    Fura.Scanner.scan_range("www.example.com", 1..100)
  end
end
