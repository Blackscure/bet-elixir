defmodule ElixirBetWeb.MatchLive do
  use ElixirBetWeb, :live_view

  alias ElixirBet.Repo
  alias ElixirBet.Matches.Match
  alias ElixirBet.Teams.Team

  def mount(_params, _session, socket) do
    matches = all_matches()
    {:ok, assign(socket, matches: matches)}
  end

  def all_matches do
    Repo.all(Match)
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
