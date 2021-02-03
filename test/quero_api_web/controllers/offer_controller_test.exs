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

    test "filter offers by university name", %{conn: conn} do
      request = get(conn, "/api/offers", %{university: "Anhanguera"})
      response = json_response(request, 200)

      assert length(response) == 2

      assert Enum.all?(response, fn item -> item["university"]["name"] == "Anhanguera" end)
    end

    test "filter offers by course name", %{conn: conn} do
      request = get(conn, "/api/offers", %{course: "Ciência da Computação"})
      response = json_response(request, 200)

      assert length(response) == 2

      assert Enum.all?(response, fn item -> item["course"]["name"] == "Ciência da Computação" end)
    end

    test "filter offers by kind", %{conn: conn} do
      request = get(conn, "/api/offers", %{kind: "EaD"})
      response = json_response(request, 200)

      assert length(response) == 9

      assert Enum.all?(response, fn item -> item["course"]["kind"] == "EaD" end)
    end

    test "filter offers by level", %{conn: conn} do
      request = get(conn, "/api/offers", %{level: "Bacharelado"})
      response = json_response(request, 200)

      assert length(response) == 19

      assert Enum.all?(response, fn item -> item["course"]["level"] == "Bacharelado" end)
    end

    test "filter offers by shift", %{conn: conn} do
      request = get(conn, "/api/offers", %{shift: "Virtual"})
      response = json_response(request, 200)

      assert length(response) == 9

      assert Enum.all?(response, fn item -> item["course"]["shift"] == "Virtual" end)
    end

    test "filter offers by campus city", %{conn: conn} do
      request = get(conn, "/api/offers", %{campus: "São Paulo"})
      response = json_response(request, 200)

      assert length(response) == 14

      assert Enum.all?(response, fn item -> item["campus"]["city"] == "São Paulo" end)
    end

    test "filter offers by all filters", %{conn: conn} do
      filters = %{
        university: "UNICSUL",
        course: "Ciência da Computação",
        kind: "Presencial",
        level: "Bacharelado",
        shift: "Noite",
        campus: "São Paulo"
      }

      request = get(conn, "/api/offers", filters)
      response = json_response(request, 200)

      assert length(response) == 1

      assert Enum.all?(response, fn item ->
               item["university"]["name"] == "UNICSUL" &&
                 item["course"]["name"] == "Ciência da Computação" &&
                 item["course"]["kind"] == "Presencial" &&
                 item["course"]["level"] == "Bacharelado" &&
                 item["course"]["shift"] == "Noite" &&
                 item["campus"]["city"] == "São Paulo"
             end)
    end

    test "order offers by price_with_discount asc", %{conn: conn} do
      request = get(conn, "/api/offers", %{order: "price_asc"})
      [tail | head] = json_response(request, 200)

      refute Enum.any?(verify_order(:asc, head, tail), fn item -> item == false end)
    end

    test "order offers by price_with_discount desc", %{conn: conn} do
      request = get(conn, "/api/offers", %{order: "price_desc"})
      [tail | head] = json_response(request, 200)

      refute Enum.any?(verify_order(:desc, head, tail), fn item -> item == false end)
    end
  end

  defp verify_order(:asc, [head | tail], previous) do
    [previous["price_with_discount"] <= head["price_with_discount"]] ++
      verify_order(:asc, tail, head)
  end

  defp verify_order(:desc, [head | tail], previous) do
    [previous["price_with_discount"] >= head["price_with_discount"]] ++
      verify_order(:desc, tail, head)
  end

  defp verify_order(_, [], _previous), do: []
end
