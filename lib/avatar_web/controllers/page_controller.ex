defmodule AvatarWeb.PageController do
  use AvatarWeb, :controller

  alias AvatarWeb.PageView
  alias Phoenix.LiveView

  def index(conn, _) do
    all_originals = PageView.all_originals() |> Enum.shuffle

    LiveView.Controller.live_render(conn, AvatarWeb.IndexLive, session: %{
      all_originals: all_originals
    })
  end
end
