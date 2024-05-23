defmodule ElixirBet.Bets.BetMatch do
  use Ecto.Schema
  import Ecto.Changeset

  schema "bet_matches" do
    belongs_to :bet, ElixirBet.Bets.Bet
    belongs_to :match, ElixirBet.Bets.Match

    timestamps()
  end

  def changeset(bet_match, attrs) do
    bet_match
    |> cast(attrs, [:bet_id, :match_id])
    |> validate_required([:bet_id, :match_id])
    |> foreign_key_constraint(:bet_id)
    |> foreign_key_constraint(:match_id)
  end
end
