defmodule DogeChat.Web.SessionControllerTest do
  use DogeChat.Web.ConnCase

  alias DogeChat.Accounts

  @create_attrs %{token: "some token"}
  @update_attrs %{token: "some updated token"}
  @invalid_attrs %{token: nil}

  def fixture(:session) do
    {:ok, session} = Accounts.create_session(@create_attrs)
    session
  end

  test "renders form for new sessions", %{conn: conn} do
    conn = get conn, session_path(conn, :new)
    assert html_response(conn, 200) =~ "New Session"
  end

  test "creates session and redirects to show when data is valid", %{conn: conn} do
    conn = post conn, session_path(conn, :create), session: @create_attrs

    assert %{id: id} = redirected_params(conn)
    assert redirected_to(conn) == session_path(conn, :show, id)

    conn = get conn, session_path(conn, :show, id)
    assert html_response(conn, 200) =~ "Show Session"
  end

  test "does not create session and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, session_path(conn, :create), session: @invalid_attrs
    assert html_response(conn, 200) =~ "New Session"
  end

  test "deletes chosen session", %{conn: conn} do
    session = fixture(:session)
    conn = delete conn, session_path(conn, :delete, session)
    assert redirected_to(conn) == session_path(conn, :index)
    assert_error_sent 404, fn ->
      get conn, session_path(conn, :show, session)
    end
  end
end
