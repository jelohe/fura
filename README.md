# Fura - Port Scanner

Fura is a CLI tool that discovers which ports are open on a given host.

*Use this tool only on owned or authorized networks.*


## Prerequisites

[Elixir](https://elixir-lang.org/install.html).


## Usage

Fura is launched from the REPL:

`iex -S mix`

To scan call `Fura.scan(host, port_range)`

```
> Fura.scan("scanme.nmap.org", 1..100)
22 tcp/open
80 tcp/open
```


## Help, it doesn't work on my system

Ensure you have [elixir](https://elixir-lang.org/install.html) installed and fetch the dependencies with `mix deps.get`.
