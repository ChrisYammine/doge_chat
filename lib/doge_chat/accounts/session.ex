defmodule DogeChat.Accounts.Session do
  use Ecto.Schema

  schema "sessions" do
    field :token, :string
    belongs_to :user, DogeChat.Accounts.User

    field :email, :string, virtual: true
    field :password, :string, virtual: true

    timestamps()
  end
end
