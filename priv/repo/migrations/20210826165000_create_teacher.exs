defmodule FindMyPersonal.Repo.Migrations.CreateTeacher do
  use Ecto.Migration

  def change do
    create table(:teacher) do
      add :avatar_url, :string
      add :name, :string
      add :birth_date, :date
      add :education_level, :string
      add :class_type, :string

      timestamps()
    end
  end
end
