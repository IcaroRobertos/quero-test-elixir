defmodule QueroApi.OfferRepository do
  @moduledoc """
  Offer repository
  """

  import Ecto.Query

  alias QueroApi.{Offer, Repo}

  @doc """
  Create a offer
  """
  def create_offer(attrs \\ %{}) do
    %Offer{}
    |> Offer.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Returns the list of offers
  """
  def list_offers(filters) do
    from(o in Offer)
    |> filter(filters)
    |> order(filters)
    |> Repo.all()
    |> Repo.preload([{:course, [{:campus, :university}]}])
  end

  defp order(query, filters) do
    case filters["order"] do
      "price_asc" -> from(q in query, order_by: [asc: q.price_with_discount])
      "price_desc" -> from(q in query, order_by: [desc: q.price_with_discount])
      _ -> query
    end
  end

  defp filter(query, filters) do
    Enum.reduce(filters, query, fn {key, value}, query ->
      case key do
        "kind" ->
          from(q in query,
            join: course in assoc(q, :course),
            on: course.kind == ^value
          )

        "level" ->
          from(q in query,
            join: course in assoc(q, :course),
            on: course.level == ^value
          )

        "shift" ->
          from(q in query,
            join: course in assoc(q, :course),
            on: course.shift == ^value
          )

        "campus" ->
          from(q in query,
            join: course in assoc(q, :course),
            join: campus in assoc(course, :campus),
            on: campus.city == ^value
          )

        "course" ->
          from(q in query,
            join: course in assoc(q, :course),
            on: course.name == ^value
          )

        "university" ->
          from(q in query,
            join: course in assoc(q, :course),
            join: campus in assoc(course, :campus),
            join: university in assoc(campus, :university),
            on: university.name == ^value
          )

        _ ->
          query
      end
    end)
  end
end
