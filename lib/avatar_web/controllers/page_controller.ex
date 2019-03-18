defmodule AvatarWeb.PageController do
  use AvatarWeb, :controller

  alias Phoenix.LiveView

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def test_live(conn, _) do
    LiveView.Controller.live_render(conn, AvatarWeb.TestLive, session: %{})
  end
end
