defmodule ElixirBet.Repo.Migrations.AddActionAndResourceToPermissionsTable do
  use Ecto.Migration

  def change do
    alter table(:permissions) do
      add :action, :string
      add :resource, :string
    end
  end
end
