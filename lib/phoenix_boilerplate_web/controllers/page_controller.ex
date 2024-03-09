defmodule PhoenixBoilerplateWeb.PageController do
  use PhoenixBoilerplateWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home, layout: {PhoenixBoilerplateWeb.Layouts, :app})
  end
end
