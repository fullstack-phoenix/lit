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

    # IO.inspect(args) # ["Posts", "Post", "posts", "--web", "Admin", "title"]

    %{default_web_namespace: _default_web_namespace} = Mix.Lit.parse_config!("lit.gen.live", args)

    Mix.Lit.ensure_phoenix_is_loaded!("lit.gen.live")

    # First, backup the projects existing templates if they exist
    Enum.each(@commands, &Mix.Lit.backup_project_templates/1)

    # Inject the lit templates for the generator into the priv/
    # directory so they will be picked up by the Phoenix generator
    Enum.each(@commands, &Mix.Lit.inject_templates(&1, "eex"))

    # Run the Phoenix generator
    Mix.Task.run("phx.gen.live", args)

    # Remove the injected templates from priv/ so they will not
    # affect future Phoenix generator commands
    Enum.each(@commands, &Mix.Lit.remove_templates/1)

    # Restore the projects existing templates if present
    Enum.each(@commands, &Mix.Lit.restore_project_templates/1)

    {context, schema} = Mix.Tasks.Phx.Gen.Context.build(args)

    Mix.shell().info("""
    Ensure the following is added to your router.ex:

        pipeline :admin_layout do
          plug :put_root_layout, {#{context.web_module}.#{schema.web_namespace}.LayoutView, :lit}
        end
    """)

    Mix.shell().info("""
    Also don't forget to add a link to layouts/lit.html.

        <nav id="nav-links">
          <!-- ADD NAVIGATION LINKS HERE -->
          <a class="py-1 my-1 text-sm font-medium text-gray-700 md:py-0 hover:text-blue-400 focus:outline-none md:mx-3 md:my-0" href="#">Home</a>
        </nav>
    """)
  end
end
