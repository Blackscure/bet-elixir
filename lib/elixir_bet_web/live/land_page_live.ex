defmodule ElixirBetWeb.LandPageLive do
  use ElixirBetWeb, :live_view
  alias ElixirBet.Matches.Match
  alias ElixirBet.Teams.Team
  alias ElixirBet.Repo
  alias Decimal, as: D

  def mount(_params, _session, socket) do
    matches = Repo.all(Match) |> Repo.preload([:home_team, :away_team])
    selected_bets = []
    stake = Decimal.new(0)
    {:ok, assign(socket, matches: matches, selected_bets: selected_bets, stake: stake)}
  end

  def handle_event("select_odd", %{"match_id" => match_id, "odd_type" => odd_type, "odd_value" => odd_value}, socket) do
    match = Repo.get!(Match, match_id) |> Repo.preload([:home_team, :away_team])
    home_team = match.home_team.name
    away_team = match.away_team.name

    selected_bet = %{
      match_id: match_id,
      home_team: home_team,
      away_team: away_team,
      odd_type: odd_type,
      odd_value: Decimal.new(odd_value)
    }

    selected_bets = socket.assigns.selected_bets
    updated_bets =
      if Enum.any?(selected_bets, &(&1.match_id == match_id)) do
        Enum.map(selected_bets, fn bet ->
          if bet.match_id == match_id, do: selected_bet, else: bet
        end)
      else
        [selected_bet | selected_bets]
      end

    {:noreply, assign(socket, selected_bets: updated_bets)}
  end

  def handle_event("update_stake", %{"stake" => stake}, socket) do
    stake_decimal = Decimal.new(stake)
    {:noreply, assign(socket, stake: stake_decimal)}
  end

  def handle_event("place_bet", _params, socket) do
    selected_bets = socket.assigns.selected_bets
    stake = socket.assigns.stake
    possible_win = Decimal.mult(stake, total_odds(selected_bets))

    # Logic to save the bet goes here, e.g.:
    # Repo.insert!(%ElixirBet.Bets.Bet{
    #   stake: stake,
    #   possible_win: possible_win,
    #   bet_time: DateTime.utc_now(),
    #   odd_type: selected_bet.odd_type,
    #   odd_value: selected_bet.odd_value,
    #   match_id: selected_bet.match_id,
    #   user_id: socket.assigns.user_id,
    #   # additional fields as needed
    # })

    {:noreply, socket}
  end

  defp total_odds(selected_bets) do
    Enum.reduce(selected_bets, Decimal.new(1), fn bet, acc ->
      Decimal.mult(acc, bet.odd_value)
    end)
  end

  def handle_event("remove_bet", %{"match_id" => match_id}, socket) do
    selected_bets = socket.assigns.selected_bets
    updated_bets = Enum.reject(selected_bets, fn bet -> bet.match_id == match_id end)
    {:noreply, assign(socket, selected_bets: updated_bets)}
  end



  def render(assigns) do
    ~L"""
        <div class="flex justify-center items-start mt-0">
          <!-- Games Section -->
          <div class="bg-gray-200 p-4">
            <div class="ml-4 mr-64 pb-4">
              <span class="font-bold text-orange-600">League Name</span>
            </div>
            <!-- Game -->
            <%= for match <- @matches do %>
              <div class="flex">
                <!-- Team information -->
                <div class="ml-4 mr-64">
                  <div class="mb-1">
                    <h6 class="text-sm font-semibold"><%= match.home_team.name %></h6>
                    <h6 class="text-sm font-semibold"><%= match.away_team.name %></h6>
                  </div>
                  <div class="mb-2">
                    <span class="text-xs"><%= match.match_time %></span>
                    <span class="text-xs"><%= match.match_date %></span>
                  </div>
                </div>
                <!-- Buttons -->
                <div class="flex">
                  <button phx-click="select_odd" phx-value-match_id="<%= match.id %>" phx-value-odd_type="home" phx-value-odd_value="<%= match.home_odd %>" class="bg-black hover:bg-orange-700 border border-orange-700 text-white font-bold px-4 rounded mr-2"><%= match.home_odd %></button>
                  <button phx-click="select_odd" phx-value-match_id="<%= match.id %>" phx-value-odd_type="draw" phx-value-odd_value="<%= match.draw_odd %>" class="bg-black hover:bg-orange-700 border border-orange-700 text-white font-bold px-4 rounded mr-2"><%= match.draw_odd %></button>
                  <button phx-click="select_odd" phx-value-match_id="<%= match.id %>" phx-value-odd_type="away" phx-value-odd_value="<%= match.away_odd %>" class="bg-black hover:bg-orange-700 border border-orange-700 text-white font-bold px-4 rounded"><%= match.away_odd %></button>
                </div>
              </div>
            <% end %>
          </div>

          <!-- Betslip Section -->
          <div class="bg-purple-800 p-4">
            <div class="bg-emLavender shadow-inner rounded-tl-lg rounded-br">
              <div class="ml-4 flex items-center">
                <div class="w-8 h-8 flex items-center justify-center text-black rounded-full bg-orange-500 mr-4">
                  <h6 class="text-sm font-semibold"><%= length(@selected_bets) %></h6>
                </div>
                <div class="mr-64">
                  <h6 class="text-sm font-semibold pt-1">Bet Slip</h6>
                </div>
                <div class="mr-4">
                  <!-- Display total odds or other relevant information -->
                </div>
              </div>
              <div class="bg-emDark p-4 mt-4">
                <%= for selected_bet <- @selected_bets do %>
                  <div class="bg-white shadow-inner rounded rounded-br mb-4">
                    <div class="ml-4 flex justify-between items-center">
                      <div class="flex items-center">
                        <div class="w-8 h-8 flex items-center justify-center text-black mr-4">
                          <button phx-click="remove_bet" phx-value-match_id="<%= selected_bet.match_id %>" class="text-sm font-semibold">X</button>
                        </div>
                        <div class="mr-4">
                          <h6 class="text-sm font-semibold pt-1"><%= selected_bet.home_team %> - <%= selected_bet.away_team %></h6>
                          <h6 class="text-xs"><%= selected_bet.odd_type %> odd</h6>
                        </div>
                      </div>
                      <div class="mr-4">
                        <h6 class="text-sm font-semibold pt-1"><%= Decimal.to_string(selected_bet.odd_value) %></h6>
                      </div>
                    </div>
                  </div>
                <% end %>
                <div class="bg-white shadow-inner rounded p-4 mt-4">
                  <div class="flex items-center justify-between">
                    <div class="flex items-center">
                      <h6 class="text-sm font-semibold">Stake</h6>
                    </div>
                    <div>
                      <input type="number" phx-change="update_stake" name="stake" value="<%= Decimal.to_string(@stake) %>" class="bg-gray-50 border border-gray-300 text-gray-900 text-xs rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2 py-1.5 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" placeholder="Stake" required />
                    </div>
                  </div>
                  <div class="flex items-center justify-between mt-2">
                    <div>
                      <p class="text-xs">To Win</p>
                    </div>
                    <div class="w-8 h-8 flex items-center justify-center text-black">
                      <h6 class="text-sm font-semibold"><%= Decimal.to_string(Decimal.mult(@stake, total_odds(@selected_bets))) %></h6>
                    </div>
                  </div>
                </div>
                <!-- Button to place all bets -->
                <button phx-click="place_bet" class="w-full focus:outline-none text-white bg-purple-700 hover:bg-purple-800 focus:ring-4 focus:ring-purple-300 font-medium rounded-sm text-sm px-5 py-2.5 dark:bg-purple-600 dark:hover:bg-purple-700 dark:focus:ring-purple-900 mt-4">Place Bet</button>
              </div>
            </div>
          </div>
        </div>

    """
  end
end
