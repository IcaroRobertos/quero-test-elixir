defmodule QueroApiWeb.CourseController do
  @moduledoc """
  App controller
  """

  use QueroApiWeb, :controller

  alias QueroApi.CourseRepository

  def list_courses(conn, params) do
    IO.inspect(params)
    courses = CourseRepository.list_courses(params)

    conn
    |> render(
      "index.json",
      %{courses: courses}
    )
  end
end
