defmodule ElixirBet.Repo.Migrations.AddUserIdToPermissions do
  use Ecto.Migration

  def change do
        alter table(:permissions) do
      add :user_id, references(:users, on_delete: :nothing)
    end
  end
end
