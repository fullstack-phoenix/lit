defmodule Lit.Config do
  @moduledoc """
  Application config for lit.
  """

  def otp_app do
    Application.get_env(:lit, :otp_app)
  end

  def template_format do
    Application.get_env(:lit, :template_format)
  end

  def i18n_backend do
    Application.get_env(:lit, :i18n_backend, Lit.I18n.Backend)
  end
end
