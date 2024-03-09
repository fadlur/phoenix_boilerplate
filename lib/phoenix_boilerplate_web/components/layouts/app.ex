defmodule PhoenixBoilerplateWeb.Layouts.App do
  alias Phoenix.LiveView.JS

  def toggle_menu_dropdown(id) do
    JS.toggle(to: id)
  end

  def toggle_sidebar_menu() do
    JS.toggle(
      to: "#sidebar",
      in: {
        "ease-in-out duration-300",
        "-translate-x-full",
        "translate-x-0"
      },
      out: {
        "ease-in-out duration-300",
        "translate-x-0",
        "-translate-x-full"
      },
      time: 300
    )
  end
end
