defmodule PhoenixBoilerplate.Repo.Migrations.CreateUsersAuthTables do
  use Ecto.Migration

  def change do
    execute "CREATE EXTENSION IF NOT EXISTS citext", ""

    create table(:users) do
      add :first_name, :string, null: false
      add :last_name, :string, null: true
      add :email, :citext, null: false
      add :phone_code, :string, null: true
      add :phone, :string, null: true
      add :phone_number, :string, null: true
      add :hashed_password, :string, null: false
      add :confirmed_at, :naive_datetime
      add :deleted_at, :utc_datetime
      timestamps(inserted_at: :created_at)
    end

    create unique_index(:users, [:email])

    create table(:users_tokens) do
      add :user_id, references(:users, on_delete: :delete_all), null: false
      add :token, :binary, null: false
      add :context, :string, null: false
      add :sent_to, :string
      timestamps(updated_at: false)
    end

    create index(:users_tokens, [:user_id])
    create unique_index(:users_tokens, [:context, :token])
  end
end
