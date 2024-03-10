defmodule PhoenixBoilerplateWeb.UserAuthJSON do
  alias PhoenixBoilerplate.Repo
  defp data_user_logged_in(user, token) do
    %{
      token: token,
      user: %{
        first_name: user.first_name,
        last_name: user.last_name,
        email: user.email,
        role: %{
          name: user.role.name,
          description: user.role.description
        }
      }
    }
  end

  # def success(%{token: token}) do
  def success(%{token: token, user: user}) do
    %{status: true, message: "ok", data: data_user_logged_in(user, token), errors: nil}
  end

  def failed(%{user: _user, message: message}) do
    %{status: false, message: message, data: nil, errors: nil}
  end

  def profile(%{user: user}) do
    user = Repo.preload(user, [:role])
    %{
      status: true,
      message: "ok",
      data:
      %{
        user: %{
          first_name: user.first_name,
          last_name: user.last_name,
          email: user.email,
          role: %{
            name: user.role.name,
            description: user.role.description
          }
        }
      },

      errors: nil
    }
  end
end
