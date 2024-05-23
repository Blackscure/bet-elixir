defmodule YourApp.Repo.Migrations.AddCanceledToBets do
  use Ecto.Migration

  def change do
    alter table(:bets) do
      add :canceled, :boolean, default: false
    end
  end
end
