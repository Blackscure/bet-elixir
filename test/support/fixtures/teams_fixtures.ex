defmodule ElixirBet.TeamsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ElixirBet.Teams` context.
  """

  @doc """
  Generate a team.
  """
  def team_fixture(attrs \\ %{}) do
    {:ok, team} =
      attrs
      |> Enum.into(%{
        name: "some name",
        stadium: "some stadium"
      })
      |> ElixirBet.Teams.create_team()

    team
  end
end
