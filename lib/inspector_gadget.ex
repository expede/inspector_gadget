defmodule InspectorGadget do
  require Logger

  defmacro __using__(_) do
    quote do
      use InspectorGadget.Pipe
      import unquote(__MODULE__)
      require Logger
    end
  end

  def inspect_flow(state) do
    state |> inspect |> Logger.info
    state
  end
end
