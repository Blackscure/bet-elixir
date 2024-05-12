defmodule ElixirBet.MatchesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ElixirBet.Matches` context.
  """

  @doc """
  Generate a match.
  """
  def match_fixture(attrs \\ %{}) do
    {:ok, match} =
      attrs
      |> Enum.into(%{
        away_odd: "120.5",
        home_odd: "120.5",
        match_date: ~D[2024-05-09],
        match_time: ~U[2024-05-09 15:41:00Z],
        status: "some status"
      })
      |> ElixirBet.Matches.create_match()

    match
  end
end
