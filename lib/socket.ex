defmodule Fura.Socket do
  @callback open(host :: integer) ::
  {:ok, socket :: term()} | {:error, term()}

  @callback close(socket :: term()) ::
  :ok | {:error, term()}

  def open(host), do: impl().open(host)
  def close(socket), do: impl().close(socket)
  defp impl do
    Application.get_env(:fura, :socket, RealImpl)
  end
end

defmodule Fura.Socket.RealImpl do
  @behaviour Fura.Socket

  @impl true
  def open(host), do: :socket.open(host)

  @impl true
  def close(socket), do: :socket.close(socket)
end
