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
  end

  # Other scopes may use custom stacks.
  scope "/api", AvatarWeb.Api, as: :api do
    scope "/v1", V1, as: :v1 do
      pipe_through :api

      get "/random:filetype", AvatarController, :random_original
      get "/:gender/random:filetype", AvatarController, :random_gender
      get "/:email", AvatarController, :from_email_original
    end
  end
end
