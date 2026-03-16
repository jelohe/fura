defmodule Fura.Test.Stub do
  import Mox

  def setup() do
    stub(Fura.MockTcp, :connect, fn (_host, port, _options, _timeout) ->
        if (port == 20 or port == 80) do
          {:ok, :fake_socket}
        else
          {:error, :closed}
        end
      end)

    stub(Fura.MockTcp, :close, fn (_socket) -> :ok end)
  end
end
