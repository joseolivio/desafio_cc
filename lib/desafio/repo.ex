defmodule Desafio.Repo do
  use Ecto.Repo,
    otp_app: :desafio,
    adapter: Ecto.Adapters.Postgres
end
