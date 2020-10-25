defmodule Mix.Tasks.Lit.Gen.Live do
  @moduledoc """
  Light wrapper module around `mix phx.gen.live` which generates slightly
  modified HTML.

  Takes all the same params as the `phx.gen.live` task.

  ## Example

      mix lit.gen.live Accounts User users --no-schema
  """

  @commands ~w[phx.gen.live phx.gen.context]

  def run(args) do
    if Mix.Project.umbrella?() do
      Mix.raise("mix lit.gen.live can only be run inside an application directory")
    end

    IO.inspect(args) # ["Posts", "Post", "posts", "--web", "Admin", "title"]

    %{format: format} = Mix.Lit.parse_config!("lit.gen.live", args)

    Mix.Lit.ensure_phoenix_is_loaded!("lit.gen.live")

    # First, backup the projects existing templates if they exist
    Enum.each(@commands, &Mix.Lit.backup_project_templates/1)

    # Inject the lit templates for the generator into the priv/
    # directory so they will be picked up by the Phoenix generator
    Enum.each(@commands, &Mix.Lit.inject_templates(&1, format))

    # Run the Phoenix generator
    Mix.Task.run("phx.gen.live", args)

    # Remove the injected templates from priv/ so they will not
    # affect future Phoenix generator commands
    Enum.each(@commands, &Mix.Lit.remove_templates/1)

    # Restore the projects existing templates if present
    Enum.each(@commands, &Mix.Lit.restore_project_templates/1)

    # Mix.shell().info("""
    # Ensure the following is added to your endpoint.ex:
    #
    #     plug(
    #       Plug.Static,
    #       at: "/lit",
    #       from: {:lit, "priv/static"},
    #       gzip: true,
    #       cache_control_for_etags: "public, max-age=86400",
    #       headers: [{"access-control-allow-origin", "*"}]
    #     )
    # """)

    Mix.shell().info("""
    Also don't forget to add a link to layouts/lit.html.

        <nav class="lit-nav">
          <!-- nav links here -->
        </nav>
    """)
  end
end
