defmodule FindMyPersonalWeb.TeacherController do
  use FindMyPersonalWeb, :controller

  alias FindMyPersonal.Teachers
  alias FindMyPersonal.Teachers.Teacher

  def index(conn, _params) do
    teachers = Teachers.list_teacher()
    render(conn, "index.html", teachers: teachers)
  end

  def show(conn, %{"id" => id}) do
    teacher = Teachers.get_teacher!(id)
    render(conn, "show.html", teacher: teacher)
  end

  def new(conn, _params) do
    changeset = Teachers.change_teacher(%Teacher{})

    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"teacher" => teacher_params}) do
    case Teachers.create_teacher(teacher_params) do
      {:ok, teacher} ->
        conn
        |> put_flash(:info, "Teacher #{teacher.name} created")
        |> redirect(to: Routes.teacher_path(conn, :show, teacher))

      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def edit(conn, %{"id" => id}) do
    teacher = Teachers.get_teacher!(id)
    changeset = Teachers.change_teacher(teacher)

    render(conn, "edit.html", teacher: teacher, changeset: changeset)
  end

  def update(conn, %{"id" => id, "teacher" => teacher_params}) do
    teacher = Teachers.get_teacher!(id)

    case Teachers.update_teacher(teacher, teacher_params) do
      {:ok, teacher} ->
        conn
        |> put_flash(:info, "Teacher #{teacher.name} updated")
        |> redirect(to: Routes.teacher_path(conn, :show, teacher))

      {:error, changeset} ->
        render(conn, "edit.html", teacher: teacher, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    teacher = Teachers.get_teacher!(id)

    with {:ok, %Teacher{}} <- Teachers.delete_teacher(teacher) do
      conn
      |> put_flash(:info, "Teacher #{teacher.name} deleted")
      |> redirect(to: Routes.teacher_path(conn, :index))
    end
  end
end
