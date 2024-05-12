defmodule ElixirBet.Repo do
  use Ecto.Repo,
    otp_app: :elixir_bet,
    adapter: Ecto.Adapters.Postgres
end
