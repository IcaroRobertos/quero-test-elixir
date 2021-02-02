defmodule QueroApi.CampusRepository do
  @moduledoc """
  Campus repository
  """

  alias QueroApi.{Campus, Repo}

  def create_campus(attrs \\ %{}) do
    %Campus{}
    |> Campus.changeset(attrs)
    |> Repo.insert()
  end
end
