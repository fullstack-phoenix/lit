defmodule Mix.Tasks.Lit.Uninstall do
  @moduledoc """
  Uninstalls lit layout.

  ## Example

      mix lit.uninstall
  """

  def run(args) do
    if Mix.Project.umbrella?() do
      Mix.raise("mix lit.uninstall can only be run inside an application directory")
    end

    %{default_web_namespace: default_web_namespace, otp_app: otp_app} = Mix.Lit.parse_config!("lit.uninstall", args)

    paths = [
      "lib/#{otp_app}_web/templates/#{default_web_namespace}/layout/lit.html.leex"
    ]

    Enum.each(paths, &File.rm/1)
  end
end
