defmodule ElixirBet.Repo.Migrations.UpdateBetsToManyToManyMatches do
  use Ecto.Migration

  def change do
    # Create the join table for bets and matches
    create table(:bets_matches, primary_key: false) do
      add :bet_id, references(:bets, on_delete: :delete_all), null: false
      add :match_id, references(:matches, on_delete: :delete_all), null: false

      timestamps(type: :utc_datetime)
    end

    create unique_index(:bets_matches, [:bet_id, :match_id])

    # Remove the existing match_id column from bets
    alter table(:bets) do
      remove :match_id
    end
  end
end
