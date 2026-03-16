ExUnit.start()

Path.join(__DIR__, "support/**/*.exs")
|> Path.wildcard()
|> Enum.each(&Code.require_file/1)

Mox.defmock(Fura.MockTcp, for: Fura.Tcp)
Application.put_env(:fura, :tcp, Fura.MockTcp)
