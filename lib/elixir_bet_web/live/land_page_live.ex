defmodule ElixirBetWeb.LandPageLive do
    use ElixirBetWeb, :live_view
    alias ElixirBet.Matches.Match
    alias ElixirBetWeb.MatchLive
    alias ElixirBet.Teams.Team
    alias ElixirBet.Repo

    def mount(_params, _session, socket) do
        {:ok, assign(socket, matches: MatchLive.all_matches())}
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



end
