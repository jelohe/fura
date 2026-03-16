defmodule Fura do
  def scan(host, range) when is_binary(host), do: scan(to_charlist(host), range)
  def scan(host, range) do
    Fura.Scanner.scan_range(host, range) |> to_human
  end

  defp to_human(opened_ports) do
    opened_ports
    |> Enum.each(fn {port, _} -> IO.puts("#{port} tcp/open") end)
  end
end
