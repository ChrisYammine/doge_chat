defmodule DogeChat.Repo.Migrations.CreateDogeChat.Accounts.Session do
  use Ecto.Migration

  def change do
    create table(:sessions) do
      add :token, :string
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:sessions, [:token])
    create index(:sessions, [:user_id])
  end
end
