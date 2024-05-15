defmodule ElixirBetWeb.PermissionLive do
  use ElixirBetWeb, :live_view
  alias ElixirBet.Repo
  alias ElixirBet.Permissions.Permission

  def mount(_params, _session, socket) do
    permissions = Repo.all(Permission)
    {:ok, assign(socket, permissions: permissions)}
  end
end
