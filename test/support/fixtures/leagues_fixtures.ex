defmodule ElixirBet.LeaguesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ElixirBet.Leagues` context.
  """

  @doc """
  Generate a league.
  """
  def league_fixture(attrs \\ %{}) do
    {:ok, league} =
      attrs
      |> Enum.into(%{
        country: "some country",
        description: "some description",
        name: "some name"
      })
      |> ElixirBet.Leagues.create_league()

    league
  end
end
