defmodule InspectorGadget do
  @moduledoc ~S"""
  Helpers for debugging & inspecting code flow
  """

  require Logger

  @doc ~S"""
  Print the current state and return that value back into flow

  ## Examples

      iex> 1
      ...> |> fn x -> x + b end.()
      ...> |> fn y -> y * 100 end.()
      ...> |> inspect
      "200"
      #=> 13:42:24.250 [info]  1 |> fn(x) = 2
      #=> 13:42:24.250 [info]  2 |> fn(y) = 200
      #=> 13:42:24.250 [info]  200 |> inspect = "200"

  """
  @spec inspect_flow(any) :: any
  def inspect_flow(state) do
    Logger.info("inspect_flow: " <> inspect(state))
    state
  end
end
