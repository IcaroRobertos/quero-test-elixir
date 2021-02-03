defmodule QueroApiWeb.OfferController do
  use QueroApiWeb, :controller

  alias QueroApi.OfferRepository

  def list_offers(conn, _params) do
    offers = OfferRepository.list_offers()

    [head | _tail] = offers

    IO.inspect(head)

    conn
    |> render("index.json", %{offers: offers})
  end
end
