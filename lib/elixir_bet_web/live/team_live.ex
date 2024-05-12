defmodule ElixirBetWeb.TeamLive do
  use ElixirBetWeb, :live_view

  alias ElixirBet.Teams

  def mount(_params, _session, socket) do
    teams = ElixirBet.Teams.Team |> ElixirBet.Repo.all()
    {:ok, assign(socket, teams: teams)}
  end



end
