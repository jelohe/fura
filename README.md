# Fura - Port Scanner

Fura is a CLI tool that discovers which ports are open on a host.

**WARNING** *Use this tool only on networks where you are athorized.*


## Prerequisites

Install [elixir](https://elixir-lang.org/install.html).


## Usage

Currently, Fura is launched from the REPL:

`iex -S mix`

To scan call `Fura.scan(host, port_range)`

```
> Fura.scan("scanme.nmap.org", 1..100)
22 tcp/open
80 tcp/open
```


## Help, it doesn't work on my system

Ensure you have [elixir](https://elixir-lang.org/install.html) installed and fetch the dependencies with `mix deps.get`.
