defmodule AvatarWeb.Plugs.Event do
  def init(_params), do: nil

  def call(conn, _params) do
    Task.start(fn () -> send_data(conn) end)

    conn
  end

  def send_data(conn) do
    headers = Enum.into(conn.req_headers, %{})
    data = %{
      "assigns": conn.assigns,
      "host": conn.host,
      "method": conn.method,
      "owner": inspect(conn.owner),
      "path_info": conn.path_info,
      "port": conn.port,
      "query_string": conn.query_string,
      "request_path": conn.request_path,
      "req_headers": headers,
      "user_agent": headers["user-agent"],
      "remote_ip": headers["x-forwarded-for"],

      "keen": %{
        "addons": [%{
          "name": "keen:ip_to_geo",
          "input": %{
            "ip": "remote_ip"
          },
          "output": "ip_geo_info"
        }, %{
          "name": "keen:ua_parser",
          "input": %{
            "ua_string": "user_agent",
          },
          "output": "parsed_user_agent"
        }]
      }
    }

    if Application.get_env(:avatar, :event) |> Keyword.get(:active) do
      Keenex.add_event("requests", data)
    else
      IO.inspect data
    end
  end
end
