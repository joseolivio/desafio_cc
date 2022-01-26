defmodule Desafio.Api.Project do
  use Ecto.Schema
  import Ecto.Changeset

  schema "projects" do
    field :number, :float

    timestamps()
  end

  @doc false
  def changeset(project, attrs) do
    project
    |> cast(attrs, [:number])
    |> validate_required([:number])
  end
end
