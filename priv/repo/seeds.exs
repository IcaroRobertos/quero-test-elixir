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

  alias QueroApi.{CampusRepository, CourseRepository, OfferRepository, UniversityRepository}

  @doc """
  To populate database from a json file
  Init populate universities table
  """
  def populate(data) do
    data
    |> adapter()
    |> Enum.map(fn item ->
      UniversityRepository.create_university(item)
      |> populate_campus(item)
    end)
  end

  @doc """
  To populate campus table
  """
  def populate_campus({:ok, university}, item) do
    Enum.map(item["campus"], fn campus ->
      new_campus = Map.put_new(campus, "university_id", university.id)

      CampusRepository.create_campus(new_campus)
      |> populate_courses(campus)
    end)
  end

  @doc """
  To populate courses table
  """
  def populate_courses({:ok, campus}, item) do
    Enum.map(item["courses"], fn course ->
      new_course = Map.put_new(course, "campus_id", campus.id)

      CourseRepository.create_course(new_course)
      |> populate_offers(course)
    end)
  end

  @doc """
  To populate offers table
  """
  def populate_offers({:ok, course}, item) do
    new_offer = Map.put_new(item["offer"], "course_id", course.id)
    OfferRepository.create_offer(new_offer)
  end

  @doc """
  Function to adapter initial json to database structure
  """
  def adapter(data) do
    data
    |> get_universities()
  end

  @doc """
  Get universities from json and add campus key in map
  """
  def get_universities(data) do
    Enum.map(data, fn item -> item["university"] end)
    |> Enum.uniq()
    |> Enum.map(fn item -> Map.put_new(item, "campus", get_campus(data, item["name"])) end)
  end

  @doc """
  Get campus from json, referent to university and add courses key in map
  """
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

  @doc """
  Get courses from json, referent to campus and add offer key in map
  """
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

  @doc """
  Get offer from json, referent to course
  """
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

# Read json file
db_json = File.read!("./db.json")
# Decode json
db = Jason.decode!(db_json)
# Populate database
QueroApi.Seed.populate(db)
