defmodule ElixirBet.Roles.Role do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  # Define the schema for the roles table in the database
  schema "roles" do
    field :name, :string
    field :description, :string
    has_many :permissions, ElixirBet.Permissions.Permission  # Define a one-to-many association with permissions

    timestamps(type: :utc_datetime)
  end

  # Documentation for the function below
  @doc """
  Builds a changeset for assigning permissions to a role.

  ## Parameters

    * `role` - The role struct to build the changeset for.
    * `attrs` - The attributes to cast.

  ## Returns

    A changeset struct.

  """
  def assign_permissions_changeset(role, attrs) do
    role
    |> cast(attrs, [:permission_ids])  # Cast the permission_ids attribute
    |> put_assoc(:permissions, attrs[:permission_ids])  # Associate the role with the permissions specified by their IDs
  end

  # Documentation for the function below
  @doc false
  def changeset(role, attrs) do
    role
    |> cast(attrs, [:name, :description])  # Cast the name and description attributes
    |> validate_required([:name, :description])  # Validate that name and description are present
  end

  # Implementation of Ecto.Queryable for Role module
  defimpl Ecto.Queryable, for: __MODULE__ do
    def queryable(_) do
      from(r in __MODULE__, select: r)  # Define a queryable interface for the Role module
    end
  end
end
