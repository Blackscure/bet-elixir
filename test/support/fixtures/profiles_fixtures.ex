defmodule ElixirBet.ProfilesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ElixirBet.Profiles` context.
  """

  @doc """
  Generate a profile.
  """
  def profile_fixture(attrs \\ %{}) do
    {:ok, profile} =
      attrs
      |> Enum.into(%{
        msisdn: "some msisdn"
      })
      |> ElixirBet.Profiles.create_profile()

    profile
  end
end
