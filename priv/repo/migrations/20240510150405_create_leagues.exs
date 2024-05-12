defmodule ElixirBet.Repo.Migrations.CreateLeagues do
  use Ecto.Migration

  def change do
    create table(:leagues) do
      add :name, :string
      add :description, :string
      add :country, :string

      timestamps(type: :utc_datetime)
    end
  end
end
