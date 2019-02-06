defmodule AvatarWeb.PageControllerTest do
  use AvatarWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "An illustrated avatar collection for developers and designers"
  end
end
