defmodule AvatarWeb.Router do
  use AvatarWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", AvatarWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/hello", HelloController, :index
    get "/hello/:messenger", HelloController, :show
  end

  # Other scopes may use custom stacks.
  scope "/api", AvatarWeb.Api, as: :api do
    scope "/v1", V1, as: :v1 do
      pipe_through :api

      get "/random", AvatarController, :random
    end
  end
end
