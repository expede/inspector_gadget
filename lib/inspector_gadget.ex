defmodule InspectorGadget do
  require Logger

  def inspect_flow(state) do
    Logger.info("inspect_flow: " <> inspect(state))
    state
  end
end
