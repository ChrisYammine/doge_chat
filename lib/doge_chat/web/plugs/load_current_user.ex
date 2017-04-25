defmodule DogeChat.Web.LoadCurrentUser do
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _) do
    with token when not is_nil(token) <- get_session(conn, :auth_token),
         session when not is_nil(session) <- DogeChat.Accounts.get_session(token) do
      conn
      |> assign(:current_user, session.user)
    else
      _ -> conn
    end
  end
end
