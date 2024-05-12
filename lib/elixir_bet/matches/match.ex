defmodule ElixirBet.Matches.Match do
  use Ecto.Schema
  import Ecto.Changeset

  schema "matches" do
    field :status, :string
    field :home_odd, :decimal
    field :away_odd, :decimal
    field :match_time, :utc_datetime
    field :match_date, :date
    belongs_to :home_team, ElixirBet.Teams.Team
    belongs_to :away_team, ElixirBet.Teams.Team

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(match, attrs) do
    match
    |> cast(attrs, [:home_odd, :away_odd, :match_time, :match_date, :status])
    |> validate_required([:home_odd, :away_odd, :match_time, :match_date, :status])
  end
end
