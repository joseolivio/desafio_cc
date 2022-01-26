defmodule Desafio.ApiFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Desafio.Api` context.
  """

  @doc """
  Generate a project.
  """
  def project_fixture(attrs \\ %{}) do
    {:ok, project} =
      attrs
      |> Enum.into(%{
        number: 120.5
      })
      |> Desafio.Api.create_project()

    project
  end
end
