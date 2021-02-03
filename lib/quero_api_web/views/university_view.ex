defmodule QueroApiWeb.UniversityView do
  @moduledoc """
  University view
  """

  use QueroApiWeb, :view

  def render("university.json", %{university: university}) do
    %{
      name: university.name,
      score: university.score,
      logo_url: university.logo_url
    }
  end
end
