defmodule ElixirBetWeb.BetLive do
  use ElixirBetWeb, :live_view

  alias ElixirBet.Repo
  alias ElixirBet.Bets.Bet
  alias ElixirBet.Teams.Team
  alias ElixirBet.Accounts.User
  alias ElixirBet.Matches.Match

  def mount(_params, _session, socket) do
    bets = list_bets()
    {:ok, assign(socket, bets: bets)}
  end

  defp list_bets do
    Repo.all(Bet) |> Repo.preload(:matches)
  end

  def get_home_team(home_team_id) do
    case Repo.get(Team, home_team_id) do
      nil -> "Unknown team"
      team -> team.name
    end
  end

  def get_away_team(away_team_id) do
    case Repo.get(Team, away_team_id) do
      nil -> "Unknown team"
      team -> team.name
    end
  end

  def get_first_name(user_id) do
    case Repo.get(User, user_id) do
      nil -> "Unknown user"
      user -> user.first_name
    end
  end

  def get_last_name(user_id) do
    case Repo.get(User, user_id) do
      nil -> "Unknown user"
      user -> user.last_name
    end
  end

  def get_match_names(matches) do
    matches
    |> Enum.map(fn
      %ElixirBet.Matches.Match{} = match ->
        "#{get_home_team(match.home_team_id)} vs #{get_away_team(match.away_team_id)}"
      nil ->
        "Unknown match"
    end)
    |> Enum.join(", ") # Join the match names with a comma or any separator you prefer
  end

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
    <h1 class="text-3xl text-black pb-6">Bet Placed</h1>
    <!-- Main content -->
    <div class="flex flex-col flex-grow ml-2 mb-4 mr-4">
      <h2 class="text-2xl font-semibold pt-4 float-left">Bets</h2>
        <div class="relative overflow-x-auto shadow-md ">
        <table class="w-full text-sm text-left rtl:text-right text-gray-500 dark:text-gray-400">
            <thead class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
                <tr>
                    <th scope="col" class="px-6 py-3">
                        Name
                    </th>
                    <th scope="col" class="px-6 py-3">
                        Match
                    </th>
                    <th scope="col" class="px-6 py-3">
                        Stake
                    </th>
                     <th scope="col" class="px-6 py-3">
                        Bet Time
                    </th>
                     <th scope="col" class="px-6 py-3">
                        Possible Win
                    </th>
                    <th scope="col" class="px-6 py-3">
                        Selected
                    </th>
                     <th scope="col" class="px-6 py-3">
                        Bet Time
                    </th>
                        <th scope="col" class="px-6 py-3">
                        Cancel
                    </th>
                </tr>
            </thead>
            <%= if live_flash(@flash, :error) do %>
                <p class="alert alert-danger" role="alert" phx-click="lsRemove" phx-value-key="error"><%= live_flash(@flash, :error) %></p>
            <% end %>
              <tbody>
              <%= for bet <- @bets do %>
                <tr class="odd:bg-white odd:dark:bg-gray-900 even:bg-gray-50 even:dark:bg-gray-800 border-b dark:border-gray-700">
                  <th scope="row" class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white">
                    <%= ElixirBetWeb.BetLive.get_first_name(bet.user_id) %>  <%= ElixirBetWeb.BetLive.get_last_name(bet.user_id) %>
                  </th>
                  <td class="px-6 py">
                    <%= ElixirBetWeb.BetLive.get_match_names(bet.matches) %>
                  </td>
                  <td class="px-6 py-4">
                    <%= bet.stake %>
                  </td>
                  <td class="px-6 py-4">
                    <%= bet.bet_time %>
                  </td>
                  <td class="px-6 py-4">
                    <%= bet.possible_win %>
                  </td>
                  <td class="px-6 py-4">
                    <%= bet.odd_type %>
                  </td>
                  <td class="px-6 py-4">
                    <%= bet.bet_time %>
                  </td>
                  <td class="px-6 py-4">
                    <%= if is_nil(bet.canceled_at) do %>
                        <button phx-click="cancel_bet" phx-value-id="<%= bet.id %>">Cancel</button>
                      <% else %>
                        Canceled
                      <% end %>
                  </td>
                </tr>
              <% end %>
            </tbody>

        </table>
      </div>
    </div>
  </main>
</div>
    """
  end

  def handle_event("cancel_bet", %{"id" => id}, socket) do
    case cancel_bet(id) do
      {:ok, _} ->
        {:noreply, assign(socket, :bets, list_bets())}
      {:error, reason} ->
        {:noreply, put_flash(socket, :error, reason)}
    end
  end

  defp cancel_bet(id) do
    case Repo.get(Bet, id) do
      nil -> {:error, "Bet not found"}
      bet ->
        bet
        |> Bet.changeset(%{canceled_at: DateTime.utc_now()})
        |> Repo.update()
    end
  end
end
