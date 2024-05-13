defmodule ElixirBetWeb.MatchLive do
  use ElixirBetWeb, :live_view

  def mount(_params, _session, socket) do
    matches = ElixirBet.Repo.all(ElixirBet.Matches.Match)
    {:ok, assign(socket, matches: matches)}
  end
end
