defmodule ElixirBet.LeaguesTest do
  use ElixirBet.DataCase

  alias ElixirBet.Leagues

  describe "leagues" do
    alias ElixirBet.Leagues.League

    import ElixirBet.LeaguesFixtures

    @invalid_attrs %{name: nil, description: nil, country: nil}

    test "list_leagues/0 returns all leagues" do
      league = league_fixture()
      assert Leagues.list_leagues() == [league]
    end

    test "get_league!/1 returns the league with given id" do
      league = league_fixture()
      assert Leagues.get_league!(league.id) == league
    end

    test "create_league/1 with valid data creates a league" do
      valid_attrs = %{name: "some name", description: "some description", country: "some country"}

      assert {:ok, %League{} = league} = Leagues.create_league(valid_attrs)
      assert league.name == "some name"
      assert league.description == "some description"
      assert league.country == "some country"
    end

    test "create_league/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Leagues.create_league(@invalid_attrs)
    end

    test "update_league/2 with valid data updates the league" do
      league = league_fixture()
      update_attrs = %{name: "some updated name", description: "some updated description", country: "some updated country"}

      assert {:ok, %League{} = league} = Leagues.update_league(league, update_attrs)
      assert league.name == "some updated name"
      assert league.description == "some updated description"
      assert league.country == "some updated country"
    end

    test "update_league/2 with invalid data returns error changeset" do
      league = league_fixture()
      assert {:error, %Ecto.Changeset{}} = Leagues.update_league(league, @invalid_attrs)
      assert league == Leagues.get_league!(league.id)
    end

    test "delete_league/1 deletes the league" do
      league = league_fixture()
      assert {:ok, %League{}} = Leagues.delete_league(league)
      assert_raise Ecto.NoResultsError, fn -> Leagues.get_league!(league.id) end
    end

    test "change_league/1 returns a league changeset" do
      league = league_fixture()
      assert %Ecto.Changeset{} = Leagues.change_league(league)
    end
  end
end
