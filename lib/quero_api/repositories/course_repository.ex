defmodule QueroApi.CourseRepository do
  @moduledoc """
  Course repository
  """

  alias QueroApi.{Course, Repo}

  def create_course(attrs \\ %{}) do
    %Course{}
    |> Course.changeset(attrs)
    |> Repo.insert()
  end

  def list_courses do
    Repo.all(Course)
    |> Repo.preload([{:campus, :university}])
  end
end
