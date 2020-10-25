defmodule Mix.Tasks.Lit.Gen.HtmlTest do
  use Lit.MixCase, async: false

  describe ".run/1" do
    test_mix_config_errors("lit.gen.html")

    # TODO: Add integration test for umbrella app
  end
end
