defmodule Lit.I18n do
  @moduledoc """
  Provides internationalization support for Lit apps using standard
  Gettext features as a default, but also allows Lit users to customize
  their own "messaging backends" for custom i18n support.
  """

  def message(text_key), do: Lit.Config.i18n_backend().message(text_key)
end
