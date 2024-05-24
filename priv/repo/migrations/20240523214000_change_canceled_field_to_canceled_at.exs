defmodule YourApp.Repo.Migrations.ChangeCanceledFieldToCanceledAt do
  use Ecto.Migration

  def change do
    alter table(:bets) do
      remove :canceled
      add :canceled_at, :utc_datetime
    end
  end
end
