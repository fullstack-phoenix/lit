defmodule Mix.Tasks.Lit.Install do
  @moduledoc """
  Installs lit layout to your `_web/templates` directory.

  ## Configuration

      config :lit,
        otp_app: :my_app,
        template_format: :eex

  ## Example

  Running without options will read configuration from your `config.exs` file,
  as shown above.

     mix lit.install

  Also accepts `--app` options:

      mix lit.install --app my_app
  """

  def run(args) do
    if Mix.Project.umbrella?() do
      Mix.raise("mix lit.install can only be run inside an application directory")
    end

    %{format: format, otp_app: otp_app} = Mix.Lit.parse_config!("lit.install", args)

    Mix.Lit.ensure_phoenix_is_loaded!("lit.install")

    phoenix_version = Application.spec(:phoenix, :vsn)

    Mix.Lit.copy_from("priv/templates/#{format}", [
      {template_file(phoenix_version, format),
       "lib/#{otp_app}_web/templates/admin/layout/lit.html.leex"}
    ])

    copy_additional_files()
  end

  defp template_file(phoenix_version, format) when is_list(phoenix_version),
    do: phoenix_version |> to_string() |> template_file(format)

  defp template_file(phoenix_version, format) when is_binary(phoenix_version) do
    if Version.match?(phoenix_version, ">= 1.5.0") do
      "layout.phx1_5.html.#{format}"
    else
      "layout.html.#{format}"
    end
  end

  defp copy_additional_files do
    # BELOW IS TEMPORAY AND A POC. WILL SOON BE REWRITTEN
    {context, schema} = Mix.Tasks.Phx.Gen.Context.build(["Products", "Product", "products", "--web", "admin"])
    binding = [context: context, schema: schema]
    web_prefix = Mix.Phoenix.web_path(context.context_app)

    files = [
      {:eex, "pagination_component.ex", Path.join([web_prefix, "live", "admin", "common", "pagination_component.ex"])},
    ]

    Mix.Phoenix.copy_from([:lit], "priv/templates/lit.install", binding, files)
  end
end
