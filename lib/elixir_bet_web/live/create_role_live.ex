defmodule ElixirBetWeb.ElixirBetWeb.CreateRoleLive do
  use ElixirBetWeb, :live_view

  alias ElixirBet.Roles.Role

  def mount(_params, _session, socket) do
    {:ok, assign(socket, role: %Role{})}
  end

  def handle_event("create_role", %{"role" => role_params}, socket) do
    role_changeset = Role.changeset(%Role{}, role_params)

    case Repo.insert(role_changeset) do
      {:ok, _role} ->
        socket =
          socket
          |> put_flash(:info, "Role created successfully.")
          |> assign(role: %Role{})

        {:noreply, socket}
      {:error, changeset} ->
        {:noreply, assign(socket, role: role_params, changeset: changeset)}
    end
  end
end
