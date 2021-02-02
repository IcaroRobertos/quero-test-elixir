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
end
