defmodule QueroApi.CourseControllerTest do
  @moduledoc """
  Course controller test
  """

  use QueroApiWeb.ConnCase, async: true

  describe "get courses tests" do
    test "get courses", %{conn: conn} do
      request = get(conn, "/api/courses")
      [head | tail] = json_response(request, 200)

      assert %{
               "campus" => %{
                 "city" => "São José dos Campos",
                 "name" => "Jardim das Indústrias"
               },
               "kind" => "Presencial",
               "level" => "Bacharelado",
               "name" => "Engenharia Mecânica",
               "shift" => "Noite",
               "university" => %{
                 "logo_url" => "https://www.tryimg.com/u/2019/04/16/unip.png",
                 "name" => "UNIP",
                 "score" => 4.5
               }
             } == head

      assert length(tail) == 24
    end

    test "filter courses by kind", %{conn: conn} do
      request = get(conn, "/api/courses", %{kind: "EaD"})
      response = json_response(request, 200)

      assert Enum.all?(response, fn item -> item["kind"] == "EaD" end)
    end

    test "filter courses by level", %{conn: conn} do
      request = get(conn, "/api/courses", %{level: "Tecnólogo"})
      response = json_response(request, 200)

      assert Enum.all?(response, fn item -> item["level"] == "Tecnólogo" end)
    end

    test "filter courses by shift", %{conn: conn} do
      request = get(conn, "/api/courses", %{shift: "Noite"})
      response = json_response(request, 200)

      assert Enum.all?(response, fn item -> item["shift"] == "Noite" end)
    end

    test "filter courses by university name", %{conn: conn} do
      request = get(conn, "/api/courses", %{university: "Anhanguera"})
      response = json_response(request, 200)

      assert Enum.all?(response, fn item -> item["university"]["name"] == "Anhanguera" end)
    end

    test "filter courses by all filters", %{conn: conn} do
      filters = %{
        university: "Anhanguera",
        kind: "Presencial",
        level: "Tecnólogo",
        shift: "Noite"
      }

      request = get(conn, "/api/courses", filters)
      response = json_response(request, 200)

      assert Enum.all?(response, fn item ->
               item["university"]["name"] == "Anhanguera" &&
                 item["kind"] == "Presencial" &&
                 item["level"] == "Tecnólogo" &&
                 item["shift"] == "Noite"
             end)
    end
  end
end
