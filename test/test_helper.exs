ExUnit.start()

Mox.defmock(Fura.MockSocket, for: Fura.Socket)
Application.put_env(:fura, :socket, Fura.MockSocket)

Mox.defmock(Fura.MockTcp, for: Fura.Tcp)
Application.put_env(:fura, :tcp, Fura.MockTcp)

