defmodule AvatarWeb.PageController do
  use AvatarWeb, :controller

  alias AvatarWeb.PageView
  alias Phoenix.LiveView

  def index(conn, _) do
    all_originals = PageView.all_originals() |> Enum.shuffle
    render(conn, "index.html", all_originals: all_originals, val: "random")
  end
end
