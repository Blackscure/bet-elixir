defmodule ElixirBet.BetsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ElixirBet.Bets` context.
  """

  @doc """
  Generate a bet.
  """
  def bet_fixture(attrs \\ %{}) do
    {:ok, bet} =
      attrs
      |> Enum.into(%{
        bet_expiry: ~U[2024-05-09 15:53:00Z],
        bet_time: ~U[2024-05-09 15:53:00Z],
        payment_method: "some payment_method",
        payment_no: "some payment_no",
        possible_win: "120.5",
        stake: "120.5"
      })
      |> ElixirBet.Bets.create_bet()

    bet
  end
end
