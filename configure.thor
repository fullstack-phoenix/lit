require 'active_support'
require 'active_support/all'

class Configure < Thor
  include Thor::Actions

  # find . -name "*torch*"
  # find . -type f
  desc "build", "Install Phx Auth"
  def build(arg)
    # files_to_replace_in.each do |file_name|
    #   gsub_file file_name, "Torch", "Lit"
    #   gsub_file file_name, "torch", "lit"
    # end

    files_to_rename.each do |file_name|
      next if File.directory?(file_name)

      run "mv #{file_name} #{file_name.gsub('torch', 'lit')}"
    end
  end

  private

  def files_to_rename
    %w(
      ./test/torch
      ./test/torch/torch_test.exs
      ./test/mix/tasks/torch.uninstall_test.exs
      ./test/mix/tasks/torch.install_test.exs
      ./test/mix/tasks/torch.gen.html_test.exs
      ./priv/static/torch.js.map
      ./priv/static/torch-logo.png
      ./priv/static/torch.js
      ./lib/torch
      ./lib/mix/tasks/torch.install.ex
      ./lib/mix/tasks/torch.gen.html.ex
      ./lib/mix/tasks/torch.uninstall.ex
      ./lib/mix/torch.ex
      ./lib/torch.ex
      ./assets/js/torch.js
      ./assets/static/images/torch-logo.png
    )
  end

  def files_to_replace_in
    %w(
      ./.credo.exs
      ./mix.exs
      ./test/torch/torch_test.exs
      ./test/torch/views/filter_view_test.exs
      ./test/torch/views/flash_view_test.exs
      ./test/torch/views/table_view_test.exs
      ./test/torch/views/page_view_test.exs
      ./test/torch/views/pagination_view_test.exs
      ./test/torch/i18n_test.exs
      ./test/mix/tasks/torch.uninstall_test.exs
      ./test/mix/tasks/torch.install_test.exs
      ./test/mix/tasks/torch.gen.html_test.exs
      ./test/support/cases/mix_case.ex
      ./test/support/apps/phx1_5/mix.exs
      ./test/support/apps/phx1_5/bin/test
      ./test/support/apps/phx1_5/config/config.exs
      ./test/support/apps/phx1_4/mix.exs
      ./test/support/apps/phx1_4/bin/test
      ./test/support/apps/phx1_4/config/config.exs
      ./test/support/apps/phx1_3/mix.exs
      ./test/support/apps/phx1_3/bin/test
      ./test/support/apps/phx1_3/config/config.exs
      ./bin/test
      ./bin/release
      ./CHANGELOG.md
      ./config/config.exs
      ./README.md
      ./priv/gettext/default.pot
      ./priv/gettext/ru/LC_MESSAGES/default.po
      ./priv/gettext/de/LC_MESSAGES/default.po
      ./priv/gettext/es/LC_MESSAGES/default.po
      ./priv/gettext/en/LC_MESSAGES/default.po
      ./priv/static/theme.css
      ./priv/static/torch.js.map
      ./priv/static/torch.js
      ./priv/static/base.css
      ./priv/templates/slime/phx.gen.html/edit.html.slime
      ./priv/templates/slime/phx.gen.html/index.html.slime
      ./priv/templates/slime/phx.gen.html/form.html.slime
      ./priv/templates/slime/phx.gen.html/new.html.slime
      ./priv/templates/slime/phx.gen.html/show.html.slime
      ./priv/templates/slime/layout.phx1_5.html.slime
      ./priv/templates/slime/layout.html.slime
      ./priv/templates/eex/phx.gen.html/show.html.eex
      ./priv/templates/eex/phx.gen.html/form.html.eex
      ./priv/templates/eex/phx.gen.html/edit.html.eex
      ./priv/templates/eex/phx.gen.html/new.html.eex
      ./priv/templates/eex/phx.gen.html/index.html.eex
      ./priv/templates/eex/layout.phx1_5.html.eex
      ./priv/templates/eex/layout.html.eex
      ./priv/templates/common/phx.gen.html/controller.ex
      ./priv/templates/common/phx.gen.html/view.ex
      ./priv/templates/phx.gen.context/schema_access.ex
      ./priv/templates/phx.gen.context/access_no_schema.ex
      ./.gitignore
      ./.github/workflows/ci.yml
      ./lib/torch/config.ex
      ./lib/torch/helpers.ex
      ./lib/torch/templates/pagination/_pagination.html.eex
      ./lib/torch/templates/flash/_flash_messages.html.eex
      ./lib/torch/i18n/backend.ex
      ./lib/torch/views/page_view.ex
      ./lib/torch/views/flash_view.ex
      ./lib/torch/views/table_view.ex
      ./lib/torch/views/filter_view.ex
      ./lib/torch/views/pagination_view.ex
      ./lib/torch/i18n.ex
      ./lib/mix/tasks/torch.install.ex
      ./lib/mix/tasks/torch.gen.html.ex
      ./lib/mix/tasks/torch.uninstall.ex
      ./lib/mix/torch.ex
      ./lib/gettext.ex
      ./lib/torch.ex
      ./assets/css/theme/globals/_global.sass
      ./assets/css/theme/components/_panel.sass
      ./assets/css/theme/components/_pagination.sass
      ./assets/css/theme/components/_nav.sass
      ./assets/css/theme/components/_flash-messages.sass
      ./assets/css/theme/components/_form.sass
      ./assets/css/theme/components/_toolbar.sass
      ./assets/css/theme/components/_account-info.sass
      ./assets/css/theme/components/_filters.sass
      ./assets/css/theme/components/_header-and-content.sass
      ./assets/css/theme/components/_datepicker.sass
      ./assets/css/theme/components/_table.sass
      ./assets/css/theme/pages/_new.sass
      ./assets/css/theme/pages/_show.sass
      ./assets/css/theme/pages/_index.sass
      ./assets/css/theme/pages/_edit.sass
      ./assets/css/theme/_extends/_select-input.sass
      ./assets/css/base/globals/_global.sass
      ./assets/js/torch.js
      ./assets/webpack.config.js
    )
  end
end
