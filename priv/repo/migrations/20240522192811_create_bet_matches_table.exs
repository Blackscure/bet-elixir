defmodule ElixirBet.Repo.Migrations.CreateBetMatchesTable do
  use Ecto.Migration

  def change do
    create table(:bet_matches) do
      add :bet_id, references(:bets, on_delete: :delete_all), null: false
      add :match_id, references(:matches, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:bet_matches, [:bet_id])
    create index(:bet_matches, [:match_id])
  end
end
