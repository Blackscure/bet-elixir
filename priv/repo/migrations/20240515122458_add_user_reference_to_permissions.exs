defmodule ElixirBet.Repo.Migrations.AddUserReferenceToPermissions do
  use Ecto.Migration

  def change do
    alter table(:permissions) do
    add :user_id, references(:users, on_delete: :nothing) 
    modify :role_id, references(:roles, on_delete: :set_null)
  end
  end
end
