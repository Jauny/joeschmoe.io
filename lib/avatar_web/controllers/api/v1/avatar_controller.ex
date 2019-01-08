defmodule AvatarWeb.Api.V1.AvatarController do
  use AvatarWeb, :controller

  def random(conn, _params) do
    svg = Svg.random
    conn = conn
    |> put_resp_content_type("image/svg+xml")
    |> send_resp(200, svg)
  end
end
