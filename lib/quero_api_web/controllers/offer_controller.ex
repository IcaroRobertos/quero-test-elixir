defmodule QueroApiWeb.OfferController do
  @moduledoc """
  Course controller
  """

  use QueroApiWeb, :controller

  alias QueroApi.OfferRepository

  def list_offers(conn, params) do
    offers = OfferRepository.list_offers(params)

    conn
    |> render("index.json", %{offers: offers})
  end
end
