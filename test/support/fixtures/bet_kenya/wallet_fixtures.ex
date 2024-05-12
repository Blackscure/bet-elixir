defmodule ElixirBet.BetKenya.WalletFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ElixirBet.BetKenya.Wallet` context.
  """

  @doc """
  Generate a wallet.
  """
  def wallet_fixture(attrs \\ %{}) do
    {:ok, wallet} =
      attrs
      |> Enum.into(%{
        balance_brought_forward: "120.5",
        credit: true,
        date_created: ~U[2024-05-09 16:06:00Z],
        date_modified: ~U[2024-05-09 16:06:00Z],
        debit: true,
        payment_service_provider: "some payment_service_provider"
      })
      |> ElixirBet.BetKenya.Wallet.create_wallet()

    wallet
  end
end
