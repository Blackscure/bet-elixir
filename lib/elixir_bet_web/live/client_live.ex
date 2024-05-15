defmodule ElixirBetWeb.ClientLive do
  use ElixirBetWeb, :live_view
  alias ElixirBet.Accounts

  def mount(_params, _session, socket) do
    {:ok, users} = Accounts.list_users()
    {:ok, assign(socket, users: users)}
  end

  def delete_user(socket, user_id) do
    case Accounts.soft_delete_user(user_id) do
      {:ok, _} ->
        {:noreply, assign(socket, users: Accounts.list_active_users())}
      {:error, reason} ->
        {:noreply, put_flash(socket, :error, reason)}
    end
  end
end
