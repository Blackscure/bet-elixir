defmodule YourApp.Repo.Migrations.DropBetsMatchesTable do
  use Ecto.Migration

  def change do
    drop table(:bets_matches)
  end
end
