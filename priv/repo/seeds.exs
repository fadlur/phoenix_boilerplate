# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     PhoenixBoilerplate.Repo.insert!(%PhoenixBoilerplate.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias PhoenixBoilerplate.Accounts
list_role = ["superadmin", "admin", "member"]

list_role
|> Enum.filter(fn item -> is_nil(Accounts.fetch_role_by_name(item)) end)
|> Enum.each(fn item ->
  IO.inspect(item)

  case(Accounts.create_role(%{"name" => item, "description" => ""})) do
    {:ok, new_role} -> IO.inspect(new_role)
    {:error, _} -> IO.inspect("walah")
  end
end)

list_user = [
  %{
    first_name: "user",
    last_name: "superadmin",
    phone_code: "62",
    phone: "8512341234",
    phone_number: "628512341234",
    email: "superadmin@mail.com",
    password: "12345678",
    role: "superadmin"
  },
  %{
    first_name: "user",
    last_name: "admin",
    phone_code: "62",
    phone: "8512341234",
    phone_number: "628512341234",
    email: "admin@mail.com",
    password: "12345678",
    role: "admin"
  },
  %{
    first_name: "user",
    last_name: "member",
    phone_code: "62",
    phone: "8512341234",
    phone_number: "628512341234",
    email: "member@mail.com",
    password: "12345678",
    role: "member"
  }
]

list_user
|> Enum.filter(fn item -> is_nil(Accounts.get_user_by_email(item.email)) end)
|> Enum.each(fn item ->
  case Accounts.register_user(item) do
    {:ok, new_user} ->
      case Accounts.handle_assign_role(new_user, item.role) do
        {:ok, user_role} -> IO.inspect(user_role)
        {:error, _} -> IO.inspect("assign user role failed")
      end

    {:error, _} ->
      IO.inspect("Input user failed")
  end
end)
