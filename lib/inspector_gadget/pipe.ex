defmodule InspectorGadget.Pipe do
  @moduledoc """
  Alternative pipe function that emits a stream of logs with the current state
  """

  import Kernel, except: [|>: 2]

  @type ast :: {atom, list, list}

  defmacro __using__(_) do
    quote do
      import Kernel, except: [|>: 2]
      import unquote(__MODULE__)
      require Logger
    end
  end

  @moduledoc """
  Alternative pipe function that emits a stream of logs with the current state

  ## Examples

      use InspectorGadget.Pipe

      1
      |> fn x -> x + b end.()
      |> fn y -> y * 100 end.()
      |> inspect
      #=> 13:42:24.250 [info]  1 |> fn(x) = 2
      #=> 13:42:24.250 [info]  2 |> fn(y) = 200
      #=> 13:42:24.250 [info]  200 |> inspect = "200"

      # Note that this prints in the order of evaluation,
      # so nested expressions are expected occur in a different sequence
      # than the code

      1 |> fn(x, y) -> x + y end.(6 |> fn z -> z * 10 end.())
      #=> 13:44:02.649 [info]  6 |> fn(z) = 60
      #=> 13:44:02.649 [info]  1 |> fn(x, y) = 61

  """
  defmacro left |> right do
    fun_tag = normalize_fun_tag(right)

    quote do
      result = Kernel.|>(unquote(left), unquote(right))
      Logger.info(
        "#{inspect unquote(left)} |> #{unquote(fun_tag)} = #{inspect result}"
      )
      result
    end
  end

  @doc "Normalize presentation of functions for printing"
  @spec normalize_fun_tag(ast) :: ast
  def normalize_fun_tag({:&, _, [{:/, _, [{tag, _, _}]}]}), do: tag

  def normalize_fun_tag({{:., _, [{:fn, _, [{:->, _, [args | _]}]}]}, _, _}) do
    arg_tags = Enum.map(args, fn {tag, _, _} -> Atom.to_charlist(tag) end)
    arg_commas = Enum.intersperse(arg_tags, ', ')
    "fn(#{Enum.join(arg_commas)})"
  end

  def normalize_fun_tag({tag, _ctx, _body}), do: tag
end
