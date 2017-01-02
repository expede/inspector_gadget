defmodule InspectorGadget do
  defmacro __using__(_) do
    quote do
      use InspectorGadget.Pipe
      import unquote(__MODULE__)
    end
  end

  def inspect_flow(state) do
    state |> inspect |> IO.puts
    state
  end
end
