defmodule ElixirBet.Bets.Bet do
  use Ecto.Schema
  import Ecto.Changeset

  schema "bets" do
    field :stake, :decimal
    field :possible_win, :decimal
    field :bet_time, :utc_datetime
    field :odd_type, :string
    field :odd_value, :decimal
    field :canceled, :boolean, default: false


    many_to_many :matches, ElixirBet.Matches.Match, join_through: ElixirBet.Bets.BetMatch
    belongs_to :user, ElixirBet.Users.User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(bet, attrs) do
    bet
    |> cast(attrs, [:stake, :possible_win, :bet_time, :odd_type, :odd_value, :user_id,:canceled])
    |> validate_required([:stake, :possible_win, :bet_time, :odd_type, :odd_value, :user_id])
  end
end
