defmodule QueroApiWeb.OfferView do
  @moduledoc """
  Offer view
  """

  use QueroApiWeb, :view

  alias QueroApiWeb.{CampusView, CourseView, OfferView, UniversityView}

  def render("index.json", %{offers: offers}) do
    render_many(offers, OfferView, "offer.json")
  end

  def render("offer.json", %{offer: offer}) do
    %{
      full_price: offer.full_price,
      price_with_discount: offer.price_with_discount,
      discount_percentage: offer.discount_percentage,
      start_date: offer.start_date,
      enrollment_semester: offer.enrollment_semester,
      enabled: offer.enabled,
      course: render_one(offer.course, CourseView, "course.json"),
      university: render_one(offer.course.campus.university, UniversityView, "university.json"),
      campus: render_one(offer.course.campus, CampusView, "campus.json")
    }
  end
end
