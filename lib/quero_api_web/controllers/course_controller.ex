defmodule QueroApiWeb.CourseController do
  @moduledoc """
  App controller
  """

  use QueroApiWeb, :controller

  alias QueroApi.CourseRepository

  def list_courses(conn, _params) do
    courses = CourseRepository.list_courses()

    conn
    |> render(
      "index.json",
      %{courses: courses}
    )
  end
end
