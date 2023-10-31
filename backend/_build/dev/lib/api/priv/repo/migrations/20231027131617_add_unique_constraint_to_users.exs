defmodule Api.Repo.Migrations.AddUniqueConstraintToUsers do
  use Ecto.Migration

  def up do
    execute("CREATE UNIQUE INDEX IF NOT EXISTS users_email_index ON users(email)")
  end

  def down do
    execute("DROP INDEX IF EXISTS users_email_index")
  end
end
