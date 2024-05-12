defmodule ElixirBet.ElixirbetFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ElixirBet.Elixirbet` context.
  """

  @doc """
  Generate a dashboard.
  """
  def dashboard_fixture(attrs \\ %{}) do
    {:ok, dashboard} =
      attrs
      |> Enum.into(%{

      })
      |> ElixirBet.Elixirbet.create_dashboard()

    dashboard
  end
end
