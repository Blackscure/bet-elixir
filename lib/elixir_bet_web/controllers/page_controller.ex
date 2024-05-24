defmodule ElixirBetWeb.PageController do
  use ElixirBetWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    IO.inspect(conn)
    render(conn, :home)
  end
end
