defmodule QueroApiWeb.CampusView do
  @moduledoc """
  Campus view
  """

  use QueroApiWeb, :view

  def render("campus.json", %{campus: campus}) do
    %{
      name: campus.name,
      city: campus.city
    }
  end
end
