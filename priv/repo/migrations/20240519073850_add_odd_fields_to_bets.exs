defmodule ElixirBet.Repo.Migrations.AddOddFieldsToBets do
  use Ecto.Migration

  def change do
    alter table(:bets) do
      add :odd_type, :string
      add :odd_value, :decimal
    end
  end
end
