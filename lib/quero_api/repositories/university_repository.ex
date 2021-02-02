defmodule QueroApi.UniversityRepository do
  @moduledoc """
  University repository
  """

  alias QueroApi.{Repo, University}

  def create_university(attrs \\ %{}) do
    %University{}
    |> University.changeset(attrs)
    |> Repo.insert()
  end
end
