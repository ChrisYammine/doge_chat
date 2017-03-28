defmodule DogeChat.Web.Router do
  use DogeChat.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :authenticated do
    plug DogeChat.Web.EnsureAuthenticated
  end

  pipeline :not_authenticated do
    plug DogeChat.Web.EnsureNotAuthenticated
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", DogeChat.Web do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/", DogeChat.Web do
    pipe_through [:browser, :authenticated]

    resources "/users", UserController, only: [:index, :show, :new, :create]
    resources "/sessions", SessionController, only: [:delete], singleton: true
  end

  scope "/", DogeChat.Web do
    pipe_through [:browser, :not_authenticated]

    resources "/sessions", SessionController, only: [:new, :create]
  end

  # Other scopes may use custom stacks.
  # scope "/api", DogeChat.Web do
  #   pipe_through :api
  # end
end
