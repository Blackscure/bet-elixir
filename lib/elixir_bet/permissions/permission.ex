defmodule ElixirBet.Permissions.Permission do
  use Ecto.Schema
  import Ecto.Changeset

  schema "permissions" do
    field :action, :string
    field :resource, :string
    belongs_to :user, ElixirBet.Accounts.User
    belongs_to :role, ElixirBet.Roles.Role


    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(permission, attrs) do
    permission
    |> cast(attrs, [:action, :resource, :user_id, :role_id])
    |> validate_required([:action, :resource, :user_id, :role_id])

  end
end
