defmodule SocketTest do
  use ExUnit.Case
  import Mox

  test "native socket is mocked" do
    expect(Fura.MockSocket, :open, fn _host ->
      {:ok, :fake_socket}
    end)
    expect(Fura.MockSocket, :close, fn _host ->
      {:ok, :fake_socket}
    end)

    assert {:ok, :fake_socket} = Fura.Socket.open("example.com")
    assert {:ok, :fake_socket} = Fura.Socket.close("example.com")
  end
end
