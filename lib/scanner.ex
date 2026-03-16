defmodule Fura.Scanner do
  @timeout 1000
  @timeout_buffer @timeout + 100

  def probe(host, port) when is_integer(port) do
    case Fura.Tcp.connect(host, port, [], @timeout) do
      {:ok, _} -> {port, :open}
      {:error, _} -> {port, :closed}
    end
  end

  def scan_range(host, range) do
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
