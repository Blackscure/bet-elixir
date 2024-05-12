defmodule ElixirBet.BetKenya.Wallet.Wallet do
  use Ecto.Schema
  import Ecto.Changeset

  schema "wallets" do
    field :balance_brought_forward, :decimal
    field :credit, :boolean, default: false
    field :debit, :boolean, default: false
    field :date_created, :utc_datetime
    field :date_modified, :utc_datetime
    field :payment_service_provider, :string
    belongs_to :user, ElixirBet.Users.User


    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(wallet, attrs) do
    wallet
    |> cast(attrs, [:balance_brought_forward, :credit, :debit, :date_created, :date_modified, :payment_service_provider, :user_id])
    |> validate_required([:balance_brought_forward, :credit, :debit, :date_created, :date_modified, :payment_service_provider, :user_id])
  end
end
