defmodule FindMyPersonalWeb.TeacherView do
  use FindMyPersonalWeb, :view
  alias FindMyPersonalWeb.TeacherView

  def render("index.json", %{teacher: teacher}) do
    %{data: render_many(teacher, TeacherView, "teacher.json")}
  end

  def render("show.json", %{teacher: teacher}) do
    %{data: render_one(teacher, TeacherView, "teacher.json")}
  end

  def render("teacher.json", %{teacher: teacher}) do
    %{
      id: teacher.id,
      avatar_url: teacher.avatar_url,
      name: teacher.name,
      birth_date: teacher.birth_date,
      education_level: teacher.education_level,
      class_type: teacher.class_type
    }
  end
end
