defmodule ElixirBetWeb.CreateLeagueLive do
  use ElixirBetWeb, :live_view

  alias ElixirBet.Repo
  alias ElixirBet.Leagues.League



def handle_event("submit_league", %{"name" => name, "description" => description, "country" => country}, socket) do
  # Check if a league with the same name already exists
  existing_league = Repo.get_by(League, name: name)

  if existing_league do
    # League with the same name already exists, set flash message and redirect
    socket =
      socket
      |> put_flash(:error, "League '#{name}' already exists.")
      |> redirect(to: socket.endpoint)
  else
    # League with the same name doesn't exist, proceed with insertion
    changeset = League.changeset(%League{}, %{name: name, description: description, country: country})

    if changeset.valid? do
      case Repo.insert(changeset) do
        {:ok, _league} ->
          # Insertion successful, set flash message
          socket =
            socket
            |> put_flash(:info, "League added successfully!")
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
end


end
