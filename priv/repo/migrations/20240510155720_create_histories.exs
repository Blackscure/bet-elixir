defmodule ElixirBet.Repo.Migrations.CreateHistories do
  use Ecto.Migration

  def change do
    create table(:histories) do
      add :win, :boolean, default: false, null: false
      add :date_created, :utc_datetime
      add :outcome, :string
      add :bet_id, references(:bets, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:histories, [:bet_id])
  end
end
