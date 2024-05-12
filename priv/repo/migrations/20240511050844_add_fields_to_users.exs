defmodule ElixirBet.Repo.Migrations.AddFieldsToUsers do
  use Ecto.Migration

  def change do
      alter table(:users) do
      add :first_name, :string
      add :last_name, :string
      add :msidn, :string
      add :deleted_at, :utc_datetime
      add :role_id, references(:roles, on_delete: :nothing) # Change `:nothing` to the desired behavior on deletion
    end
  end
end
