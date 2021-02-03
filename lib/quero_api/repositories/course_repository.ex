defmodule QueroApi.CourseRepository do
  @moduledoc """
  Course repository
  """
  import Ecto.Query

  alias QueroApi.{Course, Repo}

  @doc """
  Create a course
  """
  def create_course(attrs \\ %{}) do
    %Course{}
    |> Course.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Returns the list of courses
  """
  def list_courses(filters \\ nil) do
    from(c in Course)
    |> filter(filters)
    |> Repo.all()
    |> Repo.preload([{:campus, :university}])
  end

  defp filter(query, filters) do
    Enum.reduce(filters, query, fn {key, value}, query ->
      case key do
        "kind" ->
          where(query, [v], v.kind == ^value)

        "level" ->
          where(query, [v], v.level == ^value)

        "shift" ->
          where(query, [v], v.shift == ^value)

        "university" ->
          from(q in query,
            join: campus in assoc(q, :campus),
            join: university in assoc(campus, :university),
            on: university.name == ^value
          )

        _ ->
          query
      end
    end)
  end
end
