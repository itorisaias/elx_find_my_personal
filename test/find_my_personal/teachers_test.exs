defmodule FindMyPersonal.TeachersTest do
  use FindMyPersonal.DataCase

  alias FindMyPersonal.Teachers

  describe "teacher" do
    alias FindMyPersonal.Teachers.Teacher

    @valid_attrs %{
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

    def teacher_fixture(attrs \\ %{}) do
      {:ok, teacher} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Teachers.create_teacher()

      teacher
    end

    test "list_teacher/0 returns all teacher" do
      teacher = teacher_fixture()
      assert Teachers.list_teacher() == [teacher]
    end

    test "get_teacher!/1 returns the teacher with given id" do
      teacher = teacher_fixture()
      assert Teachers.get_teacher!(teacher.id) == teacher
    end

    test "create_teacher/1 with valid data creates a teacher" do
      assert {:ok, %Teacher{} = teacher} = Teachers.create_teacher(@valid_attrs)
      assert teacher.avatar_url == "some avatar_url"
      assert teacher.birth_date == ~D[2010-04-17]
      assert teacher.class_type == "some class_type"
      assert teacher.education_level == "some education_level"
      assert teacher.name == "some name"
    end

    test "create_teacher/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Teachers.create_teacher(@invalid_attrs)
    end

    test "update_teacher/2 with valid data updates the teacher" do
      teacher = teacher_fixture()
      assert {:ok, %Teacher{} = teacher} = Teachers.update_teacher(teacher, @update_attrs)
      assert teacher.avatar_url == "some updated avatar_url"
      assert teacher.birth_date == ~D[2011-05-18]
      assert teacher.class_type == "some updated class_type"
      assert teacher.education_level == "some updated education_level"
      assert teacher.name == "some updated name"
    end

    test "update_teacher/2 with invalid data returns error changeset" do
      teacher = teacher_fixture()
      assert {:error, %Ecto.Changeset{}} = Teachers.update_teacher(teacher, @invalid_attrs)
      assert teacher == Teachers.get_teacher!(teacher.id)
    end

    test "delete_teacher/1 deletes the teacher" do
      teacher = teacher_fixture()
      assert {:ok, %Teacher{}} = Teachers.delete_teacher(teacher)
      assert_raise Ecto.NoResultsError, fn -> Teachers.get_teacher!(teacher.id) end
    end

    test "change_teacher/1 returns a teacher changeset" do
      teacher = teacher_fixture()
      assert %Ecto.Changeset{} = Teachers.change_teacher(teacher)
    end
  end
end
