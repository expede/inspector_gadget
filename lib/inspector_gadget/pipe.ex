defmodule InspectorGadget.Pipe do
  import InspectorGadget
  import Kernel, except: [|>: 2]

  defmacro __using__(_) do
    quote do
      import Kernel, except: [|>: 2]
      import unquote(__MODULE__)
    end
  end

  def a |> b, do: a Kernel.|> inspect_flow Kernel.|> b
end
