defmodule ElixirBet.Repo.Migrations.CreatePermissions do
  use Ecto.Migration

  def change do
    create table(:permissions) do
      add :user_id, references(:users, on_delete: :nothing)
      add :role_id, references(:roles, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end


    create index(:permissions, [:user_id])
    create index(:permissions, [:role_id])
  end
end
