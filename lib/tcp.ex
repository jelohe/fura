defmodule Fura.Tcp do
  @callback connect(
    host :: :inet.socket_address() | charlist(),
    port :: :inet.port_number(),
    options :: list(),
    timeout :: timeout()
  ) :: {:ok, socket :: term()} | {:error, term()}

  def connect(host, port, options, timeout) do
    impl().connect(host, port, options, timeout)
  end
  defp impl do
    Application.get_env(:fura, :tcp, Fura.Tcp.RealImpl)
  end
end

defmodule Fura.Tcp.RealImpl do
  @behaviour Fura.Tcp

  @impl true
  def connect(host, port, options, timeout) do
    :gen_tcp.connect(host, port, options, timeout)
  end
end
