defmodule AvatarWeb.Api.V1.AvatarController do
  use AvatarWeb, :controller

  def random_original(conn, _params) do
    svg = Svg.random_original
    conn = conn
    |> put_resp_content_type("image/svg+xml")
    |> send_resp(200, svg)
  end

  def random(conn, _params) do
    svg = Svg.random
    conn = conn
    |> put_resp_content_type("image/svg+xml")
    |> send_resp(200, svg)
  end

  def from_email_original(conn, %{"email" => email}) do
    svg = Svg.from_string(email)
    conn = conn
    |> put_resp_content_type("image/svg+xml")
    |> send_resp(200, svg)
  end

  def from_email(conn, %{"email" => email}) do
    opts_defaults = [
      gender: "males",
      base: "1",
      head: "1",
      eyes: "1",
      hair: "1",
      mouth: "1",
      nose: "1",
      collar: "1",
      sweater: "1"
    ]
    email_index = email |> to_charlist |> Enum.reduce(fn el, acc -> el + acc end)
    opts = Enum.flat_map_reduce(opts_defaults, email_index, fn {k, v}, acc ->
      case k do
        :gender -> {Keyword.put([], k, "males"), acc}
        _ ->
        mod = Integer.mod(acc, 2)
        {Keyword.put([], k, "1"), div(acc, 2)}
      end
    end) |> elem(0)

    svg = Svg.build(opts)
    conn = conn
    |> put_resp_content_type("image/svg+xml")
    |> send_resp(200, svg)
  end
end
