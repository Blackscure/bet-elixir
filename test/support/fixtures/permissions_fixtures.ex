defmodule ElixirBet.PermissionsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ElixirBet.Permissions` context.
  """

  @doc """
  Generate a permission.
  """
  def permission_fixture(attrs \\ %{}) do
    {:ok, permission} =
      attrs
      |> Enum.into(%{

      })
      |> ElixirBet.Permissions.create_permission()

    permission
  end
end
