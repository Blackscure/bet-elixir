defmodule ElixirBet.Repo.Migrations.CreateTeams do
  use Ecto.Migration

  def change do
    create table(:teams) do
      add :name, :string
      add :stadium, :string
      add :league, references(:leagues, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end


    create index(:teams, [:league_id])
  end
end
