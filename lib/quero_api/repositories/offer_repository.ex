defmodule QueroApi.OfferRepository do
  @moduledoc """
  Offer repository
  """

  alias QueroApi.{Offer, Repo}

  def create_offer(attrs \\ %{}) do
    %Offer{}
    |> Offer.changeset(attrs)
    |> Repo.insert()
  end

  def list_offers do
    Repo.all(Offer)
    |> Repo.preload([{:course, [{:campus, :university}]}])
  end
end
