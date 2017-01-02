defmodule InspectorGadget.Pipe do
  import Kernel, except: [|>: 2]

  defmacro __using__(_) do
    quote do
      import Kernel, except: [|>: 2]
      import unquote(__MODULE__)
      require Logger
    end
  end

  defmacro left |> right do
    function_tag =
      case right do
        {:&, _, [{:/, _, [{tag, _, _}]}]} -> tag

        {{:., _, [{:fn, _, [{:->, _, [args | _]}]}]}, _, _} ->
          arg_tags = Enum.map(args, fn {tag, _, _} -> Atom.to_charlist(tag) end)
          arg_commas = Enum.intersperse(arg_tags, ', ')
          "fn(#{Enum.join(arg_commas)})"

        {tag, _ctx, _body} -> tag
      end

    quote do
      result = Kernel.|>(unquote(left), unquote(right))
      Logger.info("#{inspect unquote(left)} |> #{unquote(function_tag)} = #{inspect result}")
      result
    end
  end
end
