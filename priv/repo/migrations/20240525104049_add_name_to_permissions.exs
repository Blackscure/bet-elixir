defmodule ElixirBet.Repo.Migrations.AddNameToPermissions do
  use Ecto.Migration

  def change do
    alter table(:permissions) do
      add :name, :string
    end

    # Optionally, if you want to ensure that the name is unique, you can add a unique index
    create unique_index(:permissions, [:name])
  end
end
