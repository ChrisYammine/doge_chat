defmodule DogeChat.Web.CheckAuth do
  use Phoenix.Controller, namespace: DogeChat.Web
  import Plug.Conn
  alias DogeChat.Web.Router.Helpers, as: Routes
  alias DogeChat.Accounts.User

  def init(opts), do: opts

  def call(conn, :authenticated) do
    case conn.assigns[:current_user] do
      %User{} ->
        conn
      _ ->
        conn
        |> put_flash(:info, "You need to be logged in to do that.")
        |> redirect(to: Routes.session_path(conn, :new))
        |> halt()
    end
  end

  def call(conn, :not_authenticated) do
    case conn.assigns[:current_user] do
      nil ->
        conn
      _ ->
        conn
        |> put_flash(:info, "You are already logged in!")
        |> redirect(to: Routes.page_path(conn, :index))
        |> halt()
    end
  end
end
