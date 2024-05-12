defmodule ElixirBet.BetHistoryFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ElixirBet.BetHistory` context.
  """

  @doc """
  Generate a history.
  """
  def history_fixture(attrs \\ %{}) do
    {:ok, history} =
      attrs
      |> Enum.into(%{
        date_created: ~U[2024-05-09 15:57:00Z],
        outcome: "some outcome",
        win: true
      })
      |> ElixirBet.BetHistory.create_history()

    history
  end
end
