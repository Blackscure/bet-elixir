defmodule ElixirBetWeb.DashboardLive do
  use ElixirBetWeb, :live_view

  def mount(_params, _session, socket) do
    user_count = fetch_user_count()
    match_count = fetch_match_count()
    league_count = fetch_league_count()

    {:ok, assign(socket, user_count: user_count, match_count: match_count, league_count: league_count)}
  end

  defp fetch_user_count() do
    count = ElixirBet.Repo.aggregate(ElixirBet.Accounts.User, :count, :id)
    count
  end

  defp fetch_match_count() do
    count = ElixirBet.Repo.aggregate(ElixirBet.Matches.Match, :count, :id)
    count
  end

  defp fetch_league_count() do
    count = ElixirBet.Repo.aggregate(ElixirBet.Leagues.League, :count, :id)
    count
  end

  

end
