defmodule ElixirBet.BetHistory.History do
  use Ecto.Schema
  import Ecto.Changeset

  schema "histories" do
    field :win, :boolean, default: false
    field :date_created, :utc_datetime
    field :outcome, :string
    belongs_to :bet, ElixirBet.Bets.Bet


    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(history, attrs) do
    history
    |> cast(attrs, [:win, :date_created, :outcome, :bet_id])
    |> validate_required([:win, :date_created, :outcome, :bet_id])
  end
end
