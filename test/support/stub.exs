defmodule Fura.Test.Stub do
  import Mox

  def setup() do
    stub(Fura.MockTcp, :connect, fn (_host, port, _options, _timeout) ->
        if (port == 20 or port == 80 or port == 65535) do
          {:ok, :fake_socket}
        else
          {:error, :econnrefused}
        end
      end)

    stub(Fura.MockTcp, :close, fn (_socket) -> :ok end)
  end
end
