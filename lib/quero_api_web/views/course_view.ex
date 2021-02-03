defmodule QueroApiWeb.CourseView do
  use QueroApiWeb, :view

  alias QueroApiWeb.{CampusView, CourseView, UniversityView}

  def render("index.json", %{courses: courses}) do
    render_many(courses, CourseView, "course.json")
  end

  def render("course.json", %{course: course}) do
    %{
      name: course.name,
      kind: course.kind,
      level: course.level,
      shift: course.shift,
      university: render_one(course.campus.university, UniversityView, "university.json"),
      campus: render_one(course.campus, CampusView, "campus.json")
    }
  end

  def render("only_course.json", %{course: course}) do
    %{
      name: course.name,
      kind: course.kind,
      level: course.level,
      shift: course.shift
    }
  end
end
