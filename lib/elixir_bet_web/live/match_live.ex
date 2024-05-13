defmodule ElixirBetWeb.MatchLive do
  use ElixirBetWeb, :live_view

  alias ElixirBet.{Teams, Repo}

  def mount(_params, _session, socket) do
    matches = ElixirBet.Repo.all(ElixirBet.Matches.Match)
    {:ok, assign(socket, matches: matches)}
  end

  def get_home_team(home_team_id) do
    case Repo.get(Teams.Team, home_team_id) do
      nil -> "Unknown team"
      team -> team.name
    end
  end

  def get_away_team(away_team_id) do
    case Repo.get(Teams.Team, away_team_id) do
      nil -> "Unknown team"
      team -> team.name
    end
  end
end
