defmodule Avatar.Repo do
  use Ecto.Repo,
    otp_app: :avatar,
    adapter: Ecto.Adapters.Postgres
end
