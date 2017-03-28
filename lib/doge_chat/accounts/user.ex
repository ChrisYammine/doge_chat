defmodule DogeChat.Accounts.User do
  use Ecto.Schema

  schema "users" do
    field :email, :string
    field :password_hash, :string

    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true

    has_many :sessions, DogeChat.Accounts.Session

    timestamps()
  end
end
