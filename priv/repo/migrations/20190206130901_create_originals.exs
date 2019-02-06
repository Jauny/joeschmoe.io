defmodule Avatar.Repo.Migrations.CreateOriginals do
  use Ecto.Migration

  def change do
    create table(:originals) do
      add :name, :string
      add :gender, :string
      add :svg, :text

      timestamps()
    end

  end
end
