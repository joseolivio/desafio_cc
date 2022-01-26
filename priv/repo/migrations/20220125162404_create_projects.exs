defmodule Desafio.Repo.Migrations.CreateProjects do
  use Ecto.Migration

  def change do
    create table(:projects) do
      add :number, :float

      timestamps()
    end
  end
end
