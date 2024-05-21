defmodule ElixirBetWeb.LandPageLive do
  use ElixirBetWeb, :live_view
  alias ElixirBet.Matches.Match
  alias ElixirBet.Teams.Team
  alias ElixirBet.Repo
  alias Decimal, as: D

  # Mount function to initialize the LiveView socket with initial state
  def mount(_params, _session, socket) do
    # Fetch all matches from the database and preload associated teams
    matches = Repo.all(Match) |> Repo.preload([:home_team, :away_team])
    # Initialize selected bets as an empty list
    selected_bets = []
    # Initialize stake and possible win as Decimal values of 0
    stake = Decimal.new(50)
    possible_win = Decimal.new(0)
    # Assign initial values to the socket and return :ok
    {:ok, assign(socket, matches: matches, selected_bets: selected_bets, stake: stake, possible_win: possible_win)}
  end

  # Handle event for selecting an odd (bet) on a match
  def handle_event("select_odd", %{"match_id" => match_id, "odd_type" => odd_type, "odd_value" => odd_value}, socket) do
    # Fetch the match by ID and preload associated teams
    match = Repo.get!(Match, match_id) |> Repo.preload([:home_team, :away_team])
    # Extract home and away team names
    home_team = match.home_team.name
    away_team = match.away_team.name

    # Create a new selected bet map
    selected_bet = %{
      match_id: match_id,
      home_team: home_team,
      away_team: away_team,
      odd_type: odd_type,
      odd_value: Decimal.new(odd_value)
    }

    # Get the current selected bets from the socket
    selected_bets = socket.assigns.selected_bets
    # Update the selected bets list
    updated_bets =
      if Enum.any?(selected_bets, &(&1.match_id == match_id)) do
        Enum.map(selected_bets, fn bet ->
          if bet.match_id == match_id, do: selected_bet, else: bet
        end)
      else
        [selected_bet | selected_bets]
      end

    # Recalculate possible win with the updated bets
    possible_win = calculate_possible_win(socket.assigns.stake, updated_bets)
    IO.inspect(possible_win, label: "Possible Win After Bet Selection")

    # Assign updated values to the socket and return :noreply
    {:noreply, assign(socket, selected_bets: updated_bets, possible_win: possible_win)}
  end

  # Handle event for updating the stake amount
  def handle_event("update_stake", %{"stake" => stake_str}, socket) do
    # Inspect the stake input for debugging purposes
    IO.inspect(stake_str, label: "Stake Input")
    # Attempt to convert the stake input to a Decimal
    case Decimal.new(stake_str) do
      {:ok, stake_decimal} ->
        # If successful, recalculate possible win with the new stake
        possible_win = calculate_possible_win(stake_decimal, socket.assigns.selected_bets)
        # Inspect the possible win for debugging purposes
        IO.inspect(possible_win, label: "Possible Win")
        # Assign updated stake and possible win to the socket and return :noreply
        {:noreply, assign(socket, stake: stake_decimal, possible_win: possible_win)}

      :error ->
        # If the conversion fails, return the socket unchanged
        {:noreply, socket}
    end
  end

    # Handle event for placing a bet
 def handle_event("place_bet", _params, socket) do
  user_id = socket.assigns.current_user.id
  stake = socket.assigns.stake
  possible_win = socket.assigns.possible_win
  bet_time = DateTime.utc_now()

  # Iterate over the selected bets and insert them into the database
  Enum.each(socket.assigns.selected_bets, fn selected_bet ->
    bet_attrs = %{
      stake: stake,
      possible_win: possible_win,
      bet_time: bet_time,
      bet_expiry: selected_bet.bet_expiry, # You need to handle bet expiry appropriately
      payment_method: "default_method", # Set this according to your logic
      payment_no: "default_no", # Set this according to your logic
      odd_type: selected_bet.odd_type,
      odd_value: selected_bet.odd_value,
      match_id: selected_bet.match_id,
      user_id: user_id
    }

    case ElixirBet.Bets.Bet.changeset(%ElixirBet.Bets.Bet{}, bet_attrs) |> Repo.insert() do
      {:ok, _bet} ->
        :ok
      {:error, changeset} ->
        IO.inspect(changeset, label: "Bet Insertion Error")
    end
  end)

  # Clear selected bets and reset stake and possible win
  {:noreply, assign(socket, selected_bets: [], stake: Decimal.new(0), possible_win: Decimal.new(0))}
end


  # Handle event for removing a bet
  def handle_event("remove_bet", %{"match_id" => match_id}, socket) do
    # Get the current selected bets from the socket
    selected_bets = socket.assigns.selected_bets
    # Remove the bet with the specified match ID
    updated_bets = Enum.reject(selected_bets, fn bet -> bet.match_id == match_id end)
    # Recalculate possible win with the updated bets
    possible_win = calculate_possible_win(socket.assigns.stake, updated_bets)
    # Assign updated values to the socket and return :noreply
    {:noreply, assign(socket, selected_bets: updated_bets, possible_win: possible_win)}
  end

  # Private function to calculate possible win based on stake and selected bets
  defp calculate_possible_win(stake, selected_bets) do
    # Calculate total odds from the selected bets
    total_odds = total_odds(selected_bets)
    IO.inspect(total_odds, label: "Total Odds")
    # Multiply the stake by the total odds to get possible win
    Decimal.mult(stake, total_odds)
  end

  # Private function to calculate total odds from selected bets
  defp total_odds(selected_bets) do
    # Sum the odd values of all selected bets
    Enum.reduce(selected_bets, Decimal.new(0), fn bet, acc ->
      Decimal.add(acc, bet.odd_value)
    end)
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
                 <button phx-click="select_odd" phx-value-match_id="<%= match.id %>" phx-value-odd_type="draw" phx-value-odd_value="<%= match.draw_odd || '0.00' %>" class="bg-black hover:bg-orange-700 border border-orange-700 text-white font-bold px-4 rounded mr-2"><%= match.draw_odd || '0.0' %></button>

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
                    <h6 class="text-sm font-semibold pt-1">Total Odds</h6>
                    <h6 class="text-xs"><%= Decimal.to_string(total_odds(@selected_bets)) %></h6>
                </div>
              </div>
              <div class="bg-emDark p-4 mt-4">
                <!-- Scrollable betslip container -->
                <div class="bg-white shadow-inner rounded p-4 mt-4 max-h-64 overflow-y-auto">
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
                </div>
                <div class="bg-white shadow-inner rounded p-4 mt-4">
                  <div class="flex items-center justify-between">
                    <div class="flex items-center">
                      <h6 class="text-sm font-semibold">Stake</h6>

                    </div>
                   <div>
                   <input type="number" phx-debounce="500" phx-change="update_stake" value="<%= Decimal.to_string(@stake) %>" class="bg-gray-50 border border-gray-300 text-black text-xs rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2 py-1.5 dark:border-gray-600 dark:placeholder-gray-400 dark:text-black dark:focus:ring-blue-500 dark:focus:border-blue-500" placeholder="Stake" required />

                  </div>

                  </div>
                  <div class="flex items-center justify-between mt-2">
                    <div>
                      <p class="text-xs">To Win</p>
                    </div>
                    <div class="w-8 h-8 flex items-center justify-center text-black">
                     <h6 class="text-sm font-semibold"><%= IO.inspect(Decimal.to_string(@possible_win), label: "Possible Win Display") %></h6>
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
