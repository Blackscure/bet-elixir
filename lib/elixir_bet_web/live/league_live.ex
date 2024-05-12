defmodule ElixirBetWeb.LeagueLive do
  use ElixirBetWeb, :live_view

    def mount(_params, _session, socket) do
    leagues = ElixirBet.Leagues.League |> ElixirBet.Repo.all()
    {:ok, assign(socket, leagues: leagues)}
  end
end
