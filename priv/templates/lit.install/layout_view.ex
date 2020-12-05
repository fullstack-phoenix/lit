defmodule <%= inspect context.web_module %>.<%= inspect Module.concat(schema.web_namespace, "Layout") %>View do
  use <%= inspect context.web_module %>, :view
end
