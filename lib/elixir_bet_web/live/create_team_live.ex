defmodule ElixirBetWeb.CreateTeamLive do
  use ElixirBetWeb, :live_view

  alias ElixirBet.{Repo, Teams.Team, Leagues.League}

  def mount(_params, _session, socket) do
    {:ok, assign(socket, leagues: fetch_leagues(), flash_message: nil)}
  end

  def render(assigns) do
    ~L"""
  <div class="leading-loose">
      <form phx-submit="create_team" class="p-10 bg-gray-900 rounded shadow-xl">
        <p class="text-lg text-white font-medium pb-4">Create team</p>

        <div class="inline-block mt-2 w-full pr-1">
          <label for="league_id" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">League Name</label>
          <select name="team[league_id]" id="league_id" class="block w-full p-2 mb-6 text-sm text-gray-900 border border-gray-300 rounded-lg bg-gray-50 focus:ring-blue-500 focus:border-blue-500 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500">
            <option selected disabled>Select a league</option>
            <%= for league <- @leagues do %>
              <option value="<%= league.id %>"><%= league.name %></option>
            <% end %>
          </select>
        </div>

        <div class="mb-5">
          <label for="team_name" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Team name</label>
          <input type="text" id="team_name" name="team[name]" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" placeholder="Team Name" required />
        </div>

        <div class="mb-5">
          <label for="stadium_name" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Stadium Name</label>
          <input type="text" id="stadium_name" name="team[stadium]" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" placeholder="Stadium Name" required />
        </div>

        <div class="mt-6">
          <button class="px-4 py-1 text-white font-light tracking-wider bg-orange-700 rounded" type="submit">Save</button>
        </div>
      </form>
    </div>
    """
  end
def handle_event("create_team", %{"team" => team_params}, socket) do
  changeset = Team.changeset(%Team{}, team_params)

  case Repo.insert(changeset) do
    {:ok, _team} ->
      socket =
        socket
        |> put_flash(:info, "Team created successfully!")
        |> redirect(to: "/teams")

      {:noreply, socket}
    {:error, changeset} ->
      Logger.error("Failed to insert team changeset: #{inspect(changeset)}")
      {:noreply, assign(socket, changeset: changeset)}
  end
end


  defp fetch_leagues do
    Repo.all(League)
  end
end
