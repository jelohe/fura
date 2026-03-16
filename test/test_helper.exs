ExUnit.start()

Mox.defmock(Fura.MockTcp, for: Fura.Tcp)
Application.put_env(:fura, :tcp, Fura.MockTcp)

