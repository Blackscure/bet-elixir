defmodule ElixirBet.Profiles.Profile do
  use Ecto.Schema
  import Ecto.Changeset

  schema "profiles" do
    field :msisdn, :string
    belongs_to :user, ElixirBet.Users.User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(profile, attrs) do
    profile
    |> cast(attrs, [:msisdn, :user_id])
    |> validate_required([:msisdn])
  end
end
