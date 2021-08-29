defmodule FindMyPersonalWeb.PageController do
  use FindMyPersonalWeb, :controller

  alias FindMyPersonal.{Members, Teachers}

  def index(conn, _params) do
    members = Members.list_members()
    teachers = Teachers.list_teacher()

    conn
    |> assign(:members, members)
    |> assign(:teachers, teachers)
    |> render("index.html")
  end
end
