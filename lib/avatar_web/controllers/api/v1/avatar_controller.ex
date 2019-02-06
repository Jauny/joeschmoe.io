defmodule AvatarWeb.Api.V1.AvatarController do
  use AvatarWeb, :controller

  require Ecto.Query

  alias Avatar.Repo
  alias Avatar.Original

  def random_original(conn, _params) do
    original = Original 
                      |> Repo.all 
                      |> Enum.random
    conn = conn
    |> put_resp_content_type("image/svg+xml")
    |> send_resp(200, original.svg)
  end

  def random_gender(conn, %{"gender" => gender}) do
    original = Original
                      |> Ecto.Query.where(gender: ^gender)
                      |> Repo.all 
                      |> Enum.random
    conn = conn
    |> put_resp_content_type("image/svg+xml")
    |> send_resp(200, original.svg)
  end

  def from_email_original(conn, %{"email" => email}) do
    original =
      case Original.get_by_name(email) do
        nil -> Original.get_from_string(email)
        res -> res
      end

    conn = conn
    |> put_resp_content_type("image/svg+xml")
    |> send_resp(200, original.svg)
  end
end
