defmodule ElixirBet.Repo.Migrations.AddDrawOddToMatches do
  use Ecto.Migration

  def change do
    alter table(:matches) do
      add :draw_odd, :decimal
    end
  end
end
