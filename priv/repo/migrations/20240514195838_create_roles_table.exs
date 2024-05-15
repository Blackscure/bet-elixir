defmodule ElixirBet.Repo.Migrations.CreateRolesTable do
  use Ecto.Migration

  def change do
    create table(:roles) do
      add :name, :string
      add :description, :string
      timestamps()
    end

    create index(:roles, [:name], unique: true)

    create table(:users_roles, primary_key: false) do
      add :user_id, references(:users, on_delete: :nothing)
      add :role_id, references(:roles, on_delete: :nothing)
    end

    create index(:users_roles, [:user_id])
    create index(:users_roles, [:role_id])
  end
end
