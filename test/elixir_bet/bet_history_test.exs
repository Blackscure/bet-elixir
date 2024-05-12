defmodule ElixirBet.BetHistoryTest do
  use ElixirBet.DataCase

  alias ElixirBet.BetHistory

  describe "histories" do
    alias ElixirBet.BetHistory.History

    import ElixirBet.BetHistoryFixtures

    @invalid_attrs %{win: nil, date_created: nil, outcome: nil}

    test "list_histories/0 returns all histories" do
      history = history_fixture()
      assert BetHistory.list_histories() == [history]
    end

    test "get_history!/1 returns the history with given id" do
      history = history_fixture()
      assert BetHistory.get_history!(history.id) == history
    end

    test "create_history/1 with valid data creates a history" do
      valid_attrs = %{win: true, date_created: ~U[2024-05-09 15:57:00Z], outcome: "some outcome"}

      assert {:ok, %History{} = history} = BetHistory.create_history(valid_attrs)
      assert history.win == true
      assert history.date_created == ~U[2024-05-09 15:57:00Z]
      assert history.outcome == "some outcome"
    end

    test "create_history/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = BetHistory.create_history(@invalid_attrs)
    end

    test "update_history/2 with valid data updates the history" do
      history = history_fixture()
      update_attrs = %{win: false, date_created: ~U[2024-05-10 15:57:00Z], outcome: "some updated outcome"}

      assert {:ok, %History{} = history} = BetHistory.update_history(history, update_attrs)
      assert history.win == false
      assert history.date_created == ~U[2024-05-10 15:57:00Z]
      assert history.outcome == "some updated outcome"
    end

    test "update_history/2 with invalid data returns error changeset" do
      history = history_fixture()
      assert {:error, %Ecto.Changeset{}} = BetHistory.update_history(history, @invalid_attrs)
      assert history == BetHistory.get_history!(history.id)
    end

    test "delete_history/1 deletes the history" do
      history = history_fixture()
      assert {:ok, %History{}} = BetHistory.delete_history(history)
      assert_raise Ecto.NoResultsError, fn -> BetHistory.get_history!(history.id) end
    end

    test "change_history/1 returns a history changeset" do
      history = history_fixture()
      assert %Ecto.Changeset{} = BetHistory.change_history(history)
    end
  end
end
