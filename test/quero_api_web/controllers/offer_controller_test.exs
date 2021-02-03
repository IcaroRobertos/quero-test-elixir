defmodule QueroApiWeb.OfferControllerTest do
  @moduledoc """
  Offer controller test
  """

  use QueroApiWeb.ConnCase, async: true

  describe "get offers test" do
    test "get offers", %{conn: conn} do
      request = get(conn, "/api/offers")
      [head | tail] = json_response(request, 200)

      assert %{
               "campus" => %{
                 "city" => "São José dos Campos",
                 "name" => "Jardim das Indústrias"
               },
               "course" => %{
                 "kind" => "Presencial",
                 "level" => "Bacharelado",
                 "name" => "Engenharia Mecânica",
                 "shift" => "Noite"
               },
               "discount_percentage" => 67.0,
               "enabled" => true,
               "enrollment_semester" => "2019.2",
               "full_price" => 2139.64,
               "price_with_discount" => 706.08,
               "start_date" => "01/08/2019",
               "university" => %{
                 "logo_url" => "https://www.tryimg.com/u/2019/04/16/unip.png",
                 "name" => "UNIP",
                 "score" => 4.5
               }
             } == head

      assert length(tail) == 24
    end
  end
end
