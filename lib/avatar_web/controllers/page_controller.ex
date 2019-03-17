defmodule AvatarWeb.PageController do
  use AvatarWeb, :controller

  alias Phoenix.LiveView

  def index(conn, _) do
    LiveView.Controller.live_render(conn, AvatarWeb.IndexLive, session: %{})
  end
end
