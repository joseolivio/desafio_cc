defmodule DesafioWeb.ProjectController do
  use DesafioWeb, :controller

  # alias Desafio.Api
  # alias Desafio.Api.Project

  action_fallback DesafioWeb.FallbackController


  def index(conn, _params) do
    Desafio.extract_data()
    {_status,data} = Desafio.load_data_and_sort() |> Jason.encode()

    conn
    |> put_status(:ok)
    |> json(data)
  end

  def small_sample(conn, %{"quantity" => quantity}) do
    Desafio.extract_data(quantity)
    {_status,data} = Desafio.load_data_and_sort() |> Jason.encode()
    conn
    |> put_status(:ok)
    |> json(data)
  end

end
