defmodule ElixirBetWeb.CreateMatchLive do
  use ElixirBetWeb, :live_view

  alias ElixirBet.{Repo, Teams.Team, Matches.Match}

  # Mount function to initialize data when the LiveView is mounted
  def mount(_params, _session, socket) do
    {:ok, assign(socket, teams: fetch_teams())}
  end

  # Render function to generate the HTML for the LiveView
  def render(assigns) do
    ~L"""
    <div class="flex h-screen bg-gray-200">
  <aside class="relative bg-sidebar h-screen w-64 hidden sm:block shadow-xl">
    <nav class="text-white text-base font-semibold pt-3">
      <button onclick="location.href='/dashboard'" class="flex items-center text-white opacity-75 hover:opacity-100 py-4 pl-6 nav-item">
        <i class="fas fa-tachometer-alt mr-3"></i>
        Dashboard
      </button>
      <button onclick="location.href='/users'" class="flex items-center text-white opacity-75 hover:opacity-100 py-4 pl-6 nav-item">
        <i class="fas fa-sticky-note mr-3"></i>
        Users
      </button>
      <button onclick="location.href='/roles'" class="flex items-center text-white opacity-75 hover:opacity-100 py-4 pl-6 nav-item">
        <i class="fas fa-sticky-note mr-3"></i>
        Roles
      </button>
      <button onclick="location.href='/permissions'" class="flex items-center text-white opacity-75 hover:opacity-100 py-4 pl-6 nav-item">
        <i class="fas fa-table mr-3"></i>
        Permissions
      </button>
      <button onclick="location.href='/teams'" class="flex items-center text-white opacity-75 hover:opacity-100 py-4 pl-6 nav-item">
        <i class="fas fa-table mr-3"></i>
        Teams
      </button>
      <button onclick="location.href='/leagues'" class="flex items-center active-nav-link text-white py-4 pl-6 nav-item">
        <i class="fas fa-align-left mr-3"></i>
        Leagues
      </button>
      <button onclick="location.href='/matches'" class="flex items-center text-white opacity-75 hover:opacity-100 py-4 pl-6 nav-item">
        <i class="fas fa-tablet-alt mr-3"></i>
        Matches
      </button>
      <button onclick="location.href='/wallets'" class="flex items-center text-white opacity-75 hover:opacity-100 py-4 pl-6 nav-item">
        <i class="fas fa-tablet-alt mr-3"></i>
        Wallet
      </button>
      <button onclick="location.href='/bets'" class="flex items-center text-white opacity-75 hover:opacity-100 py-4 pl-6 nav-item">
        <i class="fas fa-tablet-alt mr-3"></i>
        Bets
      </button>
      <button onclick="location.href='/history'" class="flex items-center text-white opacity-75 hover:opacity-100 py-4 pl-6 nav-item">
        <i class="fas fa-tablet-alt mr-3"></i>
        Bet History
      </button>
    </nav>
  </aside>

  <main class="w-full flex-grow p-6">
    <h1 class="text-3xl text-black pb-6">Matches</h1>

        <div class="leading-loose">
          <form phx-submit="create_match" class="p-10 bg-gray-900 rounded shadow-xl">
            <p class="text-lg text-white font-medium pb-4">Match Information</p>

            <div class="flex flex-wrap -mx-3 mb-6">
              <div class="w-full md:w-1/2 px-3 mb-6 md:mb-0">
                <label for="home_odd" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Home Odd</label>
                <input type="number" id="home_odd" name="match[home_odd]" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" placeholder="Home Odd" required />
              </div>

              <div class="w-full md:w-1/2 px-3">
                <label for="away_odd" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Away Odd</label>
                <input type="number" id="away_odd" name="match[away_odd]" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" placeholder="Away Odd" required />
              </div>
            </div>

            <div class="flex flex-wrap -mx-3 mb-6">
              <div class="w-full md:w-1/2 px-3 mb-6 md:mb-0">
                <label for="draw_odd" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Draw Odd</label>
                <input type="number" id="draw_odd" name="match[draw_odd]" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" placeholder="Draw Odd" required />
              </div>

              <div class="w-full md:w-1/2 px-3">
                <label for="match_date" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Match Date</label>
                <input type="date" id="match_date" name="match[match_date]" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" required />
              </div>
            </div>

            <div class="flex flex-wrap -mx-3 mb-6">
                <div class="w-full md:w-1/2 px-3 mb-6 md:mb-0">
                    <label for="match_time" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Match Time</label>
                    <input type="time" id="match_time" name="match[match_time]" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" required />
                  </div>

              <div class="w-full md:w-1/2 px-3">
                <label for="home_team" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Home Team</label>
                <select id="home_team" name="match[home_team_id]" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500">
                  <%= for team <- @teams do %>
                    <option value="<%= team.id %>"><%= team.name %></option>
                  <% end %>
                </select>
              </div>
            </div>

            <div class="flex flex-wrap -mx-3 mb-6">
              <div class="w-full md:w-1/2 px-3 mb-6 md:mb-0">
                <label for="away_team" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Away Team</label>
                <select id="away_team" name="match[away_team_id]" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500">
                  <%= for team <- @teams do %>
                    <option value="<%= team.id %>"><%= team.name %></option>
                  <% end %>
                </select>
              </div>

              <div class="w-full md:w-1/2 px-3">
              <label for="match_status" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Match Status</label>
              <select id="match_status" name="match[status]" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500">
                <option value="started">Started</option>
                <option value="half_time">Half Time</option>
                <option value="not_started">Not Started</option>
                <option value="ended">Ended</option>
              </select>
            </div>
            </div>

            <div class="mt-6">
              <button class="px-4 py-1 text-white font-light tracking-wider bg-orange-700 rounded" type="submit">Save</button>
            </div>
          </form>
        </div>

  </main>
</div>
    """
  end

  # Handle the form submission
def handle_event("create_match", %{"match" => match_params}, socket) do
  IO.inspect(match_params, label: "Match Params") # Add this line to inspect the match_params

  changeset = Match.changeset(%Match{}, match_params)

  IO.inspect(changeset, label: "Changeset") # Add this line to inspect the changeset

  case Repo.insert(changeset) do
    {:ok, _match} ->
      IO.puts("Match inserted successfully")
      {:noreply, socket |> put_flash(:info, "Match created successfully!") |> redirect(to: "/matches")}
    {:error, changeset} ->
      IO.puts("Error inserting match: #{inspect(changeset.errors)}")
      {:noreply, assign(socket, changeset: changeset)}
  end
end


  # Fetch all teams to populate the dropdowns
  defp fetch_teams do
    Repo.all(Team)
  end
end
