defmodule Fura.Scanner do
  @port_timeout 200
  @concurrency 300
  @task_timeout :infinity
  @full_range 1..65535

  def probe(host, port) when is_integer(port) do
    case Fura.Tcp.connect(host, port, [], @port_timeout) do
      {:ok, socket} -> 
        Fura.Tcp.close(socket)
        {port, :open}
      {:error, _} -> {port, :closed}
    end
  end

  def scan_range(host), do: scan_range(host, @full_range)
  def scan_range(host, range) when range == nil, do: scan_range(host)

  def scan_range(host, range) do
    range
    |> Task.async_stream(
      fn port -> probe(host, port) end,
      max_concurrency: @concurrency,
      timeout: @task_timeout
    )
    |> Enum.map(fn {:ok, result} -> result end)
    |> Enum.filter(fn {_port, result} -> result == :open end)
  end
end
