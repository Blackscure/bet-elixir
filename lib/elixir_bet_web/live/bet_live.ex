defmodule ElixirBetWeb.BetLive do
  use ElixirBetWeb, :live_view

  alias ElixirBet.Repo
  alias ElixirBet.Bets.Bet
  alias ElixirBet.Teams.Team
  alias ElixirBet.Accounts.User
  alias ElixirBet.Matches.Match
  alias Phoenix.HTML

  def mount(_params, _session, socket) do
    bets = all_bets()
    {:ok, assign(socket, bets: bets)}
  end

  def all_bets do
    bets = Repo.all(Bet) |> Repo.preload(:matches)
    IO.inspect(bets, label: "Bets in all_bets:")
    bets
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

  def delete_bet(bet_id) do
    bet = Repo.get!(ElixirBet.Bets.Bet, bet_id)
    Repo.delete!(bet)
  end


  def render(assigns) do
    ~L"""

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
               <button phx-click="cancel_bet" phx-value-bet_id="<%= bet.id %>" class="font-medium text-red-600 dark:text-red-500 hover:underline">Cancel</button>
            </td>
            </tr>
        <% end %>
        </tbody>
    </table>
</div>

  </div>

    """
  end

def handle_event("cancel_bet", %{"bet_id" => bet_id}, socket) do
  delete_bet(bet_id)
  bets = all_bets()
  {:noreply, assign(socket, bets: bets)}
end

end
