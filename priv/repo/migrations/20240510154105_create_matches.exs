defmodule ElixirBet.Repo.Migrations.CreateMatches do
  use Ecto.Migration

  def change do
    create table(:matches) do
      add :home_odd, :decimal
      add :away_odd, :decimal
      add :match_time, :utc_datetime
      add :match_date, :date
      add :status, :string
      add :home_team_id, references(:teams, on_delete: :nothing)
      add :away_team_id, references(:teams, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:matches, [:home_team_id])
    create index(:matches, [:away_team_id])
  end
end
