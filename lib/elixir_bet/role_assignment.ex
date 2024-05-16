defmodule ElixirBet.RoleAssignment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "role_assignments" do
    belongs_to :user, ElixirBet.Accounts.User
    belongs_to :role, ElixirBet.Roles.Role

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(role_assignment, attrs) do
    role_assignment
    |> cast(attrs, [:user_id, :role_id])
    |> validate_required([:user_id, :role_id])
  end
end
