defmodule ElixirBet.Leagues.League do
  use Ecto.Schema
  import Ecto.Changeset

  schema "leagues" do
    field :name, :string
    field :description, :string
    field :country, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(league, attrs) do
    league
    |> cast(attrs, [:name, :description, :country])
    |> validate_required([:name, :description, :country])
  end
end
