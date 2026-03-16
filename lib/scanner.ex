defmodule Fura.Scanner do
  @port_timeout 1000
  @concurrency 300
  @task_timeout :infinity

  def probe(host, port) when is_integer(port) do
    case Fura.Tcp.connect(host, port, [], @port_timeout) do
      {:ok, socket} -> 
        Fura.Tcp.close(socket)
        {port, :open}
      {:error, _} -> {port, :closed}
    end
  end

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
