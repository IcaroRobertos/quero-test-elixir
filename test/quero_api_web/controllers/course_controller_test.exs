defmodule QueroApi.CourseControllerTest do
  @moduledoc """
  Course controller test
  """

  use QueroApiWeb.ConnCase, async: true

  describe "get courses tests" do
    test "get courses", %{conn: conn} do
      request = get(conn, "/api/courses")
      response = json_response(request, 200)

      IO.inspect(response)
    end
  end
end
