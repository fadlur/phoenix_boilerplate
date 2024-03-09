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
for item <- ["superadmin", "admin", "member"] do
  alias PhoenixBoilerplate.Accounts
  Accounts.create_role(%{name: item})
end
