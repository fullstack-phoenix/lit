defmodule Mix.Tasks.Lit.InstallTest do
  use Lit.MixCase

  describe ".run/1" do
    test_mix_config_errors("lit.install")

    # TODO: add test for umbrella project
  end
end
