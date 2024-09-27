defmodule PhoenixBoilerplateWeb.UserLoginLive do
  alias PhoenixBoilerplate.Accounts
  alias PhoenixBoilerplate.Accounts.User
  use PhoenixBoilerplateWeb, :live_view

  def mount(_params, _session, socket) do
    email = live_flash(socket.assigns.flash, :email)
    form = to_form(%{"email" => email}, as: "user")
    {:ok, assign(socket, form: form), temporary_assigns: [form: form]}
  end

  def handle_event("validate", %{"user" => user_params}, socket) do
    changeset =
      Accounts.change_user_registration(%User{}, user_params)
      |> Map.put(:action, :validate)

    {:noreply, socket |> assign_form(changeset)}
  end

  def handle_event("toggle_password", _, socket) do
    socket =
      socket
      |> push_event("show_password", %{})

    {:noreply, socket}
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    form = to_form(changeset, as: "user")

    if changeset.valid? do
      assign(socket, form: form, check_errors: false)
    else
      assign(socket, form: form)
    end
  end
end
