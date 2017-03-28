defmodule DogeChat.Web.SessionController do
  use DogeChat.Web, :controller

  alias DogeChat.Accounts

  def new(conn, _params) do
    changeset = Accounts.change_session(%DogeChat.Accounts.Session{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"session" => session_params}) do
    case Accounts.create_session(session_params) do
      {:ok, session} ->
        conn
        |> put_session(:auth_token, session.token)
        |> put_flash(:info, "Logged in!")
        |> redirect(to: user_path(conn, :index))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def delete(conn, _) do
    token = get_session(conn, :auth_token)
    :ok = Accounts.delete_session(token)

    conn
    |> delete_session(:auth_token)
    |> put_flash(:info, "Logged out.")
    |> redirect(to: page_path(conn, :index))
  end
end
