defmodule DogeChat.Web.EnsureAuthenticated do
  use Phoenix.Controller, namespace: DogeChat.Web
  import Plug.Conn
  alias DogeChat.Web.Router.Helpers, as: Routes

  def init(opts), do: opts

  # TODO: Cache sessions in ETS instead of hitting DB every page request
  def call(conn, _opts) do
    with token when not is_nil(token) <- get_session(conn, :auth_token),
         session when not is_nil(session) <- DogeChat.Accounts.get_session(token) do
      conn
      |> assign(:current_user, session.user)
    else
      _ ->
        conn
        |> put_flash(:info, "You need to be logged in to do that.")
        |> redirect(to: Routes.session_path(conn, :new))
        |> halt()
    end
  end
end
