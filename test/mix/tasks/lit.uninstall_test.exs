defmodule Mix.Tasks.Lit.UninstallTest do
  use Lit.MixCase

  describe ".run/1" do
    test_mix_config_errors("lit.uninstall")

    # TODO: add test for umbrella project
  end
end
