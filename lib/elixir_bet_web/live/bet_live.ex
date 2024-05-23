defmodule ElixirBetWeb.BetLive do
  use ElixirBetWeb, :live_view

  alias ElixirBet.Repo
  alias ElixirBet.Bets.Bet
  alias ElixirBet.Teams.Team
  alias ElixirBet.Accounts.User
  alias ElixirBet.Matches.Match


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

end
