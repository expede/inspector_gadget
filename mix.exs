defmodule InspectorGadget.Mixfile do
  use Mix.Project

  def project do
    [
      app: :inspector_gadget,
      name: "InspectorGadget",
      description: "Helpers for debugging & inspecting code flow",

      version: "0.2.0",
      elixir: "~> 1.3",

      package: [
        maintainers: ["Brooklyn Zelenka"],
        licenses:    ["MIT"],
        links:       %{"GitHub":  "https://github.com/expede/inspector_gadget"}
      ],

      source_url:   "https://github.com/expede/inspector_gadget",
      homepage_url: "https://github.com/expede/inspector_gadget",

      aliases: ["quality": ["test", "espec", "credo --strict", "inch"]],

      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,

      deps: [
        {:credo,    "~> 0.4",  only: [:dev, :test]},

        {:dialyxir, "~> 0.3",  only: :dev},
        {:earmark,  "~> 1.0",  only: :dev},
        {:ex_doc,   "~> 0.13", only: :dev},

        {:inch_ex, "~> 0.5",  only: [:dev, :docs, :test]}
      ],

      docs: [
        extras: ["README.md"],
        logo: "./brand/logo.png",
        main: "readme"
      ]
    ]
  end

  def application, do: [applications: [:logger]]
end
