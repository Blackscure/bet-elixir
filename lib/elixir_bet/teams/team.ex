defmodule ElixirBet.Teams.Team do
  use Ecto.Schema
  import Ecto.Changeset

  schema "teams" do
    field :name, :string
    field :stadium, :string
    belongs_to :league, ElixirBet.Leagues.League

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(team, attrs) do
    team
    |> cast(attrs, [:name, :stadium, :league_id])
    |> validate_required([:name, :stadium])
  end
end
