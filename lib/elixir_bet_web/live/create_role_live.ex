defmodule ElixirBetWeb.ElixirBetWeb.CreateRoleLive do
  use ElixirBetWeb, :live_view
  alias ElixirBet.Roles


  def handle_event("create_role", %{"name" => name, "description" => description}, socket) do
    case Role.create_role(%{name: name, description: description}) do
      {:ok, _role} ->
        {:noreply, socket}

      {:error, _reason} ->
        {:reply, {:error, "Failed to create role."}, socket}
    end
  end

  @impl true
  def mount(_params, _session, socket) do
    changeset = Roles.change_role(%ElixirBet.Roles.Role{})
    {:ok, assign(socket, changeset: changeset)}
  end

  @impl true
  def handle_event("validate_input", %{"role" => role_params}, socket) do
    changeset =
      %ElixirBet.Roles.Role{}
      |> Roles.change_role(role_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, changeset: changeset)}
  end

@impl true
  def handle_event("create_role", %{"role" => role_params}, socket) do
    case Roles.create_role(role_params) do
      {:ok, _role} ->
        {:noreply, redirect(socket, to: "/roles")}

      {:error, changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end


end
