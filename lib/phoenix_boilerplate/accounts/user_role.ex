defmodule PhoenixBoilerplate.Accounts.UserRole do
  alias PhoenixBoilerplate.Accounts
  use Ecto.Schema
  import Ecto.Changeset

  schema "user_roles" do
    belongs_to :user, Accounts.User
    belongs_to :role, Accounts.Role

    timestamps(inserted_at: :created_at)
  end

  @doc false
  def changeset(user_role, attrs) do
    user_role
    |> cast(attrs, [:user_id, :role_id])
    |> validate_required([:user_id, :role_id])
  end
end
