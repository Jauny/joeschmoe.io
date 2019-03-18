defmodule AvatarWeb.PageController do
  use AvatarWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
