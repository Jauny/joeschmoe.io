defmodule AvatarWeb.Router do
  use AvatarWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug AvatarWeb.Plugs.Event
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug :jon_jess
    plug AvatarWeb.Plugs.Event
  end

  scope "/", AvatarWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api", AvatarWeb.Api, as: :api do
    scope "/v1", V1, as: :v1 do
      pipe_through :api

      get "/random", AvatarController, :random_original
      get "/:gender/random", AvatarController, :random_gender
      get "/:email", AvatarController, :from_email_original
    end

    scope "/local", V1 do
      get "/random", AvatarController, :random_original
      get "/:gender/random", AvatarController, :random_gender
      get "/:email", AvatarController, :from_email_original
    end
  end

  def jon_jess(conn, _opts) do
    conn |> put_resp_header("hire-us", "jonandjess.studio")
  end
end
