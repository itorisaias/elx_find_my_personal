defmodule FindMyPersonalWeb.TeacherControllerTest do
  use FindMyPersonalWeb.ConnCase

  alias FindMyPersonal.Teachers
  alias FindMyPersonal.Teachers.Teacher

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
  @invalid_attrs %{avatar_url: nil, birth_date: nil, class_type: nil, education_level: nil, name: nil}

  def fixture(:teacher) do
    {:ok, teacher} = Teachers.create_teacher(@create_attrs)
    teacher
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all teacher", %{conn: conn} do
      conn = get(conn, Routes.teacher_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create teacher" do
    test "renders teacher when data is valid", %{conn: conn} do
      conn = post(conn, Routes.teacher_path(conn, :create), teacher: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.teacher_path(conn, :show, id))

      assert %{
               "id" => id,
               "avatar_url" => "some avatar_url",
               "birth_date" => "2010-04-17",
               "class_type" => "some class_type",
               "education_level" => "some education_level",
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.teacher_path(conn, :create), teacher: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update teacher" do
    setup [:create_teacher]

    test "renders teacher when data is valid", %{conn: conn, teacher: %Teacher{id: id} = teacher} do
      conn = put(conn, Routes.teacher_path(conn, :update, teacher), teacher: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.teacher_path(conn, :show, id))

      assert %{
               "id" => id,
               "avatar_url" => "some updated avatar_url",
               "birth_date" => "2011-05-18",
               "class_type" => "some updated class_type",
               "education_level" => "some updated education_level",
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, teacher: teacher} do
      conn = put(conn, Routes.teacher_path(conn, :update, teacher), teacher: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete teacher" do
    setup [:create_teacher]

    test "deletes chosen teacher", %{conn: conn, teacher: teacher} do
      conn = delete(conn, Routes.teacher_path(conn, :delete, teacher))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.teacher_path(conn, :show, teacher))
      end
    end
  end

  defp create_teacher(_) do
    teacher = fixture(:teacher)
    %{teacher: teacher}
  end
end
