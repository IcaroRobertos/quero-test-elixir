defmodule QueroApi.Offer do
  @moduledoc """
  Offer schema
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "offers" do
    field :course_id, :integer
    field :discount_percentage, :float
    field :enabled, :boolean
    field :enrollment_semester, :string
    field :full_price, :float
    field :price_with_discount, :float
    field :start_date, :string

    timestamps()
  end

  @doc false
  def changeset(offer, attrs) do
    offer
    |> cast(attrs, [
      :course_id,
      :full_price,
      :price_with_discount,
      :discount_percentage,
      :start_date,
      :enrollment_semester,
      :enabled
    ])
    |> validate_required([
      :course_id,
      :full_price,
      :price_with_discount,
      :discount_percentage,
      :start_date,
      :enrollment_semester,
      :enabled
    ])
  end
end
