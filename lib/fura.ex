defmodule Fura do
  def scan(host, range \\ nil) do
    host
    |> normalize_host
    |> Fura.Scanner.scan_range(range)
    |> to_human
  end

  def normalize_host(host) when is_binary(host),
    do: to_charlist(host)
  def normalize_host(host),
    do: host

  defp to_human(opened_ports) do
    opened_ports
    |> Enum.each(fn {port, _} -> IO.puts("#{port} tcp/open") end)
  end
end
