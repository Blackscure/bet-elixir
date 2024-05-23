defmodule ElixirBet.Repo.Migrations.RemoveUnusedFieldsFromBets do
  use Ecto.Migration

  def change do
      alter table(:bets) do
      remove :bet_expiry
      remove :payment_method
      remove :payment_no
    end
  end
end
