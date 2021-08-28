defmodule FindMyPersonalWeb.TeacherControllerTest do
  use FindMyPersonalWeb.ConnCase

  alias FindMyPersonal.Teachers

  @create_attrs %{
    avatar_url: "some avatar_url",
    birth_date: ~D[2010-04-17],
    class_type: "some class_type",
    education_level: "some education_level",
    name: "some name"
  }
  @update_attrs %{
    avatar_url: "some updated avatar_url",
    birth_date: ~D[2011-05-18],
    class_type: "some updated class_type",
    education_level: "some updated education_level",
    name: "some updated name"
  }
  @invalid_attrs %{
    avatar_url: nil,
    birth_date: nil,
    class_type: nil,
    education_level: nil,
    name: nil
  }

  def fixture(:teacher) do
    {:ok, teacher} = Teachers.create_teacher(@create_attrs)
    teacher
  end

  describe "index" do
    setup [:create_teacher]

    test "lists all teacher", %{conn: conn} do
      conn = get(conn, Routes.teacher_path(conn, :index))
      assert html_response(conn, 200) =~ "Teacher List"
      assert html_response(conn, 200) =~ "some name"
    end
  end

  describe "show" do
    setup [:create_teacher]

    test "show teacher", %{conn: conn, teacher: teacher} do
      conn = get(conn, Routes.teacher_path(conn, :show, teacher))

      assert html_response(conn, 200) =~ "Teacher #{teacher.name}"
    end
  end

  describe "new" do
    test "an empty form", %{conn: conn} do
      conn = get(conn, Routes.teacher_path(conn, :new))

      assert html_response(conn, 200) =~ "Create a teacher"

      assert html_response(conn, 200) =~ "<button class=\"\" type=\"submit\">Create</button>"

      assert html_response(conn, 200) =~
               "<input id=\"name\" name=\"teacher[name]\" type=\"text\">"
    end
  end

  describe "create" do
    test "create teacher with invalid data", %{conn: conn} do
      conn = post(conn, Routes.teacher_path(conn, :create), teacher: @invalid_attrs)

      assert html_response(conn, 200) =~ "Create a teacher"

      assert html_response(conn, 200) =~
               "Ops, something went wrong! Please check the  errors below."

      assert html_response(conn, 200) =~
               "<span class=\"invalid-feedback\" phx-feedback-for=\"teacher[name]\">can&#39;t be blank</span>"
    end

    test "create teacher with valid data", %{conn: conn} do
      conn = post(conn, Routes.teacher_path(conn, :create), teacher: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.teacher_path(conn, :show, id)

      conn = get(conn, Routes.teacher_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Teacher #{@create_attrs[:name]}"
    end
  end

  describe "edit" do
    setup [:create_teacher]

    test "load form with data teacher", %{conn: conn, teacher: teacher} do
      conn = get(conn, Routes.teacher_path(conn, :edit, teacher))

      assert html_response(conn, 200) =~ "Edit Teacher"

      assert html_response(conn, 200) =~
               "<input id=\"name\" name=\"teacher[name]\" type=\"text\" value=\"#{teacher.name}\">"

      assert html_response(conn, 200) =~ "<button class=\"\" type=\"submit\">Update</button>"
    end
  end

  describe "update" do
    setup [:create_teacher]

    test "update teacher with invalid data", %{conn: conn, teacher: teacher} do
      conn = put(conn, Routes.teacher_path(conn, :update, teacher), teacher: @invalid_attrs)

      assert html_response(conn, 200) =~ "Edit Teacher"

      assert html_response(conn, 200) =~
               "Ops, something went wrong! Please check the  errors below."

      assert html_response(conn, 200) =~
               "<span class=\"invalid-feedback\" phx-feedback-for=\"teacher[name]\">can&#39;t be blank</span>"
    end

    test "update teacher with valid data", %{conn: conn, teacher: teacher} do
      conn = put(conn, Routes.teacher_path(conn, :update, teacher), teacher: @update_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.teacher_path(conn, :show, id)

      conn = get(conn, Routes.teacher_path(conn, :index))
      assert html_response(conn, 200) =~ "Teacher #{@update_attrs.name} updated"
    end
  end

  describe "delete teacher" do
    setup [:create_teacher]

    test "deletes chosen teacher", %{conn: conn, teacher: teacher} do
      conn = delete(conn, Routes.teacher_path(conn, :delete, teacher))

      assert redirected_to(conn) == Routes.teacher_path(conn, :index)

      conn = get(conn, Routes.teacher_path(conn, :index))
      assert html_response(conn, 200) =~ "Teacher #{teacher.name} deleted"
    end
  end

  defp create_teacher(_) do
    teacher = fixture(:teacher)
    %{teacher: teacher}
  end
end
