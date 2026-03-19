defmodule FuraTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  test "provides a human readable report" do
    Fura.Test.Stub.setup()
    expected_report = """
    20 tcp/open
    80 tcp/open
    """

    assert capture_io(fn ->
      Fura.scan("www.example.com", 1..100)
    end) == expected_report
  end

  test "scans all ports when no range is provided" do
    Fura.Test.Stub.setup()
    expected_report = """
    20 tcp/open
    80 tcp/open
    65535 tcp/open
    """

    assert capture_io(fn ->
      Fura.scan("www.example.com")
    end) == expected_report
  end
end
