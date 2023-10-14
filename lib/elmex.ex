defmodule Mix.Tasks.Compile.Elmex do
  @moduledoc false

  use Mix.Task.Compiler

  @recursive true

  @shell_prefix "Elm: "

  @impl Mix.Task.Compiler
  def run(_argv) do
    config = Mix.Project.config() |> Keyword.get(:elmex, Keyword.new())

    if System.find_executable("elm") do
      build(config)
    else
      {
        :error,
        [
          %Mix.Task.Compiler.Diagnostic{
            compiler_name: "elmex-mix-compiler",
            details: nil,
            file: "elm",
            message:
              "Couldn't find an `elm` executable on path. Elmex mix compiler task will not work without the proper elm compiler. Please install it on path or remove the :elmex compiler from mix.exs.",
            position: nil,
            severity: :error
          }
        ]
      }
    end
  end

  defp build(config) do
    cmd_str = build_command(config)

    Mix.shell().cmd(cmd_str, stderr_to_stdout: true)
    |> case do
      0 ->
        {:ok, []}

      exit_status ->
        error = %Mix.Task.Compiler.Diagnostic{
          compiler_name: "elmex-mix-compiler",
          details: nil,
          file: "spago",
          message: "non-zero exit code #{exit_status} from `#{cmd_str}`",
          position: nil,
          severity: :error
        }

        Mix.shell().error([:bright, :red, @shell_prefix, error.message, :reset])
        {:error, [error]}
    end
  end

  defp build_command(config) do
    ["elm make" | elm_options(config)]
    |> Enum.join(" ")
    |> String.trim_trailing()
  end

  defp elm_options(config) do
    lazy =
      config
      |> Keyword.get(:elm_options, fn -> ["--output=erlang src/Main.elm"] end)

    lazy.()
    |> List.wrap()
  end
end
