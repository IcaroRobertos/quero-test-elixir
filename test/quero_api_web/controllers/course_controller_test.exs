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
  end
end
