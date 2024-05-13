defmodule ElixirBetWeb.TeamLive do
  use ElixirBetWeb, :live_view

  alias ElixirBet.{Teams, Repo}

  def mount(_params, _session, socket) do
    teams = Teams.Team |> Repo.all()
    {:ok, assign(socket, teams: teams)}
  end

  def get_league_name(league_id) do
    case ElixirBet.Repo.get(ElixirBet.Leagues.League, league_id) do
      nil -> "Unknown League"
      league -> league.name
    end
  end

end
