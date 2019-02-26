defmodule AvatarWeb.AvatarControllerTest do
  use AvatarWeb.ConnCase
  alias Avatar.Original

  test "random_original/2 responds with a random avatar", %{conn: conn} do
    originals = [%{gender: "female", name: "Jess", svg: "<>"},
                 %{gender: "male", name: "Jon", svg: "<>"}]
    Enum.map(originals, &Original.create(&1))

    conn = get(conn, "/api/v1/random")
    headers = Enum.into(conn.resp_headers, %{})
    assert headers["content-type"] =~ "image/svg+xml"
    assert conn.resp_body == "<>"
  end

  describe "random_gender/2" do
    setup [:create_originals]

    test "Returns a female when a female is asked for", %{conn: conn} do
      conn = get(conn, "/api/v1/female/random")
      assert conn.resp_body =~ "female"
    end

    test "Returns a male when a male is asked for", %{conn: conn} do
      conn = get(conn, "/api/v1/male/random")
      assert conn.resp_body =~ "male"
    end
  end

  describe "name_gender/2" do
    setup [:create_originals]

    test "Returns a female from its name", %{conn: conn} do
      conn = get(conn, "/api/v1/female/jess")
      assert conn.resp_body =~ "jess"
    end

    test "Returns a male from its name", %{conn: conn} do
      conn = get(conn, "/api/v1/male/jon")
      assert conn.resp_body =~ "jon"
    end
  end

  describe "from_email_original/2" do
    setup [:create_originals]

    test "Returns a specific original when name is known", %{conn: conn} do
      conn = get(conn, "/api/v1/jess")
      assert conn.resp_body =~ "jess"

      conn = get(conn, "/api/v1/jo")
      assert conn.resp_body =~ "jo"
    end

    test "Returns a constant random original when name is new", %{conn: conn} do
      conn = get(conn, "/api/v1/test@example.com")
      headers = Enum.into(conn.resp_headers, %{})
      assert headers["content-type"] =~ "image/svg+xml"
    end
  end

  defp create_originals(_) do
    originals = [%{gender: "female", name: "jess", svg: "<female,jess>"},
                 %{gender: "female", name: "janne", svg: "<female,janne>"},
                 %{gender: "male", name: "jo", svg: "<male,jo>"},
                 %{gender: "male", name: "jon", svg: "<male,jon>"}]
    Enum.map(originals, &Original.create(&1))
  end
end
