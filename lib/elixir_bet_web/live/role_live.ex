defmodule ElixirBetWeb.RoleLive do
  use ElixirBetWeb, :live_view

  def mount(_params, _session, socket) do
    roles = ElixirBet.Roles.Role |> ElixirBet.Repo.all()
    {:ok, assign(socket, roles: roles)}
  end

end
