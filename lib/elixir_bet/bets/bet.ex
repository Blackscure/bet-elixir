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
    field :odd_type, :string   # field for the type of odd (home, away, draw)
    field :odd_value, :decimal # field for the value of the odd
    belongs_to :match, ElixirBet.Matches.Match
    belongs_to :user, ElixirBet.Users.User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(bet, attrs) do
    bet
    |> cast(attrs, [:stake, :possible_win, :bet_time, :odd_type, :odd_value, :match_id, :user_id])
    |> validate_required([:stake, :possible_win, :bet_time, :odd_type, :odd_value, :match_id, :user_id])
    |> maybe_add_optional_fields(attrs)
  end

  defp maybe_add_optional_fields(changeset, attrs) do
    if Map.has_key?(attrs, :bet_expiry) do
      changeset
    else
      cast(changeset, [:bet_expiry], required: false)
    end
    |> maybe_add_optional_field(:payment_method, attrs)
    |> maybe_add_optional_field(:payment_no, attrs)
  end

  defp maybe_add_optional_field(changeset, field, attrs) do
    if Map.has_key?(attrs, field) do
      changeset
    else
      cast(changeset, [field], required: false)
    end
  end
end
