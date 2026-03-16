defmodule TcpTest do
  use ExUnit.Case
  import Mox

  test "native socket is mocked" do
    expect(Fura.MockTcp, :connect, fn (_host, _port, _options, _timeout) ->
      {:ok, :fake_socket}
    end)
    expect(Fura.MockTcp, :close, fn (_socket) ->
      :ok
    end)

    assert {:ok, :fake_socket} =
      Fura.Tcp.connect("example.com", 80, [], 1)

    assert :ok =
      Fura.Tcp.close(:fake_socket)
  end
end
