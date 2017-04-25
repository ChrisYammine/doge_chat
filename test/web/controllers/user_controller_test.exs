defmodule DogeChat.Web.UserControllerTest do
  use DogeChat.Web.ConnCase
  use Plug.Test

  alias DogeChat.Accounts
  import DogeChat.Web.TestUtils

  @create_attrs %{email: "some@email.com", password: password(), password_confirmation: password()}
  @update_attrs %{email: "someupdated@email.com", password: password(), password_confirmation: password()}
  @invalid_attrs %{email: nil}

  def fixture(:user) do
    {:ok, user} = Accounts.create_user(@create_attrs)
    user |> Map.put(:password, nil)
  end

  def fixture(:session, user) do
    {:ok, session} = Accounts.create_session(%{email: user.email, password: password()})
    session
  end

  defp logged_in_conn do
    user = fixture(:user)
    session = fixture(:session, user)

    conn = build_conn() |> init_test_session(%{auth_token: session.token})
    {conn, user, session}
  end

  test "lists all entries on index", %{conn: conn} do
    {conn, _, _} = logged_in_conn()
    conn = get conn, user_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing Users"
  end

  test "renders form for new users", %{conn: conn} do
    conn = get conn, user_path(conn, :new)
    assert html_response(conn, 200) =~ "New User"
  end

  test "creates user and redirects to show when data is valid", %{conn: conn} do
    conn = post conn, user_path(conn, :create), user: @create_attrs
    assert redirected_to(conn) == session_path(conn, :new)

    conn = get conn, session_path(conn, :new)
    assert html_response(conn, 200) =~ "New Session"
  end

  test "does not create user and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, user_path(conn, :create), user: @invalid_attrs
    assert html_response(conn, 200) =~ "New User"
  end

  test "renders form for editing chosen user", %{conn: conn} do
    {conn, user, _} = logged_in_conn()
    conn = get conn, user_path(conn, :edit, user)
    assert html_response(conn, 200) =~ "Edit User"
  end

  test "updates chosen user and redirects when data is valid", %{conn: conn} do
    {conn, user, _} = logged_in_conn()
    conn = put conn, user_path(conn, :update, user), user: @update_attrs
    assert redirected_to(conn) == user_path(conn, :show, user)

    conn = get conn, user_path(conn, :show, user)
    assert html_response(conn, 200) =~ @update_attrs.email
  end

  test "does not update chosen user and renders errors when data is invalid", %{conn: conn} do
    {conn, user, _} = logged_in_conn()
    conn = put conn, user_path(conn, :update, user), user: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit User"
  end
end
