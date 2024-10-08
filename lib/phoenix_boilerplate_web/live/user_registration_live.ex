defmodule PhoenixBoilerplateWeb.UserRegistrationLive do
  use PhoenixBoilerplateWeb, :live_view

  alias PhoenixBoilerplate.Accounts
  alias PhoenixBoilerplate.Accounts.User

  def mount(_params, _session, socket) do
    changeset = Accounts.change_user_registration(%User{})

    socket =
      socket
      |> assign(trigger_submit: false, check_errors: false)
      |> assign_form(changeset)

    {:ok, socket, temporary_assigns: [form: nil]}
  end

  @spec handle_event(<<_::32, _::_*32>>, map(), any()) :: {:noreply, any()}
  def handle_event("save", %{"user" => user_params}, socket) do
    case Accounts.register_user(user_params) do
      {:ok, user} ->
        {:ok, _} =
          Accounts.deliver_user_confirmation_instructions(
            user,
            &url(~p"/users/confirm/#{&1}")
          )

        if Accounts.get_role_by_name("member") do
          Accounts.handle_assign_role(user, "member")
        else
          case Accounts.create_role(%{name: "member"}) do
            {:ok, _} -> Accounts.handle_assign_role(user, "member")
          end
        end

        changeset = Accounts.change_user_registration(user)
        {:noreply, socket |> assign(trigger_submit: true) |> assign_form(changeset)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, socket |> assign(check_errors: true) |> assign_form(changeset)}
    end
  end

  def handle_event("validate", %{"user" => user_params}, socket) do
    changeset = Accounts.change_user_registration(%User{}, user_params)
    {:noreply, assign_form(socket, Map.put(changeset, :action, :validate))}
  end

  def handle_event("toggle_password", _, socket) do
    socket =
      socket
      |> push_event("show_password", %{})

    {:noreply, socket}
  end

  def handle_event("toggle_password_confirmation", _, socket) do
    socket =
      socket
      |> push_event("show_password_confirmation", %{})

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
