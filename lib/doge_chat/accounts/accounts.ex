defmodule DogeChat.Accounts do
  @moduledoc """
  The boundary for the Accounts system.
  """

  import Ecto.{Query, Changeset}, warn: false
  import Comeonin.Bcrypt
  alias DogeChat.Repo
  alias DogeChat.Accounts.{User}

  def list_users do
    Repo.all(User)
  end

  def get_user!(id), do: Repo.get!(User, id)

  def create_user(attrs \\ %{}) do
    %User{}
    |> register_changeset(attrs)
    |> Repo.insert
  end

  def update_user(%User{} = user, attrs) do
    user
    |> user_changeset(attrs)
    |> Repo.update()
  end

  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  def change_user(%User{} = user) do
    user_changeset(user, %{})
  end

  defp user_changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:email])
    |> validate_required([:email])
    |> unique_constraint(:email)
  end

  defp register_changeset(%User{} = user, params) do
    user
    |> cast(params, [:email, :password])
    |> validate_required([:email, :password])
    |> unique_constraint(:email)
    |> validate_format(:email, ~r/.*@.*/)
    |> validate_confirmation(:password, message: "does not match Password", required: true)
    |> validate_length(:password, min: 8)
    |> add_password_hash
  end

  ##############################################
  # PASSWORD STUFF TODO: Put in its own module #
  ##############################################

  defp add_password_hash(%Ecto.Changeset{valid?: false} = chgset), do: chgset
  defp add_password_hash(chgset) do
    password = chgset.changes.password
    change(chgset, %{password_hash: hashpwsalt(password)})
  end
end
