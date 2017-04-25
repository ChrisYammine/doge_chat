defmodule DogeChat.Web.SessionControllerTest do
  use DogeChat.Web.ConnCase
  use Plug.Test

  alias DogeChat.Accounts
  alias DogeChat.Web.UserControllerTest
  import DogeChat.Web.TestUtils

  @invalid_attrs %{email: "some@token.com", password: password()}

  def fixture(:session) do
    user = UserControllerTest.fixture(:user)
    {:ok, session} = Accounts.create_session(%{email: user.email, password: password()})
    session
  end

  defp logged_in_conn do
    session = fixture(:session)
    build_conn() |> init_test_session(%{auth_token: session.token})
  end

  test "renders form for new sessions", %{conn: conn} do
    conn = get conn, session_path(conn, :new)
    assert html_response(conn, 200) =~ "New Session"
  end

  test "creates session and redirects to show when data is valid", %{conn: conn} do
    user = UserControllerTest.fixture(:user)
    conn = post conn, session_path(conn, :create), session: %{email: user.email, password: password()}

    assert redirected_to(conn) == user_path(conn, :index)
  end

  test "does not create session and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, session_path(conn, :create), session: @invalid_attrs
    assert html_response(conn, 200) =~ "New Session"
  end

  test "deletes chosen session", %{conn: conn} do
    conn = logged_in_conn()
    conn = delete conn, session_path(conn, :delete)
    assert redirected_to(conn) == page_path(conn, :index)
  end
end
