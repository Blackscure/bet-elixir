defmodule ElixirBet.Roles.Role do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  schema "roles" do
    field :name, :string
    field :description, :string
    has_many :permissions, ElixirBet.Permissions.Permission

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(role, attrs) do
    role
    |> cast(attrs, [:name, :description])
    |> validate_required([:name, :description])
  end

  defimpl Ecto.Queryable, for: __MODULE__ do
    def queryable(_) do
      from(r in __MODULE__, select: r)
    end
  end
end
