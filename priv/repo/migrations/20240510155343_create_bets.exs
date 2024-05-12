defmodule ElixirBet.Repo.Migrations.CreateBets do
  use Ecto.Migration

  def change do
    create table(:bets) do
      add :stake, :decimal
      add :possible_win, :decimal
      add :bet_time, :utc_datetime
      add :bet_expiry, :utc_datetime
      add :payment_method, :string
      add :payment_no, :string
      add :match_id, references(:matches, on_delete: :nothing)
      add :user_id, references(:users, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:bets, [:match_id])
    create index(:bets, [:user_id])
  end
end
