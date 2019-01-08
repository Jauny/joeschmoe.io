defmodule AvatarWeb.PageController do
  use AvatarWeb, :controller

  def index(conn, _params) do
    svg = Svg.random
    render(conn, "index.html", svg: svg)
  end
end
