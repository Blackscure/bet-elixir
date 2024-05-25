defmodule ElixirBetWeb.CreateLeagueLive do
  use ElixirBetWeb, :live_view

  alias ElixirBet.Repo
  alias ElixirBet.Leagues.League



def handle_event("submit_league", %{"name" => name, "description" => description, "country" => country}, socket) do
  current_user = socket.assigns.current_user

  # Check if current user has role_id 1
  if current_user.role_id == 1 do
    # Check if a league with the same name already exists
    existing_league = Repo.get_by(League, name: name)

    if existing_league do
      # League with the same name already exists, set flash message and redirect
      socket =
        socket
        |> put_flash(:error, "League '#{name}' already exists.")
        |> redirect(to: socket.endpoint)

      {:noreply, socket}
    else
      # League with the same name doesn't exist, proceed with insertion
      changeset = League.changeset(%League{}, %{name: name, description: description, country: country})

      if changeset.valid? do
        case Repo.insert(changeset) do
          {:ok, _league} ->
            # Insertion successful, set flash message
            socket =
              socket
              |> put_flash(:success, "League added successfully!")
              |> redirect(to: "/leagues")

            {:noreply, socket}
          {:error, changeset} ->
            # Insertion failed, log the error and assign the changeset back to the socket
            Logger.error("Failed to insert league changeset: #{inspect(changeset)}")
            {:noreply, assign(socket, changeset: changeset)}
        end
      else
        # Changeset is invalid, log the error and assign it back to the socket
        Logger.error("Invalid league changeset: #{inspect(changeset)}")
        {:noreply, assign(socket, changeset: changeset)}
      end
    end
  else
    # User does not have permission to create a league
    socket =
      socket
      |> put_flash(:error, "You don't have permission to create a league.")
      |> redirect(to: socket.endpoint)

    {:noreply, socket}
  end
end



end
