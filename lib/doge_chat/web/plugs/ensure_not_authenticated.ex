defmodule DogeChat.Web.EnsureNotAuthenticated do
  use Phoenix.Controller, namespace: DogeChat.Web
  import Plug.Conn
  alias DogeChat.Web.Router.Helpers, as: Routes

  def init(opts), do: opts

  def call(conn, _opts) do
    case get_session(conn, :auth_token) do
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
