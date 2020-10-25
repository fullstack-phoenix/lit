defmodule Lit.FlashViewTest do
  use ExUnit.Case

  import Phoenix.HTML, only: [safe_to_string: 1]

  doctest Lit.FlashView, import: true
end
