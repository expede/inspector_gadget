# InspectorGadget
Helpers for debugging & inspecting code flow

[![Build Status](https://travis-ci.org/expede/inspector_gadget.svg?branch=master)](https://travis-ci.org/expede/inspector_gadget) [![Inline docs](http://inch-ci.org/github/expede/inspector_gadget.svg?branch=master)](http://inch-ci.org/github/expede/inspector_gadget) [![Deps Status](https://beta.hexfaktor.org/badge/all/github/expede/inspector_gadget.svg)](https://beta.hexfaktor.org/github/expede/inspector_gadget) [![hex.pm version](https://img.shields.io/hexpm/v/inspector_gadget.svg?style=flat)](https://hex.pm/packages/inspector_gadget) [![API Docs](https://img.shields.io/badge/api-docs-yellow.svg?style=flat)](http://hexdocs.pm/inspector_gadget/) [![license](https://img.shields.io/github/license/mashape/apistatus.svg?maxAge=2592000)](https://github.com/expede/inspector_gadget/blob/master/LICENSE)

# Quick Start

```elixir

def deps do
  [{:inspector_gadget, "~> 0.2.0"}]
end
```

# Summary

## Inspect Flow

```elixir
import InspectorGadget
1
|> inspect_flow
|> fn x -> x + 1 end.()
|> fn y -> y * 100 end.()
|> inspect_flow
#=> 13:34:21.997 [info]  inspect_flow: 1
#=> 13:34:21.997 [info]  inspect_flow: 200
```

## Overloaded Pipe

```elixir
use InspectorGadget.Pipe

1
|> fn x -> x + b end.()
|> fn y -> y * 100 end.()
|> inspect
#=> 13:42:24.250 [info]  1 |> fn(x) = 2
#=> 13:42:24.250 [info]  2 |> fn(y) = 200
#=> 13:42:24.250 [info]  200 |> inspect = "200"

# Note that this prints in the order of evaluation,
# so nested expressions are expected occur in a different sequence than the code

1 |> fn(x, y) -> x + y end.(6 |> fn z -> z * 10 end.())
#=> 13:44:02.649 [info]  6 |> fn(z) = 60
#=> 13:44:02.649 [info]  1 |> fn(x, y) = 61
```
