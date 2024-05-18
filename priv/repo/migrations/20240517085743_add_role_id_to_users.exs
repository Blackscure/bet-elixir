defmodule ElixirBet.Repo.Migrations.AddRoleIdToUsers do
  use Ecto.Migration

   def up do
    execute("ALTER TABLE users DROP CONSTRAINT IF EXISTS users_role_id_fkey")
    alter table(:users) do
      modify :role_id, references(:roles, on_delete: :nothing)
    end
  end

  def down do
    alter table(:users) do
      modify :role_id, references(:roles, on_delete: :nothing)
    end
  end

end
