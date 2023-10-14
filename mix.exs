defmodule Elmex.MixProject do
  use Mix.Project

  def project do
    [
      app: :elmex,
      version: "0.12.0",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package(),
      description:
        "ElmEx allows you to automatically compile elm code with mix, both in `mix compile` and with `recompile` in `iex -S mix`.",
      name: "ElmEx",
      source_url: "https://github.com/drathier/elmex",
      homepage_url: "https://github.com/drathier/elmex",
      docs: [
        # The main page in the docs
        main: "Elmex",
        extras: ["README.md"]
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, "~> 0.24", only: :dev}
    ]
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README*", "LICENSE*"],
      maintainers: ["drathier"],
      licenses: ["Apache-2.0"],
      links: %{"GitHub" => "https://github.com/drathier/elmex"}
    ]
  end
end
