defmodule ElixirBet.Bets.Bet do
  use Ecto.Schema
  import Ecto.Changeset

  schema "bets" do
    field :stake, :decimal
    field :possible_win, :decimal
    field :bet_time, :utc_datetime
    field :bet_expiry, :utc_datetime
    field :payment_method, :string
    field :payment_no, :string
    belongs_to :match, ElixirBet.Matches.Match
    belongs_to :user, ElixirBet.Users.User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(bet, attrs) do
    bet
    |> cast(attrs, [:stake, :possible_win, :bet_time, :bet_expiry, :payment_method, :payment_no])
    |> validate_required([:stake, :possible_win, :bet_time, :bet_expiry, :payment_method, :payment_no])
  end
end
