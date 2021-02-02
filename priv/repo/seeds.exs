# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     QueroApi.Repo.insert!(%QueroApi.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

defmodule QueroApi.Seed do
  @moduledoc """
  Populate database to development
  """

  def populate(data) do
    data
    |> adapter()
    |> IO.inspect()
  end

  def adapter(data) do
    data
    |> get_universities()
  end

  def get_universities(data) do
    Enum.map(data, fn item -> item["university"] end)
    |> Enum.uniq()
    |> Enum.map(fn item -> Map.put_new(item, "campus", get_campus(data, item["name"])) end)
  end

  def get_campus(data, university) do
    Enum.map(data, fn item ->
      case item["university"]["name"] == university do
        true -> item["campus"]
        false -> nil
      end
    end)
    |> Enum.uniq()
    |> List.delete(nil)
    |> Enum.map(fn item -> Map.put_new(item, "courses", get_courses(data, university, item)) end)
  end

  def get_courses(data, university, campus) do
    Enum.map(data, fn item ->
      case item["university"]["name"] == university &&
             item["campus"]["name"] == campus["name"] &&
             item["campus"]["city"] == campus["city"] do
        true -> Map.put_new(item["course"], "offer", get_offer(item))
        false -> nil
      end
    end)
    |> Enum.uniq()
    |> List.delete(nil)
  end

  def get_offer(item) do
    %{
      "full_price" => item["full_price"],
      "price_with_discount" => item["price_with_discount"],
      "discount_percentage" => item["discount_percentage"],
      "start_date" => item["start_date"],
      "enrollment_semester" => item["enrollment_semester"],
      "enabled" => item["enabled"]
    }
  end
end

db_json = File.read!("./db.json")
db = Jason.decode!(db_json)
QueroApi.Seed.populate(db)
