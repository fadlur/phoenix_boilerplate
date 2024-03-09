defmodule PhoenixBoilerplate.Repo.Migrations.CreateRoles do
  use Ecto.Migration

  def change do
    create table(:roles) do
      add :name, :string
      add :description, :text, null: true

      timestamps(inserted_at: :created_at)
    end

    create index(:roles, [:name])
  end
end
