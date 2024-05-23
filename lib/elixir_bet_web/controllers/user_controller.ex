defmodule ElixirBetWeb.UserController do
  use ElixirBetWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
