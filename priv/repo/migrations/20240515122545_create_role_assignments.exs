defmodule ElixirBet.Repo.Migrations.CreateRoleAssignments do
  use Ecto.Migration

  def change do
    create table(:role_assignments) do
      add :user_id, :integer
      add :role_id, :integer

      timestamps(type: :utc_datetime)
    end
  end
end
