defmodule PhoenixBoilerplateWeb.UserAuthController do
  require Logger
  alias PhoenixBoilerplate.Repo
  alias PhoenixBoilerplate.Accounts
  use PhoenixBoilerplateWeb, :controller

  def create(conn, params) do
    %{"email" => email, "password" => password} = params

    # render(conn, :success, user: %User{email: params["email"]})
    if user = Accounts.get_user_by_email_and_password(email, password) do
      token = Accounts.create_user_api_token(user)
      user = Repo.preload(user, [:role])

      conn
      |> put_status(:ok)
      |> render(:success, token: token, user: user)
    else
      # In order to prevent user enumeration attacks, don't disclose whether the email is registered.
      conn
      |> put_status(:unauthorized)
      |> render(:failed, user: nil, message: "Check your email or password")
    end
  end

  def profile(conn, _params) do
    conn
    |> put_status(:ok)
    |> render(:profile, user: conn.assigns.current_user)
  end
end
