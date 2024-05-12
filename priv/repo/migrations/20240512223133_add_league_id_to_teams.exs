defmodule ElixirBet.Repo.Migrations.AddLeagueIdToTeams do
  use Ecto.Migration

  def change do
      alter table(:teams) do
        add :league_id, references(:leagues, on_delete: :nothing)
    end
  end
end
