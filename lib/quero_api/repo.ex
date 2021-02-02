defmodule QueroApi.Repo do
  use Ecto.Repo,
    otp_app: :quero_api,
    adapter: Ecto.Adapters.Postgres
end
