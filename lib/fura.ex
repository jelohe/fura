defmodule Fura do
  @timeout 1000
  @timeout_buffer @timeout + 100

  def probe(host, port) when is_integer(port) do
    if (match?({:ok, _}, Fura.Tcp.connect(host, port, [], @timeout))) do
      {port, :open}
    else
      {port, :closed}
    end
  end

  def scan(host, range) do
    range
    |> Task.async_stream(
      fn port -> probe(host, port) end,
      max_concurrency: 100,
      timeout: @timeout_buffer
    )
    |> Enum.map(fn {:ok, result} -> result end)
    |> Enum.filter(fn {_port, result} -> result == :open end)
  end
end
