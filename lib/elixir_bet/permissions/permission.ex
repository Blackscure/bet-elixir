defmodule ElixirBet.Permissions.Permission do
  use Ecto.Schema
  import Ecto.Changeset

  schema "permissions" do
   
    belongs_to :role, ElixirBet.Roles.Role

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(permission, attrs) do
    permission
    |> cast(attrs, [])
    |> validate_required([])
  end
end
