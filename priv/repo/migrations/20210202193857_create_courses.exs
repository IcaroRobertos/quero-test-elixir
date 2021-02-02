defmodule QueroApi.Repo.Migrations.CreateCourses do
  @moduledoc """
  Migration to create courses table
  """
  use Ecto.Migration

  def change do
    create table(:courses) do
      add :campus_id, :integer
      add :name, :string
      add :kind, :string
      add :level, :string
      add :shift, :string

      timestamps()
    end

  end
end
