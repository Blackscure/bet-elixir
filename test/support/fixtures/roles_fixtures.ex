defmodule ElixirBet.RolesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ElixirBet.Roles` context.
  """

  @doc """
  Generate a role.
  """
  def role_fixture(attrs \\ %{}) do
    {:ok, role} =
      attrs
      |> Enum.into(%{
        description: "some description",
        name: "some name"
      })
      |> ElixirBet.Roles.create_role()

    role
  end
end
