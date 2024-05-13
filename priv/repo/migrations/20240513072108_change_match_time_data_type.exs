defmodule ElixirBet.Repo.Migrations.ChangeMatchTimeDataType do
  use Ecto.Migration

  def change do
    alter table(:matches) do
      modify :match_time, :time
    end
  end
end
