defmodule MyApp.Repo.Migrations.UpdateRolesTable do
  use Ecto.Migration

  def change do
    alter table(:roles) do
      
      add :permission_id, references(:permissions, on_delete: :delete_all)
    end
  end
end
