defmodule PhoenixBoilerplateWeb.MemberLive do
  use PhoenixBoilerplateWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket, layout: {PhoenixBoilerplateWeb.Layouts, :dashboard}}
  end

  def render(assigns) do
    ~H"""
    dashboard
    """
  end
end
