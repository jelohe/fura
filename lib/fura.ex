defmodule Fura do
  @timeout 1000
  @timeout_buffer @timeout + 100

  def scan(host, range) when is_binary(host), do: scan(to_charlist(host), range)
  def scan(host, range) do
    scan_range(host, range) |> to_human
  end

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

  defp to_human(opened_ports) do
    opened_ports
    |> Enum.each(fn {port, _} -> IO.puts("#{port} tcp/open") end)
  end
end
