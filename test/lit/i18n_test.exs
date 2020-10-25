defmodule Lit.I18nTest do
  use ExUnit.Case

  defmodule CustomI18nBackend do
    def message("Contains"), do: "** CUSTOMIZED **"
    def message(t), do: Lit.I18n.Backend.message(t)
  end

  setup_all do
    on_exit(fn ->
      Application.put_env(:lit, :i18n_backend, Lit.I18n.Backend)
    end)

    [i18n_backend: Lit.Config.i18n_backend()]
  end

  test "uses a default backend if none configured", context do
    Application.put_env(:lit, :i18n_backend, context[:i18n_backend])

    assert Lit.I18n.Backend == Lit.Config.i18n_backend()
    assert "Contains" == Lit.I18n.message("Contains")
  end

  test "allows a custom backend to be defined" do
    Application.put_env(:lit, :i18n_backend, CustomI18nBackend)

    assert CustomI18nBackend == Lit.Config.i18n_backend()
    assert "** CUSTOMIZED **" == Lit.I18n.message("Contains")
    assert "Equals" == Lit.I18n.message("Equals")
  end
end
