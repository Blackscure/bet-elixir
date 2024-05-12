defmodule ElixirBet.BetKenya.WalletTest do
  use ElixirBet.DataCase

  alias ElixirBet.BetKenya.Wallet

  describe "wallets" do
    alias ElixirBet.BetKenya.Wallet.Wallet

    import ElixirBet.BetKenya.WalletFixtures

    @invalid_attrs %{balance_brought_forward: nil, credit: nil, debit: nil, date_created: nil, date_modified: nil, payment_service_provider: nil}

    test "list_wallets/0 returns all wallets" do
      wallet = wallet_fixture()
      assert Wallet.list_wallets() == [wallet]
    end

    test "get_wallet!/1 returns the wallet with given id" do
      wallet = wallet_fixture()
      assert Wallet.get_wallet!(wallet.id) == wallet
    end

    test "create_wallet/1 with valid data creates a wallet" do
      valid_attrs = %{balance_brought_forward: "120.5", credit: true, debit: true, date_created: ~U[2024-05-09 16:06:00Z], date_modified: ~U[2024-05-09 16:06:00Z], payment_service_provider: "some payment_service_provider"}

      assert {:ok, %Wallet{} = wallet} = Wallet.create_wallet(valid_attrs)
      assert wallet.balance_brought_forward == Decimal.new("120.5")
      assert wallet.credit == true
      assert wallet.debit == true
      assert wallet.date_created == ~U[2024-05-09 16:06:00Z]
      assert wallet.date_modified == ~U[2024-05-09 16:06:00Z]
      assert wallet.payment_service_provider == "some payment_service_provider"
    end

    test "create_wallet/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Wallet.create_wallet(@invalid_attrs)
    end

    test "update_wallet/2 with valid data updates the wallet" do
      wallet = wallet_fixture()
      update_attrs = %{balance_brought_forward: "456.7", credit: false, debit: false, date_created: ~U[2024-05-10 16:06:00Z], date_modified: ~U[2024-05-10 16:06:00Z], payment_service_provider: "some updated payment_service_provider"}

      assert {:ok, %Wallet{} = wallet} = Wallet.update_wallet(wallet, update_attrs)
      assert wallet.balance_brought_forward == Decimal.new("456.7")
      assert wallet.credit == false
      assert wallet.debit == false
      assert wallet.date_created == ~U[2024-05-10 16:06:00Z]
      assert wallet.date_modified == ~U[2024-05-10 16:06:00Z]
      assert wallet.payment_service_provider == "some updated payment_service_provider"
    end

    test "update_wallet/2 with invalid data returns error changeset" do
      wallet = wallet_fixture()
      assert {:error, %Ecto.Changeset{}} = Wallet.update_wallet(wallet, @invalid_attrs)
      assert wallet == Wallet.get_wallet!(wallet.id)
    end

    test "delete_wallet/1 deletes the wallet" do
      wallet = wallet_fixture()
      assert {:ok, %Wallet{}} = Wallet.delete_wallet(wallet)
      assert_raise Ecto.NoResultsError, fn -> Wallet.get_wallet!(wallet.id) end
    end

    test "change_wallet/1 returns a wallet changeset" do
      wallet = wallet_fixture()
      assert %Ecto.Changeset{} = Wallet.change_wallet(wallet)
    end
  end
end
