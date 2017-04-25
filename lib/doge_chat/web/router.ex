defmodule DogeChat.Web.Router do
  use DogeChat.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug DogeChat.Web.LoadCurrentUser
  end

  pipeline :authenticated do
    plug DogeChat.Web.CheckAuth, :authenticated
  end

  pipeline :not_authenticated do
    plug DogeChat.Web.CheckAuth, :not_authenticated
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", DogeChat.Web do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/", DogeChat.Web do
    pipe_through [:browser, :not_authenticated]

    get "/signup", UserController, :new
    resources "/users", UserController, only: [:create]
    get "/login", SessionController, :new
    resources "/sessions", SessionController, only: [:create]
  end

  scope "/", DogeChat.Web do
    pipe_through [:browser, :authenticated]

    get "/chat", PageController, :show

    resources "/users", UserController, only: [:index, :show, :edit, :update] # Edit & Update not used yet
    delete "/logout", SessionController, :delete
  end
end
