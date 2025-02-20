defmodule ElixirBet.MatchesTest do
  use ElixirBet.DataCase

  alias ElixirBet.Matches

  describe "matches" do
    alias ElixirBet.Matches.Match

    import ElixirBet.MatchesFixtures

    @invalid_attrs %{status: nil, home_odd: nil, away_odd: nil, match_time: nil, match_date: nil}

    test "list_matches/0 returns all matches" do
      match = match_fixture()
      assert Matches.list_matches() == [match]
    end

    test "get_match!/1 returns the match with given id" do
      match = match_fixture()
      assert Matches.get_match!(match.id) == match
    end

    test "create_match/1 with valid data creates a match" do
      valid_attrs = %{status: "some status", home_odd: "120.5", away_odd: "120.5", match_time: ~U[2024-05-09 15:41:00Z], match_date: ~D[2024-05-09]}

      assert {:ok, %Match{} = match} = Matches.create_match(valid_attrs)
      assert match.status == "some status"
      assert match.home_odd == Decimal.new("120.5")
      assert match.away_odd == Decimal.new("120.5")
      assert match.match_time == ~U[2024-05-09 15:41:00Z]
      assert match.match_date == ~D[2024-05-09]
    end

    test "create_match/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Matches.create_match(@invalid_attrs)
    end

    test "update_match/2 with valid data updates the match" do
      match = match_fixture()
      update_attrs = %{status: "some updated status", home_odd: "456.7", away_odd: "456.7", match_time: ~U[2024-05-10 15:41:00Z], match_date: ~D[2024-05-10]}

      assert {:ok, %Match{} = match} = Matches.update_match(match, update_attrs)
      assert match.status == "some updated status"
      assert match.home_odd == Decimal.new("456.7")
      assert match.away_odd == Decimal.new("456.7")
      assert match.match_time == ~U[2024-05-10 15:41:00Z]
      assert match.match_date == ~D[2024-05-10]
    end

    test "update_match/2 with invalid data returns error changeset" do
      match = match_fixture()
      assert {:error, %Ecto.Changeset{}} = Matches.update_match(match, @invalid_attrs)
      assert match == Matches.get_match!(match.id)
    end

    test "delete_match/1 deletes the match" do
      match = match_fixture()
      assert {:ok, %Match{}} = Matches.delete_match(match)
      assert_raise Ecto.NoResultsError, fn -> Matches.get_match!(match.id) end
    end

    test "change_match/1 returns a match changeset" do
      match = match_fixture()
      assert %Ecto.Changeset{} = Matches.change_match(match)
    end
  end
end
