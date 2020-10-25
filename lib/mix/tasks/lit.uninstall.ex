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

    %{format: format, otp_app: otp_app} = Mix.Lit.parse_config!("lit.uninstall", args)

    paths = [
      "lib/#{otp_app}_web/templates/layout/lit.html.#{format}"
    ]

    Enum.each(paths, &File.rm/1)
  end
end
