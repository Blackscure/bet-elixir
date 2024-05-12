defmodule ElixirBet.Repo.Migrations.CreateWallets do
  use Ecto.Migration

  def change do
    create table(:wallets) do
      add :balance_brought_forward, :decimal
      add :credit, :boolean, default: false, null: false
      add :debit, :boolean, default: false, null: false
      add :date_created, :utc_datetime
      add :date_modified, :utc_datetime
      add :payment_service_provider, :string
      add :user_id, references(:users, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:wallets, [:user_id])
  end
end
