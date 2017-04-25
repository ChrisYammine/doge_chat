defmodule DogeChat.Web.PageController do
  use DogeChat.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def show(conn, _params) do
    token = Phoenix.Token.sign(conn, "my_temporary_salt", conn.assigns.current_user.id)
    render conn, "show.html", token: token
  end
end
