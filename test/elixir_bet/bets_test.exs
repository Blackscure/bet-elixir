defmodule ElixirBet.BetsTest do
  use ElixirBet.DataCase

  alias ElixirBet.Bets

  describe "bets" do
    alias ElixirBet.Bets.Bet

    import ElixirBet.BetsFixtures

    @invalid_attrs %{stake: nil, possible_win: nil, bet_time: nil, bet_expiry: nil, payment_method: nil, payment_no: nil}

    test "list_bets/0 returns all bets" do
      bet = bet_fixture()
      assert Bets.list_bets() == [bet]
    end

    test "get_bet!/1 returns the bet with given id" do
      bet = bet_fixture()
      assert Bets.get_bet!(bet.id) == bet
    end

    test "create_bet/1 with valid data creates a bet" do
      valid_attrs = %{stake: "120.5", possible_win: "120.5", bet_time: ~U[2024-05-09 15:53:00Z], bet_expiry: ~U[2024-05-09 15:53:00Z], payment_method: "some payment_method", payment_no: "some payment_no"}

      assert {:ok, %Bet{} = bet} = Bets.create_bet(valid_attrs)
      assert bet.stake == Decimal.new("120.5")
      assert bet.possible_win == Decimal.new("120.5")
      assert bet.bet_time == ~U[2024-05-09 15:53:00Z]
      assert bet.bet_expiry == ~U[2024-05-09 15:53:00Z]
      assert bet.payment_method == "some payment_method"
      assert bet.payment_no == "some payment_no"
    end

    test "create_bet/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Bets.create_bet(@invalid_attrs)
    end

    test "update_bet/2 with valid data updates the bet" do
      bet = bet_fixture()
      update_attrs = %{stake: "456.7", possible_win: "456.7", bet_time: ~U[2024-05-10 15:53:00Z], bet_expiry: ~U[2024-05-10 15:53:00Z], payment_method: "some updated payment_method", payment_no: "some updated payment_no"}

      assert {:ok, %Bet{} = bet} = Bets.update_bet(bet, update_attrs)
      assert bet.stake == Decimal.new("456.7")
      assert bet.possible_win == Decimal.new("456.7")
      assert bet.bet_time == ~U[2024-05-10 15:53:00Z]
      assert bet.bet_expiry == ~U[2024-05-10 15:53:00Z]
      assert bet.payment_method == "some updated payment_method"
      assert bet.payment_no == "some updated payment_no"
    end

    test "update_bet/2 with invalid data returns error changeset" do
      bet = bet_fixture()
      assert {:error, %Ecto.Changeset{}} = Bets.update_bet(bet, @invalid_attrs)
      assert bet == Bets.get_bet!(bet.id)
    end

    test "delete_bet/1 deletes the bet" do
      bet = bet_fixture()
      assert {:ok, %Bet{}} = Bets.delete_bet(bet)
      assert_raise Ecto.NoResultsError, fn -> Bets.get_bet!(bet.id) end
    end

    test "change_bet/1 returns a bet changeset" do
      bet = bet_fixture()
      assert %Ecto.Changeset{} = Bets.change_bet(bet)
    end
  end
end
