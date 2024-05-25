defmodule ElixirBetWeb.PermissionLive do
  use ElixirBetWeb, :live_view

  alias ElixirBet.Permissions
  alias ElixirBet.Repo
  alias ElixirBet.Roles.Role

  def mount(_params, _session, socket) do
    permissions = ElixirBet.Permissions.Permission |> ElixirBet.Repo.all()
    {:ok, assign(socket, permissions: permissions)}
  end

    def get_role_name(nil), do: "Unknown role"
    def get_role_name(role_id) do
      case Repo.get(Role, role_id) do
        nil -> "Unknown role"
        role -> role.name
      end
    end


    def handle_event(_, _, socket), do: {:noreply, socket}


end
