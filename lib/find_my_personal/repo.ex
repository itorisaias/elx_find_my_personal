defmodule FindMyPersonal.Repo do
  use Ecto.Repo,
    otp_app: :find_my_personal,
    adapter: Ecto.Adapters.Postgres
end
