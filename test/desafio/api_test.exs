defmodule Desafio.ApiTest do
  use Desafio.DataCase

  alias Desafio.Api

  describe "projects" do
    alias Desafio.Api.Project

    import Desafio.ApiFixtures

    @invalid_attrs %{number: nil}

    test "list_projects/0 returns all projects" do
      project = project_fixture()
      assert Api.list_projects() == [project]
    end

    test "get_project!/1 returns the project with given id" do
      project = project_fixture()
      assert Api.get_project!(project.id) == project
    end

    test "create_project/1 with valid data creates a project" do
      valid_attrs = %{number: 120.5}

      assert {:ok, %Project{} = project} = Api.create_project(valid_attrs)
      assert project.number == 120.5
    end

    test "create_project/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Api.create_project(@invalid_attrs)
    end

    test "update_project/2 with valid data updates the project" do
      project = project_fixture()
      update_attrs = %{number: 456.7}

      assert {:ok, %Project{} = project} = Api.update_project(project, update_attrs)
      assert project.number == 456.7
    end

    test "update_project/2 with invalid data returns error changeset" do
      project = project_fixture()
      assert {:error, %Ecto.Changeset{}} = Api.update_project(project, @invalid_attrs)
      assert project == Api.get_project!(project.id)
    end

    test "delete_project/1 deletes the project" do
      project = project_fixture()
      assert {:ok, %Project{}} = Api.delete_project(project)
      assert_raise Ecto.NoResultsError, fn -> Api.get_project!(project.id) end
    end

    test "change_project/1 returns a project changeset" do
      project = project_fixture()
      assert %Ecto.Changeset{} = Api.change_project(project)
    end
  end
end
