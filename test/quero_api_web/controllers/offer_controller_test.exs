defmodule QueroApiWeb.OfferControllerTest do
  @moduledoc """
  Offer controller test
  """

  use QueroApiWeb.ConnCase, async: true

  describe "get offers test" do
    test "get offers", %{conn: conn} do
      request = get(conn, "/api/offers")
      response = json_response(request, 200)

      IO.inspect(response)
    end
  end
end
